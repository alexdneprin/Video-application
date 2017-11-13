//
//  ClipsListViewController.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 11.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import UIKit
import Foundation
import AVKit

class ClipsListViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    var coordinatorModel: ClipsListCoordinatorModel!
    var clips = [Clip]()
    var itemFiles = [File]()
    
    // ***********************
    // Clips List View

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var languageSegmentControll: UISegmentedControl!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    var currentPageNumber: Int = 0
    var isPageRefresing: Bool = false
    
    // ***********************
    // Player View

    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var resolutionVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var videoResolutionStackView: UIStackView!
    @IBOutlet weak var playerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeMessageLabel: UILabel!
    
    //MARK: - View Controller Methods -
    //*********************************************
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.setupClipsListView()
        self.setupPlayerView()
        
        /* Observe Notification from VideoPlayer */
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showPlaybackItems), name: NSNotification.Name(rawValue: Constants.kShowPlaybackItems), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.hidePlaybackItems), name: NSNotification.Name(rawValue: Constants.kHidePlaybackItems), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.closePlayerView), name: NSNotification.Name(rawValue: Constants.kClosePlayerView), object: nil)
    }
    
    
    //*********************************************
    //MARK: - CLips List View -
    //*********************************************
    
    
    func setupClipsListView(){
        
        coordinatorModel = ClipsListCoordinatorModel(coordinatorDidUpdateClipsListBlock: { [weak self] (clips, error) in
            
            guard let `self` = self else { return }
            
            if (error == nil) {
                self.clips.append(contentsOf: clips)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        coordinatorModel.loadClipsList(page: Constants.one)
        
        tableView.register(UINib.init(nibName: String(describing:ClipsListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing:ClipsListTableViewCell.self))
        
        for (index, language) in Constants.languages.enumerated() {
            self.languageSegmentControll.setTitle(language, forSegmentAt: index)
        }
        
        self.currentPageNumber = Constants.one
    }
    
    //MARK: - Actions & Selectors -
    //*********************************************
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    @objc func changeResolutionButtonPressed(sender: UIButton!) {
        
        self.hidePlaybackItems()
        
        if let idOptional = self.itemFiles[sender.tag].id{
            let idString: String!
            idString = String(describing: idOptional)
            let videoData:[String: String] = [Constants.url: idString]
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.kResolutionChanged), object: nil, userInfo: videoData)
        }
    }
}

extension ClipsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    //Mark: - UITableView Data Source -
    //*********************************************
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: ClipsListTableViewCell.self)) as! ClipsListTableViewCell
        cell.initWithItem(item: self.clips[indexPath.row], languageId: self.languageSegmentControll.selectedSegmentIndex)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return Constants.one }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return clips.count }
    
    //Mark: - UITableView Delegate -
    //*********************************************

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let idOptional: String!
        idOptional = String(describing: self.clips[indexPath.row].files.last!.id!)
        
        self.itemFiles.removeAll()
        
        for view in self.videoResolutionStackView.subviews {
            self.videoResolutionStackView.removeArrangedSubview(view)
        }
        
        self.itemFiles = self.clips[indexPath.row].files
        self.drawResolutionButtons()
        
        if let id = idOptional{
            let urlString = Constants.loadVideo + id
            let videoURL = URL(string: urlString)
            
            self.playVideoFromURL(url: videoURL!)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)) { // scroll to bottom
            
            if(self.isPageRefresing == false){
                
                isPageRefresing = true
                
                currentPageNumber += 1
                coordinatorModel.loadClipsList(page: currentPageNumber)
            }
        }
    }
}


//*********************************************
//MARK: - Player View -
//*********************************************


extension ClipsListViewController {

    func setupPlayerView(){
        
        self.closeMessageLabel.isHidden = true
        
        self.hidePlaybackItems()

        self.resolutionVisualEffectView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        
        self.playerView.isHidden = true
        self.playerViewWidthConstraint.constant = Constants.screenBounds.width
        
    }
    
    func drawResolutionButtons(){

        self.stackViewHeightConstraint.constant = CGFloat(self.itemFiles.count * Constants.resolutionButtonSize)
        
        for (position, item) in self.itemFiles.enumerated() {
            let resolutionButton = UIButton.init()
            
            resolutionButton.tag = position
            resolutionButton.setTitle(item.type, for: .normal)
            resolutionButton.titleLabel?.textColor = .black
            resolutionButton.titleLabel?.font = UIFont(name: Constants.textFont, size: CGFloat(Constants.textSize))
            
            resolutionButton.addTarget(self, action: #selector(changeResolutionButtonPressed), for: .touchUpInside)
            self.videoResolutionStackView.addArrangedSubview(resolutionButton)
        }
        
        let launchedBefore = UserDefaults.standard.bool(forKey: Constants.launchedBefore)
        if launchedBefore  {
            self.closeMessageLabel.isHidden = true
        } else {
            self.closeMessageLabel.isHidden = false
        }
        
    }
    
    //MARK: - Actions & Selectors -
    //*********************************************
    
    func hideMessage(button: UIButton){
        button.isHidden = true
    }
    
    @objc func hidePlaybackItems(){
        
        self.resolutionVisualEffectView.alpha = 1.0
        UIView.animate(withDuration: 0.4, animations: {
            self.resolutionVisualEffectView.alpha = 0.0
        })
    }
    
    @objc func showPlaybackItems(){
        
        self.resolutionVisualEffectView.alpha = 0.0
        UIView.animate(withDuration: 0.4, animations: {
            self.resolutionVisualEffectView.alpha = 1.0
        })
    }
    
    func playVideoFromURL(url: URL, time: CMTime? = nil){
        
        self.playerView.isHidden = false
        
        let videoData:[String: Any] = [Constants.url: url]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.kLoadNewVideo), object: nil, userInfo: videoData)
        
    }
    
    @objc func closePlayerView(){
        if !self.closeMessageLabel.isHidden {
            self.closeMessageLabel.text = Constants.youAwesameMessage
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000)) {
                self.closeMessageLabel.isHidden = true
            }
        } else {
            self.playerView.isHidden = true
        }
    }
    
}

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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var languageSegmentControll: UISegmentedControl!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var playerViewWidthConstraint: NSLayoutConstraint!

    var currentPageNumber: Int = 0
    var isPageRefresing: Bool = false
    
    
    //MARK: - View Controller Methods -
    //*********************************************
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.setupClipsListView()
    }
    
    
    //MARK: - Private -
    //*********************************************
    
    
    func setupClipsListView(){
        
        self.playerView.isHidden = true
        
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
        self.playerViewWidthConstraint.constant = Constants.screenBounds.width

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
        self.playerView.isHidden = false
        self.playerView.initWithItem(self.clips[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)) { // scroll to bottom
            
            if(self.isPageRefresing == false){
                
                isPageRefresing = true
                
                currentPageNumber += Constants.one
                coordinatorModel.loadClipsList(page: currentPageNumber)
            }
        }
    }
}


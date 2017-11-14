//
//  PlayerView.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 14.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import UIKit
import Foundation
import AVKit

class PlayerView: UIView {
    
    var itemFiles = [File]()
    
    @IBOutlet weak var resolutionVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var videoResolutionStackView: UIStackView!
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var tutorialLabel: UILabel!
    
    var selectedResolutionItemID: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configurePlayerView()
        
        /* Observe Notification from VideoPlayer */
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showPlaybackItems), name: NSNotification.Name(rawValue: Constants.kShowPlaybackItems), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.hidePlaybackItems), name: NSNotification.Name(rawValue: Constants.kHidePlaybackItems), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.closePlayerView), name: NSNotification.Name(rawValue: Constants.kClosePlayerView), object: nil)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.resolutionVisualEffectView.layer.cornerRadius = self.resolutionVisualEffectView.frame.height/3
    }
    
    //MARK: - Configure PlayerView-
    //*********************************************
    
    func initWithItem(_ item: Clip) {
        
        if let id = item.files.last!.id{
            let idString = String(id)
            
            self.selectedResolutionItemID = item.files.count - Constants.one
            
            self.itemFiles.removeAll()
            self.itemFiles = item.files
            self.drawResolutionButtons()
            
            let urlString = Constants.loadVideo + idString
            let videoURL = URL(string: urlString)
            
            self.playVideoFromURL(url: videoURL!)
        }
    }
    
    func configurePlayerView(){
        
        self.tutorialView.isHidden = true
        self.hidePlaybackItems()
        
        let tutorialComplete = UserDefaults.standard.bool(forKey: Constants.tutorialComplete)
        if !tutorialComplete  {
            self.tutorialSwipeSetup(Constants.up)
        }
    }
    
    func drawResolutionButtons(){
        
        for view in self.videoResolutionStackView.subviews {
            self.videoResolutionStackView.removeArrangedSubview(view)
        }
        
        for (position, item) in self.itemFiles.enumerated() {
            let resolutionButton = UIButton.init()
            resolutionButton.tag = position
            resolutionButton.setTitle(item.type, for: .normal)
            resolutionButton.titleLabel?.textColor = .black
            resolutionButton.titleLabel?.font = UIFont(name: Constants.textFont, size: CGFloat(Constants.textSize))
            resolutionButton.titleLabel?.adjustsFontSizeToFitWidth = true
            resolutionButton.titleLabel?.minimumScaleFactor = 0.5
            if position == self.selectedResolutionItemID {
                resolutionButton.backgroundColor = Constants.lightWhiteColor
            }

            resolutionButton.heightAnchor.constraint(equalToConstant: CGFloat(Constants.resolutionButtonHeight)).isActive = true
            
            resolutionButton.addTarget(self, action: #selector(changeResolutionButtonPressed), for: .touchUpInside)
            self.videoResolutionStackView.addArrangedSubview(resolutionButton)
        }
    }
    
    //MARK: - Tutorial Swipe Setup -
    //*********************************************
    
    func tutorialSwipeSetup(_ gestureDirection: String){
        
        self.tutorialView.isHidden = false
        if gestureDirection == Constants.up{
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeTutorialView))
            swipeUp.direction = UISwipeGestureRecognizerDirection.up
            self.tutorialView.addGestureRecognizer(swipeUp)
        } else if gestureDirection == Constants.down {
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeTutorialView))
            swipeDown.direction = UISwipeGestureRecognizerDirection.down
            self.tutorialView.addGestureRecognizer(swipeDown)
        }
    }
    
    @objc func respondToSwipeTutorialView(gesture: UIGestureRecognizer){
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == UISwipeGestureRecognizerDirection.up{
                self.tutorialLabel.text = Constants.swipeDownToCloseMessage
                self.tutorialSwipeSetup(Constants.down)
            } else if swipeGesture.direction == UISwipeGestureRecognizerDirection.down{
                UserDefaults.standard.set(true, forKey: Constants.tutorialComplete)
                
                self.tutorialLabel.text = Constants.youAwesameMessage
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Constants.timeDelay)) {
                    self.tutorialView.isHidden = true
                }
            }
        }
    }
    
    //MARK: - Actions & Selectors -
    //*********************************************
    
    func hideMessage(button: UIButton){
        button.isHidden = true
    }
    
    @objc func hidePlaybackItems(){
        UIView.animate(withDuration: Constants.timeDuration, animations: {
            self.resolutionVisualEffectView.alpha = CGFloat(Constants.zero)
        })
    }
    
    @objc func showPlaybackItems(){
        
        self.resolutionVisualEffectView.alpha = CGFloat(Constants.zero)
        UIView.animate(withDuration: Constants.timeDuration, animations: {
            self.resolutionVisualEffectView.alpha = CGFloat(Constants.one)
        })
    }
    
    func playVideoFromURL(url: URL, time: CMTime? = nil){
        
        let videoData:[String: Any] = [Constants.url: url]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.kLoadNewVideo), object: nil, userInfo: videoData)
    }
    
    @objc func changeResolutionButtonPressed(sender: UIButton!) {
        
        self.hidePlaybackItems()
        self.selectedResolutionItemID = sender.tag
        self.drawResolutionButtons()
        
        if let id = self.itemFiles[sender.tag].id {
            let idString = String(id)
            
            let videoData:[String: String] = [Constants.url: idString]
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.kResolutionChanged), object: nil, userInfo: videoData)
        }
    }
    
    @objc func closePlayerView(){
        self.isHidden = true
    }
    
}

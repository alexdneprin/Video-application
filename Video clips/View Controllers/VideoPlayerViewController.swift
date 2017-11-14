//
//  VideoPlayerViewController.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 11.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: AVPlayerViewController {
    
    // View Controller Methods
    //*********************************************
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.swipeSetup()

        /* Observe Notification from CLipsList View */
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadNewVideo(_:)), name: NSNotification.Name(rawValue: Constants.kLoadNewVideo), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.resolutionChanged), name: NSNotification.Name(rawValue: Constants.kResolutionChanged), object: nil)
    }
    
    
    //MARK: - TUtorial View Swipe Setup -
    //*********************************************
    
    
    func swipeSetup(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == UISwipeGestureRecognizerDirection.down{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.kClosePlayerView), object: nil, userInfo: nil)
                self.player = nil
            } else if swipeGesture.direction == UISwipeGestureRecognizerDirection.up {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.kShowPlaybackItems), object: nil, userInfo: nil)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Constants.timeDelay)) {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.kHidePlaybackItems), object: nil, userInfo: nil)
                }
            }
        }
    }
    
    
    //MARK: - Override Touch Methods -
    //*********************************************

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.showsPlaybackControls = true
        super.touchesBegan(touches, with: event)
    }
    
    
    //MARK: -  Observer Selectors -
    //*********************************************
    
    
    @objc func loadNewVideo(_ notification: NSNotification) {
        let currentTime = CMTime.init(seconds: Double(Constants.zero), preferredTimescale: CMTimeScale(Constants.one))
        let url = notification.userInfo?[Constants.url] as! URL
        self.videoLoading(url: url, time: currentTime)
    }
    
    @objc func resolutionChanged(_ notification: NSNotification) {
        
        let currentTime = self.player!.currentItem!.currentTime()
        if let stringID = notification.userInfo![Constants.url]{
            let urlString = Constants.loadVideo + String(describing: stringID)
            
            if let url: URL = URL.init(string: urlString){
                self.videoLoading(url: url, time: currentTime)
            }
        }
    }
    
    func videoLoading(url: URL, time: CMTime){
        
        self.showsPlaybackControls = false
        
        let player = AVPlayer(url: url)
        self.player = player
        
        self.player?.seek(to: time)
        self.player?.play()
        
    }
    
}


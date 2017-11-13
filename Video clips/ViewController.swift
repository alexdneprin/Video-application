//
//  ViewController.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 11.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
//    let AVPlayerVC = AVPlayerViewController()
//    var commmentQueuePlayer = AVQueuePlayer()
//    var OverlayView = UIView()
//    var prevItem:AVPlayerItem?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupCustomPlayer()
//    }
//
//    func setupCustomPlayer() {
//        AVPlayerVC.view.frame = self.view.frame
//        AVPlayerVC.view.sizeToFit()
//        AVPlayerVC.showsPlaybackControls = true
//        self.view.addSubview(AVPlayerVC.view)
//
//        let videoURL: String = "http://cdnapi.kaltura.com/p/11/sp/11/playManifest/entryId/0_6swapj1k/format/applehttp/protocol/http/a.m3u8"
//        let firstItemURL: String = "http://cdnapi.kaltura.com/p/11/sp/11/playManifest/entryId/0_2p3957qy/format/applehttp/protocol/http/a.m3u8"
//        let secondItemURL: String = "http://cdnapi.kaltura.com/p/11/sp/11/playManifest/entryId/0_buy5xjol/format/applehttp/protocol/http/a.m3u8"
//
//        let firstItem = AVPlayerItem(url: URL(string: firstItemURL)! as URL )
//        let secondItem = AVPlayerItem(url: URL(string: secondItemURL)! as URL )
//        let playerItem = AVPlayerItem(url: URL(string: videoURL)! as URL )
//        let items = [firstItem,secondItem,playerItem]
//
//        commmentQueuePlayer = AVQueuePlayer(items: items)
//
//        commmentQueuePlayer.actionAtItemEnd = .none
//        AVPlayerVC.player = commmentQueuePlayer
//
//        NotificationCenter.default.addObserver(self, selector: #selector(stopedPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
//        addContentOverlayView()
//        AVPlayerVC.player?.play()
//    }
//
//    func addContentOverlayView() {
//
//        OverlayView.frame = CGRect(x:0,y:30,width: AVPlayerVC.view.bounds.width, height: 100)
//        OverlayView.isHidden = true
//        OverlayView.backgroundColor = UIColor ( red: 0.5, green: 0.5, blue: 0.5, alpha: 0.379 )
//
//        let fFrame = CGRect(x: AVPlayerVC.view.bounds.width - 180, y: 0, width: 60, height: 44)
//
//        let btnNext = UIButton(frame:fFrame)
//        btnNext.setTitle(">>", for: [])
//        btnNext.addTarget(self, action:#selector(ViewController.playNext), for:.touchUpInside)
//        //        btnNext.layer.borderColor = UIColor ( red: 0.0, green: 0.0, blue: 1.0, alpha: 0.670476140202703 ).CGColor
//        //        btnNext.layer.borderWidth = 1.0
//        OverlayView.addSubview(btnNext)
//
//        let sFrame = CGRect(x: (AVPlayerVC.view.bounds.width/2)-40, y: 100, width: 80, height: 44)
//
//        let btnReplay = UIButton(frame:sFrame)
//        btnReplay.setTitle("Replay", for:[])
//        btnReplay.addTarget(self, action:#selector(ViewController.replayVideo), for:.touchUpInside)
//        OverlayView.addSubview(btnReplay)
//
//        let tFrame = CGRect(x: 0, y: 0, width: 80, height: 44)
//        let btnPrevious = UIButton(frame:tFrame)
//        btnPrevious.setTitle("<<", for: [])
//        btnPrevious.addTarget(self, action:#selector(ViewController.previousVideo), for:.touchUpInside)
//        OverlayView.addSubview(btnPrevious)
//
//        let foFrame = CGRect(x: (AVPlayerVC.view.bounds.width/2)-70, y: 100, width: 140, height: 44)
//        let btnComment = UIButton(frame:foFrame)
//        btnComment.setTitle("Comments", for: [])
//        btnComment.addTarget(self, action:#selector(ViewController.openComments), for:.touchUpInside)
//        OverlayView.addSubview(btnComment)
//
//        AVPlayerVC.view.addSubview(OverlayView);
//
//    }
//
//    @objc func playNext() {
//        prevItem = AVPlayerVC.player?.currentItem
//        OverlayView.isHidden = true
//        commmentQueuePlayer.advanceToNextItem()
//    }
//
//   @objc func replayVideo() {
//        OverlayView.isHidden = true
//        AVPlayerVC.player?.currentItem?.seek(to: kCMTimeZero, completionHandler: nil)
//        AVPlayerVC.player?.play()
//    }
//
//    @objc func previousVideo() {
//        OverlayView.isHidden = true
//        if prevItem != AVPlayerVC.player?.currentItem {
//            if (commmentQueuePlayer.canInsert(prevItem!, after:AVPlayerVC.player?.currentItem)) {
//                commmentQueuePlayer.replaceCurrentItem(with: prevItem)
//                prevItem = AVPlayerVC.player?.currentItem
//                replayVideo()
//            }
//        } else {
//            replayVideo()
//            //Else display alert no prev video found
//        }
//    }
//
//    @objc func openComments() {
//        //Open the comment View/VC
//    }
//
//    @objc func stopedPlaying() {
//        if prevItem == nil {
//            prevItem = AVPlayerVC.player?.currentItem
//        }
//        OverlayView.isHidden = false
//    }
//
}

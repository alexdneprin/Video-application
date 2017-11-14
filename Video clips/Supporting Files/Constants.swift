//
//  Constants.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 11.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import Foundation
import CoreGraphics // Needed for CGFloat
import UIKit // Needed for UIScreen.main.bounds, UIColor

struct Constants {
    
    //MARK: - Network  -
    //***************************************************
    
    static let get = "GET"
    
    static let baseURL = "http://dev.see.ua"
    static let page = "/?page="
    static let videoID = "/external/video?id="
    static let imageID = "/getImage.php?id="
    static let pageFirst = "1"
    static let size = "&size="
    
    static let loadPage = baseURL + page
    static let loadVideo = baseURL + videoID
    static let getImage = baseURL + imageID

    
    //MARK: - UIViewControllers -
    //***************************************************
    
    // UI
    
    static let languages = ["EN", "RU", "UA"]
    static let textFont = "Helvetica-Thin"
    static let textSize: CGFloat = 50.0
    static let cornerRadius: CGFloat = 25.0
    static let resolutionButtonSize = 44
    static let resolutionButtonHeight = 300

    static let zero = 0
    static let one = 1
    
    static let url = "url"
    static let noData = "No data"

    static let lightWhiteColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
    
    //Notification keys
    
    static let kLoadNewVideo = "kLoadNewVideo"
    static let kStopVideo = "kStopVideo"
    static let kResolutionChanged = "kResolutionChanged"
    static let kResolutionButtonsPressed = "kResolutionButtonsPressed"
    static let kClosePlayerView = "kClosePlayerView"
    static let kHidePlaybackItems = "kHidePlaybackItems"
    static let kShowPlaybackItems = "kShowPlaybackItems"
    static let kVideoPlayerClearMemory = "kShowPlaybackItems"

    
    // Screen size
    
    static let screenBounds = UIScreen.main.bounds
    static let screenScale = UIScreen.main.scale
    
    /* calculate the width of the image in pixels */
    
    static let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
    static let screenWidthString = String(describing: screenSize.width)
    
    // Messages & tutorials

    static let tutorialComplete = "tutorialComplete"
    static let swipeDownToCloseMessage = "Right! To close the video, just swipe down"
    static let youAwesameMessage = "You are awesome! Enjoy watching!)"

    // Gesture
    
    static let up = "up"
    static let down = "down"
    
    // Other
    
    static let timeDelay = 3000
    static let timeDuration = 0.4


}


//
//  Constants.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 11.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit /* this is needed for UIScreen.main.bounds */

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
    static let textSize: CGFloat = 5.0
    static let cornerRadius: CGFloat = 15.0
    static let resolutionButtonSize = 44

    static let one = 1
    
    static let url = "url"
    static let noData = "No data"

    //Notification keys
    
    static let kLoadNewVideo = "kLoadNewVideo"
    static let kStopVideo = "kStopVideo"
    static let kResolutionChanged = "kResolutionChanged"
    static let kClosePlayerView = "kClosePlayerView"
    static let kHidePlaybackItems = "kHidePlaybackItems"
    static let kShowPlaybackItems = "kShowPlaybackItems"
    static let kVideoPlayerClearMemory = "kShowPlaybackItems"

    
    // Other
    
    static let screenBounds = UIScreen.main.bounds
    static let screenScale = UIScreen.main.scale
    
    /* calculate the width of the image in pixels */
    
    static let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
    static let screenWidthString = String(describing: screenSize.width)
    
    static let launchedBefore = "launchedBefore"
    static let youAwesameMessage = "You are awesome! Enjoy watching!)"

    
}


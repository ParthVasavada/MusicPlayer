//
//  AppConstants.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 09/04/21.
//

import Foundation
import UIKit

enum Constants {
    
    static let appTitle = "iTunes Top 20 Songs"
    static let placeholderImageName = "Placeholder"
    static let entityName = "Song"
    
    static let songsURL = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=25/xml"
    
    static let entryElement = "entry"
    static let hrefKey = "href"
    static let heightKey = "height"
    static let imageHeight = "55"
    static var httpGET = "GET"
    
    enum XMLItem: Int {
        case mainTitle
        case entryArt
        case entryName
        case entryPreview
        case entryArtist
        case entryImage
    }
    
    static let XMLPaths = [ "feed.title" : XMLItem.mainTitle
                            , "feed.entry.id" : XMLItem.entryArt
                            , "feed.entry.title" : XMLItem.entryName
                            , "feed.entry.link@title,im:assetType" : XMLItem.entryPreview
                            , "feed.entry.im:artist" : XMLItem.entryArtist
                            , "feed.entry.im:image" : XMLItem.entryImage
    ]
    
}


extension UIColor {
    
    // App theme color, can be used directly.
    static var  appThemeColor: UIColor {
        return UIColor(red: 0.0/255.0, green: 100/255.0, blue: 127.0/255.0, alpha: 1.0)
    }
}

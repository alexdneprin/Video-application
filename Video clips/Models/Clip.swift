//
//  Clip.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 11.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import Foundation

import Foundation

struct Clip: Decodable {
    
    var id: Int?
    var internalName: String?
    var slug: String?
    var isPublished: Bool?
    var subtype: String?
    var descriptions: Description?
    var converting: Bool?
    var isPreview: Bool?
    var preview: Preview?
    var convertedFiles: Int?
    var files = [File]()
    
    enum CodingKeys : String, CodingKey {
        case id
        case internalName = "internal_name"
        case slug
        case isPublished = "is_published"
        case subtype
        case descriptions
        case converting
        case isPreview = "is_preview"
        case preview
        case convertedFiles = "converted_files"
        case files
    }
}

struct DataResponce: Decodable {
    var error: Int?
    var message: String?
    var data: ClipsData?
    
    enum CodingKeys : String, CodingKey {
        case error
        case message
        case data = "data_list"
    }
}

struct ClipsData: Decodable {
    var clips = [Clip]()
}

// Preview

struct Preview: Decodable {
    var id: Int?
    var filePath: String?
    var fileName: String?
    var isMain: Bool?
    
    enum CodingKeys : String, CodingKey {
        case id
        case filePath = "filepath"
        case fileName = "filename"
        case isMain = "is_main"
    }
}

// Descriptions

struct Description: Decodable {
    var en: Name?
    var ru: Name?
    var ua: Name?
}

struct Name: Decodable {
    var name: String?
}

// File

struct File: Decodable {
    var id: Int?
    var filename: String?
    var ext: String?
    var size: Float?
    var type: String?
    var date: String? //!
}

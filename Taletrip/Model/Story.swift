//
//  Stories.swift
//  Taletrip
//
//  Created by Suyash Lunawat on 17/02/22.
//

import Foundation
import SwiftUI
import SwiftSpeech
import AVFoundation

struct Story : Decodable{
    let jsonTitle : String
    let imageName: String
    let genre: Genre
    let title: String
    let titleCard : String
    let author: String
    var completionRate : Int
    var inventory: [String] = []
    var isStoryOfTheMonth : Bool
    var isStoryYouWillLike: Bool
    var hints: [String]
    var isPaused: Bool
    var completed: Bool
    var dictionaryOfButtons: [String : InteractiveButton] = [:]
    var chapters: [Chapter] = []
    var length : Longevity
    var path: [StoryChunk] = []
    var descpath: [String] = []
    var allStoryChunksDescription: [String]
    var description : String
    var showDetails : Bool = false
    
    enum CodingKeys: String, CodingKey {
        
        case imageName
        case genre
        case title
        case titleCard
        case author
        case completionRate
        case isStoryOfTheMonth
        case isStoryYouWillLike
        case hints
        case isPaused
        case completed
        case chapters
        case length
        case allStoryChunksDescription
        case description
        case jsonTitle
        
    }
    
}


//Question: Enum in another file or in the same file of the struct that use that type?

enum Genre: String , Codable {
    
    case crime
    case adventure
    case mystery
    var label: String{
        switch self {
        case .crime:
            return String(localized: "Crime")
        case .adventure:
            return String(localized: "Adventure")
        case .mystery:
            return String(localized: "Mystery")
        }
    }
    
}

enum Longevity: String ,Codable{
    
    case brief
    case medium
    case long
    var label: String {
        switch self {
        case .brief:
            return String(localized: "Brief")
        case .medium:
            return String(localized: "Medium")
        case .long:
            return String(localized: "Long")
        }
    }
    
    
    func associatedColor() -> Color{
        
        switch self {
            
        case .brief : return  Color.briefGreen
        case .medium : return Color.mediumOrange
        case .long : return Color.longRed
            
        }
    }
    
    
    func associatedTime() -> String{
        
        switch self {
            
        case .brief :
            return String(localized: "30 MIN")
        case .medium :
            return String(localized: "60 MIN")
        case .long :
            return String(localized: "120 MIN")
        }
    }

}



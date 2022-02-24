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
    
    let imageName: String
    let genre: Genre
    let title: String
    let titleCard : String
    let author: String
    var completionRate : Int
    var inventory: [String]
    var isStoryOfTheMonth : Bool
    var isStoryYouWillLike: Bool
    var hints: [String]
    var isPaused: Bool
    var completed: Bool
    var dictionaryOfButtons: [String : InteractiveButton] = [:]
    var chapters:[Chapter] = []
    var length : Longevity
    var path: [StoryChunk] = []
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
        case inventory
        case isStoryOfTheMonth
        case isStoryYouWillLike
        case hints
        case isPaused
        case completed
        case chapters
        case length
        case allStoryChunksDescription
        case description
        
    }
    
}


//Question: Enum in another file or in the same file of the struct that use that type?

enum Genre: String , Codable {
    
    case crime = "Crime"
    case adventure = "Adventure"
    case mystery = "Mystery"
    
}

enum Longevity: String ,Codable{
    
    case brief = "Brief"
    case medium = "Medium"
    case long = "Long"
    
    
    func associatedColor() -> Color{
        
        switch self {
            
        case .brief : return  Color.briefGreen
        case .medium : return Color.mediumOrange
        case .long : return Color.longRed
            
        }
    }
    
    
    func associatedTime() -> String{
        
        switch self {
            
        case .brief : return  "30 MIN"
        case .medium : return "60 MIN"
        case .long : return "120 MIN"
            
        }
    }

}



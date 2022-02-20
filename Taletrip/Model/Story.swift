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
    let author: String
    var completionRate : Int
    var inventory: [String]
    var isStoryOfTheMonth : Bool
    var isStoryYouWillLike: Bool
    var hints: [String]
    var isPaused: Bool
    var completed: Bool
    let chapters:[Chapter]
    var length : Longevity
    
    //  VoiceRecognition stuff
    
    //Question: does the voice recognition stuff stay in the story or outside? maybe in the ModelView?
    
//    let storedAnswers : [(session: SwiftSpeech.Session, text: String)]   //Array that contains all the responses that the user give
//    var currentAnswer : (session: SwiftSpeech.Session, text: String)?  {
//
//        if !storedAnswers.isEmpty{
//
//            return storedAnswers[storedAnswers.count - 1]
//        }
//
//        return nil
//
//    }
    
    
    enum CodingKeys : String,CodingKey {
        
        case imageName
        case genre
        case title
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
        
        
    }
    
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        
        self.imageName = try values.decode(String.self, forKey: .imageName)
        self.genre = try values.decode(Genre.self, forKey: .genre)
        self.title = try values.decode(String.self, forKey: .title)
        self.author = try values.decode(String.self, forKey: .author)
       
        self.completionRate = try values.decode(Int.self, forKey: .completionRate)
        self.inventory = try values.decode([String].self, forKey: .inventory)
        self.isStoryOfTheMonth = try values.decode(Bool.self, forKey: .isStoryOfTheMonth)
        self.isStoryYouWillLike = try values.decode(Bool.self, forKey: .isStoryYouWillLike)
        self.hints = try values.decode([String].self, forKey: .hints)
        self.isPaused = try values.decode(Bool.self, forKey: .isPaused)
        self.completed = try values.decode(Bool.self, forKey: .completed)
        self.chapters = try values.decode([Chapter].self, forKey: .chapters)
        self.length = try values.decode(Longevity.self, forKey: .length)
//        self.storedAnswers = []
        
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
}


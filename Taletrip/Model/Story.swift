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
    var path: [String]
    
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


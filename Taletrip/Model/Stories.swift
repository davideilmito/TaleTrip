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

struct Story {
    let imageName: String
    let genre: Genre
    let title: String
    let author: String
    let soundtrack: String?
    var completionRate : Int
    var inventory: [String]
    var isStoryOfTheMonth : Bool
    var isStoryYouWillLike: Bool
    var hints: [String]
    var isPaused: Bool
    var completed: Bool
    var commands: [Command]

    //  VoiceRecognition stuff
    
    let storedAnswers : [(session: SwiftSpeech.Session, text: String)]   //Array that contains all the responses that the user gave
    
    var currentAnswer : (session: SwiftSpeech.Session, text: String)  {
    
        return storedAnswers[storedAnswers.count - 1]
    
    }
    
    
    
    
}


//Question: Enum in another file or in the same file of the struct that use that type?

enum Genre {
    
    case crime
    case adventure
    case mystery
    
}


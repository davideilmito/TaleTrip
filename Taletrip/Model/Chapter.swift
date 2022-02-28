//
//  Chapters.swift
//  Taletrip
//
//  Created by Davide Biancardi on 17/02/22.
//

import Foundation

struct Chapter : Decodable {
    
    let name: String
    var storyChunks: [StoryChunk]
    let trigger: TriggerForNextChapter
        
}

struct TriggerForNextChapter: Decodable{
    
    let indicesDescriptionInPath : [Int]
    
    let indexOfTheStory: Int
    
}

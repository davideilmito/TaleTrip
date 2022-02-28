//
//  Command.swift
//  Taletrip
//
//  Created by Suyash Lunawat on 17/02/22.
//

import Foundation


struct Command : Decodable,Identifiable{
    
    var id = UUID()
    var howManyTimes : Int = 0
    let sfSymbol : String
    let name: String
    let descriptionToBeDisplayed : String
    var possibleStoryChunk: [StoryChunk] = []
    var arrayIndexOfTheStory : [Int]     
    var hasToBeDisplayed: Bool
    var isFaded: Bool {
        
        howManyTimes >= arrayIndexOfTheStory.count
        
    }
    
    enum CodingKeys: String, CodingKey {
        
        case sfSymbol
        case name
        case descriptionToBeDisplayed
        case arrayIndexOfTheStory
        case hasToBeDisplayed
        
    
    }
    
    
    
}



//
//  Command.swift
//  Taletrip
//
//  Created by Suyash Lunawat on 17/02/22.
//

import Foundation


struct Command : Decodable{
    
    
    var howManyTimes : Int = 0
    let sfSymbol : String
    let name: String
    var  possibleStoryChunk: [StoryChunk] = []
    var hasToBeDisplayed: Bool
    var isFaded: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case sfSymbol
        case name
//        case possibleStoryChunk
        case hasToBeDisplayed
        case isFaded
    
    }
    
    
    
}



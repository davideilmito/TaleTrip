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
    let arrayIndexOfTheStory: [Int]
    var hasToBeDisplayed: Bool
    var isFaded: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case sfSymbol
        case name
        case arrayIndexOfTheStory
        case hasToBeDisplayed
        case isFaded
    
    }
    
    
    
}



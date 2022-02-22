//
//  Command.swift
//  Taletrip
//
//  Created by Suyash Lunawat on 17/02/22.
//

import Foundation


struct Command : Decodable{
    
    let sfSymbol : String
    let name: String
    let arrayIndexOfTheStory: [Int]
    var hasToBeDisplayed: Bool
    var isFaded: Bool     
    
}



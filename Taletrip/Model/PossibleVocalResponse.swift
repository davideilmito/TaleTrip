//
//  PossibleVocalResponse.swift
//  Taletrip
//
//  Created by Davide Biancardi on 17/02/22.
//

import Foundation


struct PossibleVocalResponse : Decodable{
    
    let description: String
    let descriptionToBeDisplayed : String
    let arrayIndexOfTheStory : [Int]
    
}

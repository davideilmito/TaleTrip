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
    var chapters:[Chapter] = []
    var length : Longevity
    var path: [String]
    var description : String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
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
    
    
    func associatedTime() -> Int{
        
        switch self {
            
        case .brief : return  30
        case .medium : return 60
        case .long : return 120
            
        }
    }

}


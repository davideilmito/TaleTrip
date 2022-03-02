//
//  StoryChunks.swift
//  Taletrip
//
//  Created by Suyash Lunawat on 17/02/22.
//

import Foundation

struct StoryChunk : Decodable , Identifiable,Hashable{
    static func == (lhs: StoryChunk, rhs: StoryChunk) -> Bool {
        
        lhs.description  == rhs.description
        
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(description)
    }
    
    let id = UUID()
    let description : String
    let possibleVocalResponses : [PossibleVocalResponse]
    var interactiveButtons : [InteractiveButton]
    let doesAdvanceHint : Bool = false
    let objectGiven : String?
    let objectTaken : String?
    
   
    enum CodingKeys: String, CodingKey {
        
        case description
        case possibleVocalResponses
        case interactiveButtons
        case objectGiven
        case objectTaken
    
    }
    
    
    
     
}

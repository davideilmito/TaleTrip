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
    let givesObject : String = " "
    
    var objectGiven: String?{ //REMEMBER THAT THIS IS THE VARIABLE  TO ASK FOR THE OBJECT
        
        if (self.givesObject == ""){
            
            return nil
            
        }else{
            
            return self.givesObject
            
        }
        
    }
    enum CodingKeys: String, CodingKey {
        
        case description
        case possibleVocalResponses
        case interactiveButtons
    
    }
    
    
    
     
}

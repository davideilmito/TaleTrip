//
//  StoryChunks.swift
//  Taletrip
//
//  Created by Suyash Lunawat on 17/02/22.
//

import Foundation

struct StoryChunk : Decodable , Identifiable{
    
    let id = UUID()
    let description : String
    let possibleVocalResponses : [PossibleVocalResponse]
    let interactiveButtons : [InteractiveButton]
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

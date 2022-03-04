//
//  InteractiveButtons.swift
//  Taletrip
//
//  Created by Davide Biancardi on 17/02/22.
//

import Foundation

struct InteractiveButton : Decodable,Identifiable {
    
    let id = UUID()
    let name: String
    var listOfCommands : [Command]
    let isObject: Bool
    var isTappable: Bool {
        
        get {if (listOfCommands.allSatisfy({ $0.isFaded == true })){
            
            return false
            
        }else {
            
            return true
            
        }
            
        }
        
        
    }
        
    
    enum CodingKeys: String, CodingKey {
        
        case name
        case listOfCommands
        case isObject
    
    }
    
}

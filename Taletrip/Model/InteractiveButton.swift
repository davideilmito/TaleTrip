//
//  InteractiveButtons.swift
//  Taletrip
//
//  Created by Davide Biancardi on 17/02/22.
//

import Foundation

struct InteractiveButton : Decodable {
    
    let name: String
    let listOfCommands : [Command]
    var isTappable: Bool
    
}

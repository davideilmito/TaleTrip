//
//  Chapters.swift
//  Taletrip
//
//  Created by Davide Biancardi on 17/02/22.
//

import Foundation


struct Chapter : Decodable {
    
    let name: String
    let storyChunks: [StoryChunk]
    
}


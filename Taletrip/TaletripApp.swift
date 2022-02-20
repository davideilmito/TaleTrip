//
//  TaletripApp.swift
//  Taletrip
//
//  Created by Willy Merlet on 07/02/22.
//

import SwiftUI

@main
struct TaletripApp: App {
    
    @StateObject var ViewModel = StoriesStore()
    
    var body: some Scene {
         
        WindowGroup {
//            ComeView()
   
            LargeCard(storyImageName: "themortalportrait", storyType: .mystery, length: .medium, storyTitle: "the\ndetective's\nday off")
        
        }
    }
}

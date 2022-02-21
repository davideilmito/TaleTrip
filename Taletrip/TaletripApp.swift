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
           ComeView()
   
            LargeCard(storyImageName: ViewModel.stories[0].imageName, storyType: ViewModel.stories[0].genre, length: ViewModel.stories[0].length, storyTitle: ViewModel.stories[0].title)
        
        }
    }
}

//
//  StoryOfTheMonthView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 21/02/22.
//

import SwiftUI

struct HighlightedCardView: View {
    
    let storyToBeHighlighted : Story
    
    let title: String  //Story of the month or story you'll like
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12){
            
            TextView(title:title,size: 21,weight: .semibold)
            
            LargeCard(storyImageName: storyToBeHighlighted.imageName, storyType: storyToBeHighlighted.genre, length: storyToBeHighlighted.length, storyTitle: storyToBeHighlighted.titleCard)
            
        }
        
    }
    
}

struct StoryOfTheMonthView_Previews: PreviewProvider {
    
    static let dummyStory = StoriesStore()
    
    static var previews: some View {
        HighlightedCardView(storyToBeHighlighted: dummyStory.storyYouWillLike!,title: "Story Of The Month")
    }
}

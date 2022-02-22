//
//  HorizontalCardsView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 21/02/22.
//

import SwiftUI

struct HorizontalCardsView: View {
    
    let stories : [Story]
    let title: String
    
    var body: some View {
        
        //    PLEASE NOTE :   WE CANNOT HAVE STORY WITH THE SAME TITLE
        
        
        VStack(alignment: .leading, spacing: 12){
            
            TextView(title:title,size: 21,weight: .semibold)
               
              
            ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing: 12){
                
                ForEach(stories,id: \.title){story in
                    
                    SmallCardView(storyImageName: story.imageName, storyTitle: story.title, length: story.length)
                        
                    
                }
                
            }
        }
        }
        
    }
}



struct HorizontalCardsView_Previews: PreviewProvider {
    static var storiesStore = StoriesStore()
    
    static var previews: some View {
        HorizontalCardsView(stories: storiesStore.adventureStories,title: "Adventure")
    }
}

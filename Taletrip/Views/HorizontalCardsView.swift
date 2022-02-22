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
    @Binding var showModal : Bool
    @EnvironmentObject var storiesStore : StoriesStore
    
    
    var body: some View {
        
        //  PLEASE NOTE :  WE CANNOT HAVE STORIES WITH THE SAME TITLE
        
        VStack(alignment: .leading, spacing: 12){
            
            TextView(title:title,size: 21,weight: .semibold)
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing: 12){
                    
                    ForEach(stories,id: \.title){story in
                        
                        SmallCardView(storyImageName: story.imageName, storyTitle: story.title, length: story.length)
                            .onTapGesture {
                                showModal.toggle()
                                storiesStore.showStory(of: story)
                                
                            }
                        
                    }
                    
                }
            }
            
        }
        
    }
}



struct HorizontalCardsView_Previews: PreviewProvider {
    static var storiesStore = StoriesStore()
    
    static var previews: some View {
        HorizontalCardsView(stories: storiesStore.adventureStories,title: "Adventure",showModal: .constant(true))
    }
}

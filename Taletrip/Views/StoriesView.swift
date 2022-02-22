//
//  HomeView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 21/02/22.
//

import SwiftUI

struct StoriesView: View {
    
    @StateObject var storiesStore = StoriesStore()
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            
            VStack(alignment: .leading, spacing: 35){
                
                
                //             Story Of the  Month
                TextView(title: "Stories",size: 37,weight: .bold)
                
                if let storyOfTheMonth = storiesStore.storyOfTheMonth{
                    
                    HighlightedCardView(storyToBeHighlighted: storyOfTheMonth,title: "Story Of The Month")
                    
                }
                
            }.frame(maxWidth:.infinity,alignment: .leading)
                .padding(.leading,40)
            
                
                
                //             All Adventures
   
                HorizontalCardsView(stories: storiesStore.adventureStories,title: "Adventure")
                .frame(maxWidth:.infinity,alignment: .leading)
                    .padding(.leading,40)
                
                
            VStack(alignment: .leading, spacing: 35){
                
                //             Story You will Like
                if let storyYouWillLike = storiesStore.storyYouWillLike{
                    
                    HighlightedCardView(storyToBeHighlighted: storyYouWillLike,title: "Story You'll Like")
                    
                }
                
                
        }.frame(maxWidth:.infinity,alignment: .leading)
            .padding(.leading,40)
            
            
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}

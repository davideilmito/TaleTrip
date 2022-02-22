//
//  HomeView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 21/02/22.
//

import SwiftUI

struct StoriesView: View {
    
    init() {
        UITableView.appearance().separatorStyle = .singleLine
       }

    @StateObject var storiesStore = StoriesStore()
    
    var body: some View {

        NavigationView{
            ScrollView(showsIndicators: false){
                
                VStack(alignment: .leading, spacing: 35){
                    
                    
                    //    Story Of the  Month
                    TextView(title: "Stories",size: 37,weight: .bold)
                        .padding(.leading,40)
                    
                    if let storyOfTheMonth = storiesStore.storyOfTheMonth{
                        
                        HighlightedCardView(storyToBeHighlighted: storyOfTheMonth,title: "Story Of The Month")
                            .padding(.leading,40)
                        
                    }
                    
                
                
                    
                    
                    //    All Adventures
       
                    HorizontalCardsView(stories: storiesStore.adventureStories,title: "Adventure")
                    
                    
                    
                    
                    //             Story You will Like
                    if let storyYouWillLike = storiesStore.storyYouWillLike{
                        
                        HighlightedCardView(storyToBeHighlighted: storyYouWillLike,title: "Story You'll Like")
                            .padding(.leading,40)
                        
                    }
                    
                
            }.frame(maxWidth:.infinity,alignment: .leading)
                    .navigationBarHidden(true)
                   
                
                
            }
        }.padding(.top, 1)
        
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}


struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}

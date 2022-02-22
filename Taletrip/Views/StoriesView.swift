//
//  HomeView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 21/02/22.
//

import SwiftUI

struct StoriesView: View {
    
    @StateObject var storiesStore = StoriesStore()
    
    
    @State var showModal : Bool = false
    
    init() {
        
        UITableView.appearance().separatorStyle = .singleLine
        
    }
    
    
    var body: some View {
        
        NavigationView{
            
            ScrollView(showsIndicators: false){
                
                VStack(alignment: .leading, spacing: 35){
                    
                    TextView(title: "Stories",size: 37,weight: .bold)
                    
                    //   Story You will Like
                    if let storyYouWillLike = storiesStore.storyYouWillLike{
                        
                        HighlightedCardView(storyToBeHighlighted: storyYouWillLike,title: "Story You'll Like")
                            .onTapGesture {
                                showModal.toggle()
                                storiesStore.showStory(of: storyYouWillLike)
                                
                            }
                        
                    }
                    
                    //    All Adventures
                    
                    HorizontalCardsView(stories: storiesStore.adventureStories,title: "Adventure",showModal: $showModal)
                    
                    //    Story Of the  Month
                   
                    if let storyOfTheMonth = storiesStore.storyOfTheMonth{
                        
                        HighlightedCardView(storyToBeHighlighted: storyOfTheMonth,title: "Story Of The Month")
                            .onTapGesture {
                                showModal.toggle()
                                storiesStore.showStory(of: storyOfTheMonth)
                                
                            }
                        
                    }
                    
                }.frame(maxWidth:.infinity,alignment: .leading)
                    .padding(.leading,40)
                    .navigationBarHidden(true)
                
            }.fullScreenCover(isPresented: $showModal){
                
                
                DescriptionStoryView(story: storiesStore.tappedStory!,showModal: $showModal)
                
                
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
        modifier(HiddenNavigationBar())
    }
}

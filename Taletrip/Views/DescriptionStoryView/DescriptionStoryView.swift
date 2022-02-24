//
//  DescriptionView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 22/02/22.
//

import SwiftUI

struct DescriptionStoryView: View {
    
    let story: Story
    @Binding var showModal : Bool
    @EnvironmentObject var storiesStore : StoriesStore
    
    
    var body: some View {
        
        NavigationView{
            ZStack{
            ScrollView(.vertical,showsIndicators: false){
            
 
                VStack(spacing: 10){
                    
                    DescriptionImageView(imageName: story.imageName)
            
                    DescriptionTextView(descriptionOfTheStory: story.description, titleOfTheStory: story.title, genre: story.genre.rawValue,author:story.author)
                    
                    Spacer()
                    
                    NavigationLink(destination: BookView(story: story)) {
                        
                        SuyashButton(textOfTheButton: "Play", sfSymbol: "play.fill")
                            
                              
                            .padding(.bottom,22)
                    }.simultaneousGesture(TapGesture().onEnded({ _ in
                        storiesStore.firstChunkInPath(of: story)
                        print(storiesStore.stories[0].path)
                    
                    }))
                    
                        
                    }
                    
                
                    
   
                }
                StatusBarDescriptionStoryView(lengthOfTheStory: story.length,showModal: $showModal)
                    
                
                
                
            }.ignoresSafeArea()
                .background(Color.backgroundBeige)
                .navigationTitle("")
                .navigationBarHidden(true)
        }.statusBar(hidden: true)
        
        
    }
    
    
}




struct DescriptionStoryView_Previews: PreviewProvider {
    
    static var viewModel = StoriesStore()
    
    static var previews: some View {
        
        DescriptionStoryView(story: viewModel.stories[1],showModal: .constant(true))
        
    }
}

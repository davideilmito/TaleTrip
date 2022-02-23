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
    
    var body: some View {
        
        NavigationView{
            ZStack{
            ScrollView(.vertical,showsIndicators: false){
            
               
                
                VStack(spacing: 10){
                    
                    DescriptionImageView(imageName: story.imageName)
            
                    DescriptionTextView(descriptionOfTheStory: story.description, titleOfTheStory: story.title, genre: story.genre.rawValue,author:story.author)
                    
                    Spacer()
                    
                    NavigationLink(destination: Text(story.title)) {
                        
                        SuyashButton(textOfTheButton: "Play", sfSymbol: "play.fill")
                            .padding(.bottom,22)
                    }
                    
                        
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

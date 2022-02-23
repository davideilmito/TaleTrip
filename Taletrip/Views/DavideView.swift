//
//  DavideView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 23/02/22.
//

import SwiftUI




struct DavideView: View {
    
    @EnvironmentObject var storiesStore : StoriesStore
    
    var story : Story
    
    var body: some View {
        
        
        ForEach(storiesStore.tappedStory.path){ storyChunk in
            
            VStack{
                
                Text(storyChunk.description)
                
                ForEach(storyChunk.interactiveButtons){ button in
                    
                    HStack {
                        
                        
                        if(button.isTappable){
                            
                            Menu(button.name){
                                
                                ForEach(button.listOfCommands){ command in
                                    
                                    Button {
                                        
                                        storiesStore.nextChunk(command.arrayIndexOfTheStory[command.howManyTimes],story)
                                        
                                    } label: {
                                        
                                        Text(command.name)
                                            .font(.system(size: CGFloat(20), weight: .regular , design: .serif))
                                            .opacity(command.isFaded ? 40: 100)
                                        
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                    }
                }
                
                
                
            }
            
            
            
        }
        
    }
    
    
    
    
    
    
    
}




//struct DavideView_Previews: PreviewProvider {
//
//    static var viewModel = StoriesStore()
//
//    static var previews: some View {
//        DavideView(story: viewModel.stories[0])
//    }
//}

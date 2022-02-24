//
//  GameView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 24/02/22.
//

import SwiftUI

struct GameView: View {

    @EnvironmentObject var storiesStore: StoriesStore
    let story : Story
    
    var body: some View {


        ScrollView{

            ScrollViewReader{ value in

                ForEach(storiesStore.tappedStory.path){ storyChunk in


                    TextView(title: storyChunk.description, size: 20, weight: .regular)


                    ForEach(storyChunk.interactiveButtons){ button in

                        HStack{

                            Menu(button.name){

                                ForEach(button.listOfCommands){ command in

                                    if !command.isFaded{
                                    Button {
                                        
                                        storiesStore.nextPieceOfStory(from: storyChunk, command, button)
                                    
                                    } label: {
                                        
                                        Label(command.name,systemImage: command.sfSymbol)
                                            
                                    }

                                }
                                    else {
                                        
                                        Button {
                                            
                                           
                                        } label: {
                                            
                                            Text("")
                                        }
                                        
                                    }
                                }


                            }


                        }

                    }


                }

                .onAppear {
                    value.scrollTo(storiesStore.tappedStory.path, anchor: .center
                    )
                }

            }

            .navigationBarTitle(story.title)
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}

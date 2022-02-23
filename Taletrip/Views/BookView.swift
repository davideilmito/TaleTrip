////
////  BookView.swift
////  Taletrip
////
////  Created by Davide Biancardi on 23/02/22.
////
//
//import SwiftUI
//
//struct BookView: View {
//    
//    let story: Story
//    @EnvironmentObject var  storiesStore : StoriesStore
//    
//    struct CustomWords: Identifiable {
//        let id = UUID()
//        var text: String
//        var isButton: InteractiveButton?
//        
//        init(text: String,chunkButtons:[InteractiveButton]) {
//        //          FIND A BETTER WAY LATER
//            
//            
//            if (chunkButtons     .contains(text)) {
//                        self.isButton = true
//                        self.text = text
//                    }
//                    else {
//                        self.isButton = false
//                        self.text = text
//                    }
//  
//    }
//    
//    struct CustomLine: Identifiable {
//        let id = UUID()
//        var words: [CustomWords]
//    }
//    
//     func stringtoLine(words: [String], start: Int) -> ([CustomWords], Int) {
//        var num = start
//        var end = start
//        var length = 0
//        var tempLine : [CustomWords] = []
//        while (num <= words.count - 1 && (length + words[num].count <= 35 || words[num].count == 1) ) {
//            tempLine.append(CustomWords(text: words[num]))
//            length += words[num].count + 1
//            end = num + 1
//            num += 1
//        }
//        return (tempLine, end)
//    }
//    
//     func stringtoParagraph(chunk: StoryChunk) -> ([CustomLine]) {
//         
//        var string = chunk.description.components(separatedBy: " ")
//        var num = 0
//        var index = 0
//        var tempParagraph : [CustomLine] = []
//        while (num <= words.count - 1) {
//            let result = stringtoLine(words: string, start: index)
//            tempParagraph.append(CustomLine(words: result.0))
//            index = result.1
//            num = result.1
//        }
//        return tempParagraph
//    }
//    
//    func getCommands(button: String, story: Story) -> ([String], [StoryChunk]) {
//   
//           var text: [String] = []
//           var NextStoryChunk: [StoryChunk] = []
//   
//           if let commands = storiesStore.getListOfButtons(story, button){
//   
//               for command in commands{
//   
//                   text.append(command.name)
//                   NextStoryChunk.append(command.possibleStoryChunk.first!)
//   
//               }
//   
//   
//           }
//           return (text, NextStoryChunk)
//   
//       }
//    
//    
//    var body: some View {
//        
//        
// //remember to add the firs story chunk to path
//        NavigationView{
//            
//            
//            ScrollView{
//                
//  
//                ForEach(story.path) {storyChunk in
//                    let paragraph = stringtoParagraph(words: storyChunk.description.components(separatedBy: " "))
//                   
//                    LazyVStack(alignment: .leading, spacing: 3) {
//                        ForEach(paragraph) { line in
//                            HStack(spacing: 3) {
//                                ForEach(line.words) { word in
//                                    if(word.isButton == true) {
//                                        let commands = getCommands(button: word.text,story: story)
//                                        Menu("\(word.text)") {
//                                            Button("\(commands.0[0])", action: {
//                                                                   //CHECKS IF IT'S A BLANK COMMAND
////
//                                                storiesStore.appendStoryChunkToPath(storyChunk: commands.1[0], story: story)
//                                                //story.path.append(commands.1[0])      //DOES THE ACTION
////                                                    currentstoryIndex = commands.1[0]
//                                                
//                                            })
//                                            //                                            IF STATEMENT TO GET NUMBER OF BUTTON
//                                            //                                            Button("\(commands.0[1])", action: {
//                                            //                                                if(commands.1[1] != -1) {
//                                            //                                                    storyIndexes.append(commands.1[1])
//                                            //                                                    currentstoryIndex = commands.1[0]
//                                            //                                                }
//                                            //                                            })
//                                            //                                            Button("\(commands.0[2])", action: {
//                                            //                                                if(commands.1[2] != -1) {
//                                            //                                                    storyIndexes.append(commands.1[2])
//                                            //                                                    currentstoryIndex = commands.1[0]
//                                            //                                                }
//                                            //                                            })
//                                        }
//                                        .font(.system(size: 20, weight: .regular, design: .serif))
//                                        .foregroundColor(.white)
//                                        .padding(3)
//                                        .background(Color.briefGreen)
//                                        .cornerRadius(12)
//                                    }
//                                    else {
//                                        Text("\(word.text)")
//                                            .font(.system(size: 20, weight: .regular, design: .serif))
//                                            .foregroundColor(.black)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    .padding([.bottom])
//                    .frame(width: UIScreen.main.bounds.width - 64)
//                }
//            }
//            
//            
//            
//            
//            
//            
//        }
//        
//        .navigationTitle(story.title)
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItemGroup(placement: .bottomBar) {
//                Button(action: {
//                    print("Pressed 1")
//                }) {
//                    Image(systemName: "lightbulb")
//                }
//                Spacer()
//                Button(action: {
//                    print("Pressed 2")
//                }) {
//                    Image(systemName: "mic")
//                }
//                Spacer()
//                Button(action: {
//                    print("Pressed 3")
//                }) {
//                    Image(systemName: "archivebox")
//                }
//            }
//        }
//        
//        .accentColor(Color.suyashBlue)
//        
//        
//        
//    }
//    
//    
//    
//    
//    
//}
//
//
//
//
//
//}
//
//struct BookView_Previews: PreviewProvider {
//    
//    static var viewModel : StoriesStore = StoriesStore()
//    
//    static var previews: some View {
//        BookView(story: viewModel.stories[0])
//    }
//}

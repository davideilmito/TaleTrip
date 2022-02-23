////
////  GameView.swift
////  Taletrip
////
////  Created by Eugenio Raja on 22/02/22.
////
//
//import SwiftUI
//
//struct GameView: View {
//    
//    @StateObject var storiesStore = StoriesStore()
//    @State var currentstoryIndex = 0
//    @State var storyIndexes = [0]
//    
////    let story: Story
//    
//    struct CustomWords: Identifiable {
//        let id = UUID()
//        var text: String
//        let isButton: Bool
//        
//        init(text: String) {
////          FIND A BETTER WAY LATER
//            if (text == "jukebox" || text == "bar" || text == "John" || text == "bartender" || text == "CJ" || text == "Rob" || text == "ladies" || text == "Veronica" || text == "Jessica" || text == "Omar" || text == "guy" || text == "vial" || text == "drink" || text == "toilets" || text == "counter" || text == "medal" || text == "police" || text == "cigarette" || text == "players" || text == "Puzzl1es" || text == "Beerg1arden" || text == "map") {
//                self.isButton = true
//                self.text = text
//            }
//            else {
//                self.isButton = false
//                self.text = text
//            }
//        }
//    }
//
//    struct CustomLine: Identifiable {
//        let id = UUID()
//        var words: [CustomWords]
//    }
//    
//    static func stringtoLine(words: [String], start: Int) -> ([CustomWords], Int) {
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
//    static func stringtoParagraph(words: [String]) -> ([CustomLine]) {
//        var num = 0
//        var index = 0
//        var tempParagraph : [CustomLine] = []
//        while (num <= words.count - 1) {
//            let result = stringtoLine(words: words, start: index)
//            tempParagraph.append(CustomLine(words: result.0))
//            index = result.1
//            num = result.1
//        }
//        return tempParagraph
//    }
//    
//    func getCommands(button: String, story: Story) -> ([String], [Int]) {
//        
//        var text: [String] = []
//        var indextogoto: [Int] = []
//    
//        if let commands = storiesStore.getListOfButtons(story, button){
//            
//            for command in commands{
//                
//                text.append(command.name)
//                indextogoto.append(command.arrayIndexOfTheStory.first!)
//                
//            }
//            
//            
//        }
//        return (text, indextogoto)
//      
//    }
//    
//    var body: some View {
//        NavigationView {
//            ScrollView(showsIndicators: true) {
//                ForEach(storiesStore.stories[0].path, id: \.self) {index in
//                    let paragraph: [GameView.CustomLine] = GameView.stringtoParagraph(words: storiesStore.stories[0].allStoryChunksDescription[index].components(separatedBy: " "))
//                    LazyVStack(alignment: .leading, spacing: 3) {
//                        ForEach(paragraph) { line in
//                            HStack(spacing: 3) {
//                                ForEach(line.words) { word in
//                                    if(word.isButton == true) {
//                                        let commands = getCommands(button: word.text,story: storiesStore.stories[0])
//                                        Menu("\(word.text)") {
//                                            Button("\(commands.0[0])", action: {
//                                                if(commands.1[0] != -1) {                   //CHECKS IF IT'S A BLANK COMMAND
//                                                    storiesStore.stories[0].path.append(commands.1[0])      //DOES THE ACTION
//                                                    currentstoryIndex = commands.1[0]
//                                                }
//                                            })
////                                            IF STATEMENT TO GET NUMBER OF BUTTON
////                                            Button("\(commands.0[1])", action: {
////                                                if(commands.1[1] != -1) {
////                                                    storyIndexes.append(commands.1[1])
////                                                    currentstoryIndex = commands.1[0]
////                                                }
////                                            })
////                                            Button("\(commands.0[2])", action: {
////                                                if(commands.1[2] != -1) {
////                                                    storyIndexes.append(commands.1[2])
////                                                    currentstoryIndex = commands.1[0]
////                                                }
////                                            })
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
//            .navigationTitle("The Detective's day off")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItemGroup(placement: .bottomBar) {
//                    Button(action: {
//                        print("Pressed 1")
//                    }) {
//                        Image(systemName: "lightbulb")
//                    }
//                    Spacer()
//                    Button(action: {
//                        print("Pressed 2")
//                    }) {
//                        Image(systemName: "mic")
//                    }
//                    Spacer()
//                    Button(action: {
//                        print("Pressed 3")
//                    }) {
//                        Image(systemName: "archivebox")
//                    }
//                }
//            }
//        }
//        .accentColor(Color.suyashBlue)
//        
//    }
//}
//
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
//

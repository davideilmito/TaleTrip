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
//    @EnvironmentObject var storiesStore : StoriesStore
//
//    struct CustomWords: Identifiable {
//        let id = UUID()
//        var text: String
//        var isButton: InteractiveButton?
//
//        init(text: String, chunkButtons: [InteractiveButton]) {
//            for chunkButton in chunkButtons {
//                if (text == chunkButton.name) {
//                    self.isButton = InteractiveButton(name: chunkButton.name, listOfCommands: chunkButton.listOfCommands, isTappable: chunkButton.isTappable)
//                    self.text = text
//                }
//                else {
//                    self.isButton = nil
//                    self.text = text
//                }
//            }
//        }
//
//        struct CustomLine: Identifiable {
//            let id = UUID()
//            var words: [CustomWords]
//        }
//
//        func stringtoLine(words: [String], buttons: [InteractiveButton], start: Int) -> ([CustomWords], Int) {
//            var num = start
//            var end = start
//            var length = 0
//            var tempLine : [CustomWords] = []
//            while (num <= words.count - 1 && (length + words[num].count <= 35 || words[num].count == 1) ) {
//                tempLine.append(CustomWords(text: words[num], chunkButtons: buttons))
//                length += words[num].count + 1
//                end = num + 1
//                num += 1
//            }
//            return (tempLine, end)
//        }
//
//        func stringtoParagraph(chunk: StoryChunk) -> ([CustomLine]) {
//
//            let string = chunk.description.components(separatedBy: " ")
//            var num = 0
//            var index = 0
//            var tempParagraph : [CustomLine] = []
//            while (num <= string.count - 1) {
//                let result = stringtoLine(words: string, buttons: chunk.interactiveButtons, start: index)
//                tempParagraph.append(CustomLine(words: result.0))
//                index = result.1
//                num = result.1
//            }
//            return tempParagraph
//        }
//
//        var body: some View {
//
//            //add the first story chunk to path here
//
//
//            NavigationView{
//                ScrollView{
//                    ForEach(story.path) {storyChunk in
//                        let paragraph = stringtoParagraph(chunk: storyChunk)
//
//                        LazyVStack(alignment: .leading, spacing: 3) {
//                            ForEach(paragraph) { line in
//                                HStack(spacing: 3) {
//                                    ForEach(line.words) { word in
//                                        if let button = word.isButton {
//                                            Menu("\(word.isButton.name)") {
//                                                Button("\(word.isButton.listOfCommands[0])", action: {
//                                                    //APPEND IN PATH
//                                                })
//                                            }
//                                            .font(.system(size: 20, weight: .regular, design: .serif))
//                                            .foregroundColor(.white)
//                                            .padding(3)
//                                            .background(Color.suyashBlue)
//                                            .cornerRadius(12)
//                                        }
//                                        else {
//                                            Text("\(word.text)")
//                                                .font(.system(size: 20, weight: .regular, design: .serif))
//                                                .foregroundColor(.black)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        .padding([.bottom])
//                        .frame(width: UIScreen.main.bounds.width - 64)
//                    }
//                }
//            }
//            .navigationTitle(story.title)
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
//            .accentColor(Color.suyashBlue)
//        }
//    }
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

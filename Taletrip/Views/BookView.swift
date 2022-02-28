//
//  BookView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 23/02/22.
//

import SwiftUI
import AVKit

struct BookView: View {
    
    @EnvironmentObject var storiesStore : StoriesStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init() {
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.suyashBlue)]
        UINavigationBar.appearance().barTintColor = UIColor(Color.backgroundBeige)
        UINavigationBar.appearance().backgroundColor = UIColor(Color.backgroundBeige)
        UIToolbar.appearance().barTintColor = UIColor(Color.backgroundBeige)
        
    }
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        
        storiesStore.emptyPathArray()
        
        storiesStore.reLoad()
        
    }) {
        
        Label("",systemImage: "chevron.backward")
        
        
    }
    }
    
    struct CustomWords: Identifiable {
        let id = UUID()
        var text: String
        var isButton: InteractiveButton?
        
        init(text: String, chunkButtons: [InteractiveButton]) {
            self.text = text
            for chunkButton in chunkButtons {
                if (text == chunkButton.name) {
                    self.isButton = InteractiveButton(name: chunkButton.name, listOfCommands: chunkButton.listOfCommands)
                    break //IT'S MANDATORY TO HAVE THIS
                }
                else {
                    self.isButton = nil
                }
            }
        }
        
    }
    
    struct CustomLine: Identifiable {
        let id = UUID()
        var words: [CustomWords]
    }
    
    func stringtoLine(words: [String], buttons: [InteractiveButton], start: Int) -> ([CustomWords], Int) {
        var num = start
        var end = start
        var length = 0
        var tempLine : [CustomWords] = []
        while (num <= words.count - 1 && (length + words[num].count <= 35 || words[num].count == 1) ) {
            tempLine.append(CustomWords(text: words[num], chunkButtons: buttons))
            length += words[num].count + 1
            end = num + 1
            num += 1
        }
        return (tempLine, end)
    }
    
    func stringtoParagraph(chunk: StoryChunk) -> ([CustomLine]) {
        
        let string = chunk.description.components(separatedBy: " ")
        var num = 0
        var index = 0
        var tempParagraph : [CustomLine] = []
        while (num <= string.count - 1) {
            let result = stringtoLine(words: string, buttons: chunk.interactiveButtons, start: index)
            tempParagraph.append(CustomLine(words: result.0))
            index = result.1
            num = result.1
        }
        return tempParagraph
    }
    
    @State var descpath : [String] = []
    
    var body: some View {
        
        
        ScrollViewReader{value in
            
            ScrollView{
                ForEach(storiesStore.tappedStory.path.indices, id: \.self) { storyChunkindex in
                    let paragraph = stringtoParagraph(chunk: storiesStore.tappedStory.path[storyChunkindex])
                    
                    LazyVStack(alignment: .leading, spacing: 3) {
                        ForEach(paragraph) { line in
                            HStack(spacing: 3) {
                                ForEach(line.words) { word in
                                    if let button = word.isButton {
                                        if (button.isTappable) {
                                            Menu("\(button.name)") {
                                                ForEach(button.listOfCommands){ command in
                                                    
                                                    
                                                    if !command.isFaded{
                                                        
                                                        Button {
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                                withAnimation(.linear(duration: 0.8)){
                                                                    value.scrollTo(storiesStore.tappedStory.path.indices[storiesStore.tappedStory.path.indices.count - 1])
                                                                }
                                                            }
                                                            descpath.append(command.descriptionToBeDisplayed)
                                                            storiesStore.nextPieceOfStory(from: storiesStore.tappedStory.path[storyChunkindex], command, button)
                                                            
                                                        } label: {
                                                            Label(command.name,systemImage:command.sfSymbol)
                                                            
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                    
                                                }
                                            }
                                            .font(.system(size: 20, weight: .regular, design: .serif))
                                            .foregroundColor(.white)
                                            .padding(3)
                                            .background(Color.suyashBlue)
                                            .cornerRadius(12)
                                        }
                                        else {
                                            
                                            Text("\(word.text)")
                                                .font(.system(size: 20, weight: .regular, design: .serif))
                                                .foregroundColor(.white)
                                                .padding(3)
                                                .background(Color.gray)
                                                .cornerRadius(12)
                                            
                                        }
                                    }
                                    else {
                                        Text("\(word.text)")
                                            .font(.system(size: 20, weight: .regular, design: .serif))
                                            //.foregroundColor(.black) breaks dark theme
                                    }
                                }
                            }
                        }
                        if (descpath.count > 0 && storyChunkindex < storiesStore.tappedStory.path.count - 1) {
                            Text("\(descpath[storyChunkindex])")
                                .font(.system(size: 20, weight: .regular, design: .serif))
                                .frame(maxWidth: 346, minHeight: 71)
                                .padding(.horizontal, 10)
                                .foregroundColor(.white)
                                
                                .background(Color.suyashBlue)
                                .cornerRadius(12)
                                .padding(.top,20)
                                .padding(.bottom,10)
                        }
                        else {
                            
                        }
                    }
                    .padding([.leading,.trailing],22)
            
                }
            }
            .frame(width: UIScreen.main.bounds.size.width)
            .background(Color.backgroundBeige)
            .navigationTitle(storiesStore.tappedStory.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        print("Pressed 1")
                    }) {
                        Image(systemName: "lightbulb")
                    }
                    Spacer()
                    Button(action: {
                        print("Pressed 2")
                    }) {
                        Image(systemName: "mic")
                    }
                    Spacer()
                    Button(action: {
                        print("Pressed 3")
                    }) {
                        Image(systemName: "archivebox")
                    }
                }
                
            }
            
            .accentColor(Color.suyashBlue)
        }
        
        
        
        
        
        
        
        
        
    }
    
}


//struct BookView_Previews: PreviewProvider {
//
//    static var viewModel : StoriesStore = StoriesStore()
//
//    static var previews: some View {
//        BookView(story: viewModel.stories[0])
//    }
//}
//}

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
        impact.impactOccurred()
        
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
                    self.isButton = InteractiveButton(name: chunkButton.name, listOfCommands: chunkButton.listOfCommands, isObject: chunkButton.isObject)
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
    
    @State var audioPlayer : AVAudioPlayer!
    @State var audioPlayer1: AVAudioPlayer!
    
    let impact = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        
        ScrollView{
            
            ScrollViewReader{ value in
                
                ForEach(storiesStore.tappedStory.path.indices, id: \.self) { storyChunkindex in
                    
                    let paragraph = stringtoParagraph(chunk: storiesStore.tappedStory.path[storyChunkindex])
                    
                    VStack(alignment: .leading, spacing: 3) {
                        ForEach(paragraph) { line in
                            HStack(spacing: 3) {
                                ForEach(line.words) { word in
                                    if let button = word.isButton {
                                        if (button.isTappable && ( (button.isObject && storiesStore.isIteminInventory(item: button.name, in: storiesStore.tappedStory)) || !button.isObject)) {
                                            Menu("\(button.name)") {
                                                ForEach(button.listOfCommands){ command in
                                                    
                                                    if !command.isFaded{
                                                        
                                                        Button {
                                                            impact.impactOccurred()
                                                            storiesStore.appendIndexToDescPath(command.descriptionToBeDisplayed)
                                                            storiesStore.nextPieceOfStory(from: storiesStore.tappedStory.path[storyChunkindex], command, button)
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                                withAnimation(.easeIn(duration: 4.5)){
                                                                    value.scrollTo(storiesStore.tappedStory.path.indices[storiesStore.tappedStory.path.indices.count - 1],anchor: .bottom)
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                            if(button.name == "drink" && command.name == "Use"){
                                                                let sound = Bundle.main.path(forResource: "pouring_liquor", ofType: "wav")
                                                                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                                                                self.audioPlayer.play()
                                                            } else if(button.name == "cigarette" && command.name == "Use") {
                                                                let sound = Bundle.main.path(forResource: "cigarette", ofType: "wav")
                                                                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                                                                self.audioPlayer.play()
                                                            } else if(button.name == "pub" && (command.name == "Go to Beergarden" || command.name == "Go to Puzzles")) {
                                                                let sound = Bundle.main.path(forResource: "footsteps_outside", ofType: "wav")
                                                                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                                                                self.audioPlayer.play()
                                                            } else if(button.name == "map" && command.name == "Use") {
                                                                let sound = Bundle.main.path(forResource: "Map", ofType: "wav")
                                                                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                                                                self.audioPlayer.play()
                                                            }
                                                            
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
                                            .onTapGesture(perform: {
                                                impact.impactOccurred()
                                            })
                                            
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
                                        
                                    }
                                }
                                Spacer()
                            }
                        }
                        if (storiesStore.tappedStory.descpath.count > 0 && storyChunkindex < storiesStore.tappedStory.path.count - 1 && storiesStore.tappedStory.descpath[storyChunkindex] != "") {
                            
                            Text("\(storiesStore.tappedStory.descpath[storyChunkindex])")
                                .font(.system(size: 20, weight: .light))
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
                
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: {
                            storiesStore.giveMeaHint()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeIn(duration: 3.0)){
                                    value.scrollTo(storiesStore.tappedStory.path.indices[storiesStore.tappedStory.path.indices.count - 1],anchor: .bottom)
                                    
                                }
                                
                            }
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
                            
                            storiesStore.tellMeTheInventoryItems()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeIn(duration: 3.0)){
                                    value.scrollTo(storiesStore.tappedStory.path.indices[storiesStore.tappedStory.path.indices.count - 1],anchor: .bottom)
                                    
                                }
                                
                            }
                            
                            let sound = Bundle.main.path(forResource: "zip_1", ofType: "wav")
                            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                            self.audioPlayer.play()
                        }) {
                            Image(systemName: "archivebox")
                        }
                    }
                    
                }
                
            }
            
            .navigationTitle(storiesStore.tappedStory.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
            
            .accentColor(Color.suyashBlue)
            
            
        }
        .onAppear{
            let sound = Bundle.main.path(forResource: "Soundtrack", ofType: "wav")
            self.audioPlayer1 = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer1.play()
            audioPlayer1.volume = 0.03
            audioPlayer1.numberOfLoops = -1
        }
        .onDisappear(perform: {
            storiesStore.reLoad()
        })
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.backgroundBeige)
        
        
        
    }
    
}




//
//  GameView.swift
//  Taletrip
//
//  Created by Eugenio Raja on 22/02/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var storiesStore = StoriesStore()
    @State var currentstoryIndex = 0
    @State var storyIndexes = [0]
    
    struct CustomWords: Identifiable {
        let id = UUID()
        var text: String
        let isButton: Bool
        
        init(text: String) {
//          FIND A BETTER WAY LATER
            if (text == "jukebox" || text == "bar" || text == "John" || text == "bartender" || text == "CJ" || text == "Rob" || text == "ladies" || text == "Veronica" || text == "Jessica" || text == "Omar" || text == "guy" || text == "vial" || text == "drink" || text == "toilets" || text == "counter" || text == "medal" || text == "police" || text == "cigarette" || text == "players" || text == "Puzzles" || text == "Beergarden" || text == "map") {
                self.isButton = true
                self.text = text
            }
            else {
                self.isButton = false
                self.text = text
            }
        }
    }

    struct CustomLine: Identifiable {
        let id = UUID()
        var words: [CustomWords]
    }
    
    static func stringtoLine(words: [String], start: Int) -> ([CustomWords], Int) {
        var num = start
        var end = start
        var length = 0
        var tempLine : [CustomWords] = []
        while (num <= words.count - 1 && (length + words[num].count <= 35 || words[num].count == 1) ) {
            tempLine.append(CustomWords(text: words[num]))
            length += words[num].count + 1
            end = num + 1
            num += 1
        }
        return (tempLine, end)
    }

    static func stringtoParagraph(words: [String]) -> ([CustomLine]) {
        var num = 0
        var index = 0
        var tempParagraph : [CustomLine] = []
        while (num <= words.count - 1) {
            let result = stringtoLine(words: words, start: index)
            tempParagraph.append(CustomLine(words: result.0))
            index = result.1
            num = result.1
        }
        return tempParagraph
    }
    
    static func getCommands(button: String) -> ([String], [Int]) {
        var text: [String] = []
        var indextogoto: [Int] = []
        if (button == "Puzzles") {
            text.append("Go to Puzzles")
            text.append("")
            text.append("")
            indextogoto.append(1)
            indextogoto.append(-1)
            indextogoto.append(-1)
            return (text, indextogoto)
        } else if(button == "Beergarden"){
            text.append("Go to Beergarden")
            text.append("")
            text.append("")
            indextogoto.append(1)
            indextogoto.append(-1)
            indextogoto.append(-1)
            return (text, indextogoto)
        } else {
            text.append("Test 1")
            text.append("Test 2")
            text.append("Test 3")
            indextogoto.append(-1)
            indextogoto.append(-1)
            indextogoto.append(-1)
            return (text, indextogoto)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: true) {
                ForEach(storyIndexes, id: \.self) {index in
                    let paragraph: [GameView.CustomLine] = GameView.stringtoParagraph(words: storiesStore.stories[0].allStoryChunksDescription[index].components(separatedBy: " "))
                    LazyVStack(alignment: .leading, spacing: 3) {
                        ForEach(paragraph) { line in
                            HStack(spacing: 3) {
                                ForEach(line.words) { word in
                                    if(word.isButton == true) {
                                        let commands = GameView.getCommands(button: word.text)
                                        Menu("\(word.text)") {
                                            Button("\(commands.0[0])", action: {
                                                if(commands.1[0] != -1) {                   //CHECKS IF IT'S A BLANK COMMAND
                                                    storyIndexes.append(commands.1[0])      //DOES THE ACTION
                                                    currentstoryIndex = commands.1[0]
                                                }
                                            })
                                            Button("\(commands.0[1])", action: {
                                                if(commands.1[1] != -1) {
                                                    storyIndexes.append(commands.1[1])
                                                    currentstoryIndex = commands.1[0]
                                                }
                                            })
                                            Button("\(commands.0[2])", action: {
                                                if(commands.1[2] != -1) {
                                                    storyIndexes.append(commands.1[2])
                                                    currentstoryIndex = commands.1[0]
                                                }
                                            })
                                        }
                                        .font(.system(size: 20, weight: .regular, design: .serif))
                                        .foregroundColor(.white)
                                        .padding(3)
                                        .background(Color.briefGreen)
                                        .cornerRadius(12)
                                    }
                                    else {
                                        Text("\(word.text)")
                                            .font(.system(size: 20, weight: .regular, design: .serif))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                    .padding([.bottom])
                    .frame(width: UIScreen.main.bounds.width - 64)
                }
            }
            .navigationTitle("The Detective's day off")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("First") {
                        print("Pressed 1")
                    }
                    Spacer()
                    Button("Second") {
                        print("Pressed 2")
                    }
                    Spacer()
                    Button("Third") {
                        print("Pressed 3")
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

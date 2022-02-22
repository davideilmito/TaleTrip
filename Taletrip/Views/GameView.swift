//
//  GameView.swift
//  Taletrip
//
//  Created by Eugenio Raja on 22/02/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var storiesStore = StoriesStore()
    @State var storyindex = 0
    
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
    
    static func getCommands(button: String, currentIndex: Int) -> ([String], [Int]) {
        var text: [String] = []
        var indextogoto: [Int] = []
        if (button == "Puzzles") {
            text.append("Go to Puzzles")
            text.append("")
            text.append("")
            indextogoto.append(1)
            indextogoto.append(currentIndex)
            indextogoto.append(currentIndex)
            return (text, indextogoto)
        } else if(button == "Beergarden"){
            text.append("Go to Beergarden")
            text.append("")
            text.append("")
            indextogoto.append(1)
            indextogoto.append(currentIndex)
            indextogoto.append(currentIndex)
            return (text, indextogoto)
        } else {
            text.append("Test 1")
            text.append("Test 2")
            text.append("Test 3")
            indextogoto.append(currentIndex)
            indextogoto.append(currentIndex)
            indextogoto.append(currentIndex)
            return (text, indextogoto)
        }
    }
    
    var body: some View {
        ScrollView {
//            ForEach(0..<storiesStore.stories[0].allStoryChunksDescription.count) { index in
//                let paragraph: [GameView.CustomLine] =  GameView.stringtoParagraph(words: storiesStore.stories[0].allStoryChunksDescription[index].components(separatedBy: " "))
            let paragraph: [GameView.CustomLine] = GameView.stringtoParagraph(words: storiesStore.stories[0].allStoryChunksDescription[storyindex].components(separatedBy: " "))
                LazyVStack(alignment: .leading, spacing: 3) {
                    ForEach(paragraph) { line in
                        HStack(spacing: 3) {
                            ForEach(line.words) { word in
                                if(word.isButton == true) {
                                    let commands = GameView.getCommands(button: word.text, currentIndex: storyindex)
                                    Menu("\(word.text)") {
                                        Button("\(commands.0[0])", action: {
                                            if(storyindex != commands.1[0]) { //CHECKS IF IT'S A BLANK COMMAND
                                                storyindex = commands.1[0]    //DOES THE ACTION
                                            }
                                        })
                                        Button("\(commands.0[1])", action: {
                                            if(storyindex != commands.1[1]) {
                                                storyindex = commands.1[1]
                                            }
                                        })
                                        Button("\(commands.0[2])", action: {
                                            if(storyindex != commands.1[2]) {
                                                storyindex = commands.1[2]
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
            //}
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

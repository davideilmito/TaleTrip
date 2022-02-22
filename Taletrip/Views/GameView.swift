//
//  GameView.swift
//  Taletrip
//
//  Created by Eugenio Raja on 22/02/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var storiesStore = StoriesStore()
    
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
    
    var body: some View {
        ScrollView {
            ForEach(0..<storiesStore.stories[0].allStoryChunksDescription.count) { index in
                let paragraph: [GameView.CustomLine] =  GameView.stringtoParagraph(words: storiesStore.stories[0].allStoryChunksDescription[index].components(separatedBy: " "))
                LazyVStack(alignment: .leading, spacing: 3) {
                    ForEach(paragraph) { line in
                        HStack(spacing: 3) {
                            ForEach(line.words) { word in
                                if(word.isButton == true) {
                                    Text("\(word.text)")
                                        .font(.system(size: 20, weight: .regular, design: .serif))
                                        .foregroundColor(.white)
                                        .padding(3)
                                        .background(Color(red: 0.226, green: 0.41, blue: 0.523))
                                        .cornerRadius(12)
                                        .onTapGesture {
                                            print("The word is \(word.text)")
                                        }
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
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

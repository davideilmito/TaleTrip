//
//  StoriesStore.swift
//  Taletrip
//
//  Created by Davide Biancardi on 20/02/22.
//

import Foundation
import SwiftUI
import SwiftSpeech
import AVFoundation


class StoriesStore : ObservableObject{
    
    @Published var  stories : [Story]
    
    @Published var storedAnswers : [(session: SwiftSpeech.Session, text: String)]   = []
    
    
    var storyOfTheMonth : Story? {
        
        stories.filter { $0.isStoryOfTheMonth == true }.first
            
    }
  
    var storyYouWillLike : Story? {
        
        stories.filter { $0.isStoryYouWillLike == true }.first
            
    }
    
    var adventureStories:[Story] {
        
        stories.filter { $0.genre == .adventure && !($0.isStoryYouWillLike || $0.isStoryOfTheMonth) }
          
        
    }
    
    var currentAnswer : (session: SwiftSpeech.Session, text: String)?  {
        
        if !storedAnswers.isEmpty{
            
            return storedAnswers[storedAnswers.count - 1]
        }
        
        return nil
        
    }

    init(){
        
        self.stories = []
//        ALL THIS JSON SHOUL BE IN A SINGLE JSON FILE
        self.stories.append(load("thedetectivesdayoff.json"))
        self.stories.append(load("MortalPortrait.json"))
        self.stories.append(load("TitleSix.json"))
        self.stories.append(load("TitleFive.json"))
        self.stories.append(load("TitleTwo.json"))
        self.stories.append(load("TitleThree.json"))
        self.stories.append(load("TitleOne.json"))
    
    }
    
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
    
    private func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        guard
            let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            
            print(error.localizedDescription)
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
}

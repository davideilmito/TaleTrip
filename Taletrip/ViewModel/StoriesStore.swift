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
    
    @Published var stories : [Story]
    
    @Published var storedAnswers : [(session: SwiftSpeech.Session, text: String)]   = []
    
    
    var tappedStory : Story {
        
        stories.filter { $0.showDetails == true }.first!
        
    }
    
    var IndexOfTheTappedStory : Int? {
        
        let index = stories.indices.filter { stories[$0].showDetails == true }.first
        return index
        
    }
    
    
    
    
    
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
    
    private func getTheIndex(of story: Story)-> Int?{
        
        
        let index = stories.indices.filter { stories[$0].title == story.title }.first
        return index
        
        
    }
    
    
    func firstChunkInPath(of story: Story){
        
        let index = getTheIndex(of: story)
        stories[index!].path.append(story.chapters[0].storyChunks[0])
        
        
        
    }
    
    private func getStoryChunk(_ index: Int,_ story : Story) -> StoryChunk? {
        
        
        let indexOfTheStory = getTheIndex(of: story)
        let chunkDescriptionToBeMatched = stories[indexOfTheStory!].allStoryChunksDescription[index]
        
        for chapter in stories[indexOfTheStory!].chapters.indices{
            
            if let storyChunkFounded = stories[indexOfTheStory!].chapters[chapter].storyChunks.filter { $0.description == chunkDescriptionToBeMatched }.first
            {
                
                return storyChunkFounded
                
            }
            
        }
        
        return nil
        
    }
    
    
    func nextChunk(_ index: Int,_ story : Story){
        
        
        let storyChunk =  getStoryChunk(index, story)
        
        let indexOfTheStory = getTheIndex(of: story)
        
        if storyChunk == nil {
            
            fatalError("WILLY WHERE THE FUCK IS THE CHUNKK with index \(index)")
            
        }else {
            
            stories[indexOfTheStory!].path.append(storyChunk!)
            
        }
        
    }
    
    func showStory(of story : Story) {
        
        let IndexOfStoryToBeDisplayed = stories.indices.filter {stories[$0].title ==  story.title }.first
        
        stories[IndexOfStoryToBeDisplayed!].showDetails = true
        
    }
    
    func unshowStory(of story : Story) {
        
        let IndexOfStoryToBeUnshowed = stories.indices.filter {stories[$0].title ==  story.title }.first
        
        stories[IndexOfStoryToBeUnshowed!].showDetails = false
        
    }
    
    func getListOfButtons(_ story: Story, _ name: String) -> [Command]?{
        
        story.dictionaryOfButtons[name]?.listOfCommands
        
        
    }
    
    func appendStoryChunkToPath(storyChunk: StoryChunk, story : Story){
        
        
        stories[stories.indices.filter { stories[$0].title == story.title}.first!].path.append(storyChunk)
        
    }
    
    
    
    
}


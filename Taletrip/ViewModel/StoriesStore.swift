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
    
    
    func nextChunk(_ index: Int,_ story : Story, _ command : Command){
        
        
        let storyChunk =  getStoryChunk(index, story)
        
        let indexOfTheStory = getTheIndex(of: story)
        
        if storyChunk == nil {
            
            fatalError("WILLY WHERE THE FUCK IS THE CHUNKK with index \(index)")
            
        }else {
            
            stories[indexOfTheStory!].path.append(storyChunk!)
            
        }
        
        increaseHowManyTimes(of: command, in: story)
        
        
        
    }
    
    
    
    func nextPieceOfStory(from storyChunk: StoryChunk, _ command :Command,_ button: InteractiveButton){
        
        let indexOfStory = getTheIndex(of: tappedStory)
        let IndexOfStoryChunkInPath = stories[getTheIndex(of: tappedStory)!].path.indices.filter { stories[getTheIndex(of: tappedStory)!].path[$0] == storyChunk}.first
        
        let indexOfButton = stories[indexOfStory!].path[IndexOfStoryChunkInPath!].interactiveButtons.firstIndex {
            $0.name == button.name
        }
        print(indexOfButton)
        
        let indexOfCommand = stories[indexOfStory!].path[IndexOfStoryChunkInPath!].interactiveButtons[indexOfButton!].listOfCommands.indices.filter {
            
            stories[indexOfStory!].path[IndexOfStoryChunkInPath!].interactiveButtons[indexOfButton!].listOfCommands[$0].name == command.name
            
        }.first
        
        
        let effectiveCommand = stories[indexOfStory!].path[IndexOfStoryChunkInPath!].interactiveButtons[indexOfButton!].listOfCommands[indexOfCommand!]
        
        
        
        let storyChunk =  getStoryChunk(effectiveCommand.arrayIndexOfTheStory[effectiveCommand.howManyTimes], tappedStory)
        
        
        if storyChunk == nil {
            
            fatalError("WILLY WHERE THE FUCK IS THE CHUNKK with index \(index)")
            
        }else {
            
            stories[indexOfStory!].path.append(storyChunk!)
            
        }
        
        
        
        stories[indexOfStory!].path[IndexOfStoryChunkInPath!].interactiveButtons[indexOfButton!].listOfCommands[indexOfCommand!].howManyTimes += 1
        
        
        }
        
        
    
    

    
    func prova(_ story : Story, _ command : Command){
        
        let indecesToAccessCommand = GetCommandIndeces(of: command, in: story)
        let indexOfTheStory = getTheIndex(of: story)
        
        if let indices = indecesToAccessCommand{
            
            let effectiveCommand = stories[indexOfTheStory!].chapters[indices[0]].storyChunks[indices[1]].interactiveButtons[indices[2]].listOfCommands[indices[3]]
            
            
            
            let storyChunk =  getStoryChunk(effectiveCommand.arrayIndexOfTheStory[effectiveCommand.howManyTimes], story)
            
            
            
            if storyChunk == nil {
                
                fatalError("WILLY WHERE THE FUCK IS THE CHUNKK with description \(storyChunk?.description)")
                
            }else {
                
                stories[indexOfTheStory!].path.append(storyChunk!)
                stories[indexOfTheStory!].chapters[indices[0]].storyChunks[indices[1]].interactiveButtons[indices[2]].listOfCommands[indices[3]].howManyTimes += 1
            
                
            }
            
            
        
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
    
    
    
    func GetCommandIndeces(of command : Command, in story : Story )-> [Int]?{
        
        
        let IndexOfStory = getTheIndex(of: story)!
        
        for chapterIndex in stories[IndexOfStory].chapters.indices{
            
            for storyChunkIndex in stories[IndexOfStory].chapters[chapterIndex].storyChunks.indices{
                
                for buttonIndex in stories[IndexOfStory].chapters[chapterIndex].storyChunks[storyChunkIndex].interactiveButtons.indices{
                    
                    let indexOfCommand =  stories[IndexOfStory].chapters[chapterIndex].storyChunks[storyChunkIndex].interactiveButtons[buttonIndex].listOfCommands.indices.filter {
                        
                        stories[IndexOfStory].chapters[chapterIndex].storyChunks[storyChunkIndex].interactiveButtons[buttonIndex].listOfCommands[$0].id == command.id
                        
                        
                    }.first
                    
                   
                    if  let index = indexOfCommand{
                        
                        return [chapterIndex,storyChunkIndex,buttonIndex,index]
                        
                    }
                    
                    
                    
                }
                
                
            }
            
            
        }
        
        return nil
        
    }
    
    func increaseHowManyTimes(of command : Command, in story : Story ){
        
        
        let IndexOfStory = getTheIndex(of: story)!
        
        for chapterIndex in stories[IndexOfStory].chapters.indices{
            
            for storyChunkIndex in stories[IndexOfStory].chapters[chapterIndex].storyChunks.indices{
                
                for buttonIndex in stories[IndexOfStory].chapters[chapterIndex].storyChunks[storyChunkIndex].interactiveButtons.indices{
                    
                    let indexOfCommand =  stories[IndexOfStory].chapters[chapterIndex].storyChunks[storyChunkIndex].interactiveButtons[buttonIndex].listOfCommands.indices.filter {
                        
                        stories[IndexOfStory].chapters[chapterIndex].storyChunks[storyChunkIndex].interactiveButtons[buttonIndex].listOfCommands[$0].id == command.id
                        
                        
                    }.first
                    
                   
                    if  let index = indexOfCommand{
                        
                        stories[IndexOfStory].chapters[chapterIndex].storyChunks[storyChunkIndex].interactiveButtons[buttonIndex].listOfCommands[index].howManyTimes += 1
                        
                        
                       
                        
                        return
                        
                    }
                    
                    
                    
                }
                
                
            }
            
            
        }
        
        
    }
    
    
    
    
}






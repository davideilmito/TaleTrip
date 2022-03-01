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
    
    private var currentChapter = 0
    
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
    
    func reLoad(){
        
        let index = getTheIndex(of: tappedStory)!
        
        stories[index] = load(stories[index].jsonTitle)
        stories[index].showDetails = true
        self.currentChapter = 0
        
    }
    
    func firstChunkInPath(of story: Story){
        
        let index = getTheIndex(of: story)
        stories[index!].path.append(story.chapters[0].storyChunks[0])
        
    }
    
    private func getStoryChunk(_ index: Int,_ story : Story) -> StoryChunk? {
        
        
        let indexOfTheStory = getTheIndex(of: story)
        let chunkDescriptionToBeMatched = stories[indexOfTheStory!].allStoryChunksDescription[index]
        
        for chapter in stories[indexOfTheStory!].chapters.indices{
            
            if let storyChunkFounded = stories[indexOfTheStory!].chapters[chapter].storyChunks.filter({ $0.description == chunkDescriptionToBeMatched }).first
            {
                
                return storyChunkFounded
                
            }
            
        }
        
        return nil
        
    }
    
    
    func emptyPathArray(){
        
        let indexOfStory = getTheIndex(of: tappedStory)
        stories[indexOfStory!].path.removeAll()
        
    }
    
    
    
    
    func nextPieceOfStory(from storyChunk: StoryChunk, _ command :Command,_ button: InteractiveButton){
        
        let indexOfStory = getTheIndex(of: tappedStory)
        
        let IndexOfStoryChunkInPath = stories[getTheIndex(of: tappedStory)!].path.indices.filter { stories[getTheIndex(of: tappedStory)!].path[$0] == storyChunk}.first
        
        let indexOfButton = stories[indexOfStory!].path[IndexOfStoryChunkInPath!].interactiveButtons.firstIndex {
            $0.name == button.name
        }
        
        let indexOfCommand = stories[indexOfStory!].path[IndexOfStoryChunkInPath!].interactiveButtons[indexOfButton!].listOfCommands.indices.filter {
            
            stories[indexOfStory!].path[IndexOfStoryChunkInPath!].interactiveButtons[indexOfButton!].listOfCommands[$0].name == command.name
            
        }.first
        
        let commandToSearchFor = stories[indexOfStory!].path[IndexOfStoryChunkInPath!].interactiveButtons[indexOfButton!].listOfCommands[indexOfCommand!]
        
        
        let buttonToSearchFor = stories[indexOfStory!].path[IndexOfStoryChunkInPath!].interactiveButtons[indexOfButton!]
        
        let storyChunk =  getStoryChunk(commandToSearchFor.arrayIndexOfTheStory[commandToSearchFor.howManyTimes], tappedStory)
        
        
        incrementHowManyTimesInStory(of: buttonToSearchFor, and: commandToSearchFor)
        
        incrementHowManyTimesInPath(of: buttonToSearchFor, and: commandToSearchFor)
        
        if !appendStoryChunkToPath(storyChunk){
            
            fatalError("WILLY WHERE THE FUCK IS THE CHUNKK with description -> \(stories[getTheIndex(of: tappedStory)!].allStoryChunksDescription[commandToSearchFor.arrayIndexOfTheStory[commandToSearchFor.howManyTimes]])")
            
        }
        
        if checkChapterCondition(){
            
            let indexOfTheStoryToAddInPath = stories[getTheIndex(of: tappedStory)!].chapters[currentChapter].trigger.indexOfTheStory
            
            appendStoryChunkToPath(getStoryChunk(indexOfTheStoryToAddInPath, tappedStory))
            
            appendIndexToDescPath(nil)
            
            currentChapter += 1
            
        }
        
    }
    
    
    private func checkChapterCondition() -> Bool{
        
        let triggerOfCurrentChapter = stories[getTheIndex(of: tappedStory)!].chapters[currentChapter].trigger
           
        if !triggerOfCurrentChapter.indicesDescriptionInPath.isEmpty{
            
            for indexStoryChunk in triggerOfCurrentChapter.indicesDescriptionInPath {
                
                if   !stories[getTheIndex(of: tappedStory)!].path.contains(getStoryChunk(indexStoryChunk, tappedStory)!){
                    
                    return false
                    
                }
            }
            
            return true
            
        } else {
            
            return false
            
        }
        
        
        
    }
    
    
    
    private func incrementHowManyTimesInStory(of button : InteractiveButton, and command : Command){
        
        let indexOfStory = getTheIndex(of: tappedStory)
        
        for chapterIndex in stories[indexOfStory!].chapters.indices{
            
            for chunkIndex in stories[indexOfStory!].chapters[chapterIndex].storyChunks.indices{
                
                let bottonIndices = stories[indexOfStory!].chapters[chapterIndex].storyChunks[chunkIndex]  .interactiveButtons.indices.filter {
                    
                    stories[indexOfStory!].chapters[chapterIndex].storyChunks[chunkIndex].interactiveButtons[$0].name == button.name
                    
                }
                
                for i in bottonIndices {
                    
                    let commandIndexToIncrement =  stories[indexOfStory!].chapters[chapterIndex].storyChunks[chunkIndex].interactiveButtons[i].listOfCommands.indices.filter
                    {
                        
                        stories[indexOfStory!].chapters[chapterIndex].storyChunks[chunkIndex].interactiveButtons[i].listOfCommands[$0].name == command.name
                        
                    }.first
                    
                    if commandIndexToIncrement != nil {
                        
                        stories[indexOfStory!].chapters[chapterIndex].storyChunks[chunkIndex].interactiveButtons[i].listOfCommands[commandIndexToIncrement!].howManyTimes += 1
                        
                    }
                }
            }
        }
    }
    
    
    private func incrementHowManyTimesInPath(of button : InteractiveButton, and command : Command){
        
        let indexOfStory = getTheIndex(of: tappedStory)
        
        for chunkIndex in stories[indexOfStory!].path.indices{
            
            let bottonIndices = stories[indexOfStory!].path[chunkIndex].interactiveButtons.indices.filter {
                
                stories[indexOfStory!].path[chunkIndex].interactiveButtons[$0].name == button.name
                
            }
            
            for i in bottonIndices {
                
                let commandIndexToIncrement =  stories[indexOfStory!].path[chunkIndex].interactiveButtons[i].listOfCommands.indices.filter
                {
                    
                    stories[indexOfStory!].path[chunkIndex].interactiveButtons[i].listOfCommands[$0].name == command.name
                    
                }.first
                
                if commandIndexToIncrement != nil {
                    
                    
                    stories[indexOfStory!].path[chunkIndex].interactiveButtons[i].listOfCommands[commandIndexToIncrement!].howManyTimes += 1
                    
                }
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
    
    func appendIndexToDescPath(_ description: String?) -> Bool{
        
        let indexOfStory = getTheIndex(of: tappedStory)
        
        if description == nil {
            
            stories[indexOfStory!].descpath.append("")
            return false
            
        }else {
            
            stories[indexOfStory!].descpath.append(description!)
            return true
            
        }
        
    }
    
    private  func appendStoryChunkToPath(_ storyChunk: StoryChunk?) -> Bool{
        
        let indexOfStory = getTheIndex(of: tappedStory)
        
        if storyChunk == nil {
            
            return false
            
        }else {
            
            stories[indexOfStory!].path.append(storyChunk!)
            return true
            
        }
        
    }
    
   
    
}






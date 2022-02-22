//
//  GameView.swift
//  Taletrip
//
//  Created by Eugenio Raja on 22/02/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var storiesStore = StoriesStore()
    
    
    
    var body: some View {
        ScrollView {
            ForEach(0..<storiesStore.stories[0].allStoryChunksDescription.count) { index in
                let paragraph: [StoriesStore.CustomLine] =  StoriesStore.stringtoParagraph(words: storiesStore.stories[0].allStoryChunksDescription[index].components(separatedBy: " "))
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


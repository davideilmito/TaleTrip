//
//  LargeCard.swift
//  Taletrip
//
//  Created by Davide Biancardi on 18/02/22.
//

import SwiftUI

struct LargeCard: View {
    
    
    let storyImageName : String
    let storyType : Genre
    let length : Longevity
    let storyTitle : String
    
    
    var body: some View {
        
        
        ZStack{
            
            Image(storyImageName)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 23))
                .scaledToFit()
                .shadow(color: .black .opacity(0.3), radius: 20, x: 0, y: 10)
            VStack(alignment: .leading,spacing: 208){
                
                LargeCardLongevity(longevity: length)
                    .padding(.top,5)
                
                LargeCardText(storyTitle: storyTitle, storyType: storyType).padding(.bottom,5)
                
                
            }.frame(maxWidth: 310, maxHeight: 400,alignment: .bottomLeading)
                .padding(.leading,15)
            
        }.frame(width: 310, height: 400)
        
        
    }
}

struct LargeCard_Previews: PreviewProvider {
    static var previews: some View {
        LargeCard(storyImageName: "themortalportrait", storyType: .mystery, length: .medium, storyTitle: "the\ndetective's\nday off")
    }
}

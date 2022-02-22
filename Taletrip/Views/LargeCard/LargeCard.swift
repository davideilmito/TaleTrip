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
        
        
        
        
        Image(storyImageName)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 23))
            .frame(width: 310, height: 400, alignment: .center)
            .scaledToFit()
            .shadow(color: .black .opacity(0.3), radius: 20, x: 0, y: 10)
            .overlay {
                
                VStack(alignment:.leading, spacing: 208){
                    
                    CapsuleView(longevity: length, width: 82, height: 24, textSize: 13)
                        .padding(.leading,15)
                        
                    LargeCardText(storyTitle: storyTitle, storyType: storyType)
                        .padding(.leading,15)
                        .padding(.bottom,10)
                    
                    
                }.frame(width: 310, height: 400,alignment: .bottomLeading)
                    
                
                
                
            }
   
        
    }
}

struct LargeCard_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        LargeCard(storyImageName: "thedetectivesdayoff", storyType: .mystery, length: .medium, storyTitle: "the\ndetective's\nday off")
    }
}

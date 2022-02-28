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
    
    
    var width : CGFloat = UIScreen.main.bounds.size.width - 80
    var height : CGFloat = ((UIScreen.main.bounds.size.width - 80) * 400 ) / 310
    
    
    
    var body: some View {
        
        Image(storyImageName)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 23))
            .frame(width:width, height: height, alignment: .center)
            .scaledToFit()
            .shadow(color: .black .opacity(0.3), radius: 20, x: 0, y: 10)
            .overlay {
                
                VStack(alignment:.leading){
                    
                    CapsuleView(longevity: length, width: 82, height: 24, textSize: 13)
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                        .padding([.leading,.top],15)
                        
                    LargeCardText(storyTitle: storyTitle, storyType: storyType)
                        .padding(.leading,15)
                        .padding(.bottom,10)
                    
                    
                }.frame(width: width, height: height,alignment: .bottomLeading)
                    
                
                
                
            }
   
        
    }
}

struct LargeCard_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        LargeCard(storyImageName: "thedetectivesdayoff", storyType: .mystery, length: .medium, storyTitle: "the\ndetective's\nday off")
    }
}

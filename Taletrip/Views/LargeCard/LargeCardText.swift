//
//  LargeCardText.swift
//  Taletrip
//
//  Created by Davide Biancardi on 18/02/22.
//

import SwiftUI

struct LargeCardText: View {
    
    let storyTitle : String
    let storyType : Genre
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: -5){
            
           
            TextView(title:storyType.rawValue.uppercased(),size: 17,weight: .regular)
                .foregroundColor(Color.cardGenreColor)
                
            
            TextView(title:storyTitle.uppercased(),size: 37,weight: .bold)
                .foregroundColor(Color.white)
            
            
           
            
        }
        
        
        
    }
}

struct LargeCardText_Previews: PreviewProvider {
    static var previews: some View {
        LargeCardText(storyTitle: "the\ndetective's\nday off", storyType: .mystery).preferredColorScheme(.dark)
        
    }
}

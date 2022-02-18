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
        
        VStack(alignment: .leading,spacing: 0){
            
            Text(storyType.rawValue.uppercased())
                .font(.system(size: 17, weight: .regular, design: .serif))
                .foregroundColor(Color.cardGenreColor)
            
            Text(storyTitle.uppercased())
                .font(.system(size: 37, weight: .bold, design: .serif))
                .foregroundColor(Color.white)
            
            
        }
        
        
        
    }
}

struct LargeCardText_Previews: PreviewProvider {
    static var previews: some View {
        LargeCardText(storyTitle: "the\ndetective's\nday off", storyType: .mystery).preferredColorScheme(.dark)
       
    }
}

//
//  DescriptionTextView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 22/02/22.
//

import SwiftUI

struct DescriptionTextView: View {
    
    let descriptionOfTheStory : String
    let titleOfTheStory: String
    let genre: String
    let author : String
    
    var body: some View {
        
       
            
            VStack (alignment: .leading, spacing: 15){
                
                TextView(title: genre, size: 21, weight: .regular, italic: true)
                    .foregroundColor(.longRed)
                
                
                VStack(alignment: .leading, spacing: 10){
                    
                    TextView(title: titleOfTheStory.uppercased(), size: 37 , weight: .bold)
                        .foregroundColor(.black)
                    
                    TextView(title: descriptionOfTheStory, size: 18, weight: .regular)
                        .foregroundColor(.descriptionColor)
                    
                    TextView(title: "By " + author, size: 13, weight: .bold)
                        .foregroundColor(.authorColor)
                    
                }
                
            }.padding([.leading,.trailing],15)
            
         
        
        
    }
}

struct DescriptionTextView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionTextView(descriptionOfTheStory: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", titleOfTheStory: "The\nmortal\nportrait", genre: "Crime",author: "Pinco Pallino")
    }
}

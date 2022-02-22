//
//  SmallCardView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 21/02/22.
//

import SwiftUI

struct SmallCardView: View {
    
    let storyImageName: String
    let storyTitle : String
    
    var body: some View {
    
        VStack(alignment: .leading,spacing: 5){
            
            SmallCardImage(storyImageName: storyImageName)
            
            TextView(title: storyTitle, size: 14, weight: .regular)
                .foregroundColor(Color.smallCardTitleColor).frame(maxWidth: 149,maxHeight:18,alignment: .leading)
            
        }
    
    }
    
    
}

struct SmallCardView_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardView(storyImageName: "themortalportrait", storyTitle: "Title 1")
    }
}

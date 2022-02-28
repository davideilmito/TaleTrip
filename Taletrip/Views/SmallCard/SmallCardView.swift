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
    let length: Longevity
    var width : CGFloat = UIScreen.main.bounds.size.width - 245
   
    var body: some View {
    
        VStack(alignment: .leading,spacing: 5){
            
            SmallCardImage(storyImageName: storyImageName).overlay {
                CapsuleView(longevity: length, width: 42, height: 14, textSize: 7)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.leading, 10)
                    .padding(.top, 10)
            }
            
            TextView(title: storyTitle, size: 14, weight: .regular)
                .foregroundColor(Color.smallCardTitleColor).frame(maxWidth: width,maxHeight:18,alignment: .leading)
            
        }
    
    }
    
    
}

struct SmallCardView_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardView(storyImageName: "themortalportrait", storyTitle: "Title 1",length: .medium)
    }
}

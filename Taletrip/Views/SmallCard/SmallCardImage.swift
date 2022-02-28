//
//  smallCard.swift
//  Taletrip
//
//  Created by Davide Biancardi on 21/02/22.
//

import SwiftUI

struct SmallCardImage: View {
    
    let  storyImageName: String
    
    var width : CGFloat = UIScreen.main.bounds.size.width - 240
    var height : CGFloat = ((UIScreen.main.bounds.size.width - 240) * 200 ) / 149
    
    var body: some View {
        
        Image(storyImageName)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 23))
            .frame(width: width, height: height, alignment: .center)
            .scaledToFit()
            .shadow(color: .black .opacity(0.2), radius: 5, x: 0, y: 2)
    
    }
}

struct SmallCard_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardImage(storyImageName:"themortalportrait")
    }
}

//
//  smallCard.swift
//  Taletrip
//
//  Created by Davide Biancardi on 21/02/22.
//

import SwiftUI

struct SmallCardImage: View {
    
    let  storyImageName: String
    
    var body: some View {
        
        Image(storyImageName)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 23))
            .frame(width: 149, height: 200, alignment: .center)
            .scaledToFit()
            .shadow(color: .black .opacity(0.2), radius: 5, x: 0, y: 2)
    
    }
}

struct SmallCard_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardImage(storyImageName:"themortalportrait")
    }
}

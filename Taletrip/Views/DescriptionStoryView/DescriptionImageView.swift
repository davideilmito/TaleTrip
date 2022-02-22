//
//  DescriptionImageView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 22/02/22.
//

import SwiftUI

struct DescriptionImageView: View {
    
    let imageName : String
    
    var body: some View {
    
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity,maxHeight: 357)
            .clipShape(Rectangle())

    }
}

struct DescriptionImageView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionImageView(imageName: "themortalportrait")
    }
}

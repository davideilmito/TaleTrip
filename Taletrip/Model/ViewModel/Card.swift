//
//  Card.swift
//  Taletrip
//
//  Created by Suyash Lunawat on 17/02/22.
//

import SwiftUI

struct Card: View {
    var nameOfTheImage: String
    var storyType: String
    var storyTitle: String
    var body: some View {
        ZStack{
        Image(nameOfTheImage)
            .resizable()
            .frame(width: 310, height: 400)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .scaledToFit()
           .padding()
            .shadow(color: .secondary, radius: 23)
            .shadow(radius: 10)
            HStack{
            VStack(alignment:.leading) {
                Spacer()
        Text(storyType)
                    .padding(.leading)
                .foregroundColor(.white)
                .font(.system(size: 17, weight:.semibold, design: .serif))
        Text(storyTitle)
                    .padding(.leading)
                    .foregroundColor(.white)
                    .font(.system(size: 37, weight:.semibold, design: .serif))
                    
            }
            .frame (width: 260, height: 400)
            
                Spacer()
        }
           
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(nameOfTheImage: "thedetectivesdayoff", storyType: "MYSTERY", storyTitle: """
             The
             Detectives
             Day Off
             """
        )
    }
}

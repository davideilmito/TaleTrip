//
//  SuyashButton.swift
//  Taletrip
//
//  Created by Davide Biancardi on 22/02/22.
//

import SwiftUI

struct SuyashButton: View {
    
    let textOfTheButton : String
    let sfSymbol : String
    
    var body: some View {
        
        
        RoundedRectangle(cornerRadius: 27)
            .foregroundColor(.suyashBlue)
            .frame(width: 360, height: 54)
            .overlay {
               
                
                    
                    Label(textOfTheButton ,systemImage: sfSymbol).foregroundColor(.white)
                        .font(.system(size: 24, weight: .medium, design: .serif))
                    
                
               
            }.frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        
    }
}

struct SuyashButton_Previews: PreviewProvider {
    static var previews: some View {
        SuyashButton(textOfTheButton: "Play", sfSymbol: "play.fill")
    }
}

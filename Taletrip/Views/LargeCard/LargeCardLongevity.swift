//
//  LargeCardLongevity.swift
//  Taletrip
//
//  Created by Davide Biancardi on 18/02/22.
//

import SwiftUI

struct LargeCardLongevity: View {
    
    let longevity : Longevity
    
    var body: some View {
        
        ZStack{
            
            
            Rectangle()
                .foregroundColor(longevity.associatedColor())
                .frame(width: 82, height: 24)
                .clipShape(Capsule())
            TextView(title: longevity.rawValue.uppercased(),size: 13,weight: .regular)
                .foregroundColor(.white)
                
            
        }
        
        
    }
}

struct LargeCardLongevity_Previews: PreviewProvider {
    static var previews: some View {
        LargeCardLongevity(longevity: .brief)
    }
}

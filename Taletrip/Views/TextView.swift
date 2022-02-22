//
//  TitleView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 21/02/22.
//

import SwiftUI

struct TextView: View {
    
    let title: String
    let size: Int
    let weight : Font.Weight
    
    var body: some View {

        
            Text(title)
                .font(.system(size: CGFloat(size), weight: weight , design: .serif))
                
            
        
        
        
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(title:"Stories",size: 37,weight: .bold)
    }
}

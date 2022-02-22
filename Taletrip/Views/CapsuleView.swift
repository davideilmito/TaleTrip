//
//  SwiftUIView.swift
//  Taletrip
//
//  Created by Suyash Lunawat on 22/02/22.
//

import SwiftUI

struct CapsuleView: View {
    
    let longevity : Longevity
    let width: CGFloat
    let height: CGFloat
    let textSize: Int
    var displayTime : Bool = false
    
    var body: some View {
        
        ZStack{
            
            
            Rectangle()
                .foregroundColor(longevity.associatedColor())
                .frame(width: width, height: height)
                .clipShape(Capsule())
            TextView(title: displayTime ? longevity.associatedTime().uppercased():longevity.rawValue.uppercased(),size: textSize,weight: .medium)
                .foregroundColor(.white)
                
            
        }
        
        
    }
}

struct CapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleView(longevity: .medium, width: 42, height: 14, textSize: 7)
    }
}

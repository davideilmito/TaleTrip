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
    
    @State var flipped = false
    @State var flippedT = false
    
    var body: some View {
        
        ZStack{
            
            
            Rectangle()
                .foregroundColor(longevity.associatedColor())
                .frame(width: width, height: height)
                .clipShape(Capsule())
                .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
               
            TextView(title: self.flippedT || displayTime ? longevity.associatedTime() : longevity.rawValue.uppercased(),size: textSize,weight: .medium)
                .foregroundColor(.white)
                .rotation3DEffect(self.flipped || displayTime ? Angle(degrees: 360): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                
            
        }
        .onTapGesture {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.linear(duration: 0.4)){
            self.flipped.toggle()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.linear(duration: 0.2)){
            self.flippedT.toggle()
                }
            }
        }
        
        
    }
}

struct CapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleView(longevity: .brief, width: 40, height: 14, textSize: 7)
    }
}

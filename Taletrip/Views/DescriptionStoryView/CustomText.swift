//
//  CustomText.swift
//  Taletrip
//
//  Created by Davide Biancardi on 01/03/22.
//

import SwiftUI
import UIKit



struct CustomText: UIViewRepresentable {
    let text: String
    let font: UIFont
    let interline: CGFloat
    
    func makeUIView(context: Context) -> UILabel {
       
        let label = UILabel()
        
        label.font = font
        label.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineHeightMultiple = interline // <- Reduce lineHeight with a <1 factor
        
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSMakeRange(0, attributedString.length))
        
       
        label.attributedText = attributedString
        
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        
        
    }


}





struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText(text: "The\ndetective's\nday off".uppercased(), font: UIFont.init(name: "NewYorkMedium-Bold", size: 37)!,interline: 0.78).fixedSize()
    }
}

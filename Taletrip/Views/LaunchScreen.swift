
//  LaunchScreen.swift
//  Taletrip
//
//  Created by Willy Merlet on 02/03/22.
//

import SwiftUI

struct LaunchScreen: View {
    
    public init(){ }
    @State var text: String = ""
    @State var toggle = false
    @State var fadeout = false
    @State var easeout = false
    
    var body: some View {

            VStack{
            Text(text).animation(.spring())
                    .font(.system(size: 40, weight: .bold , design: .serif))
                    .foregroundColor(.black)
                    .frame(height: 25)
                    .padding(.bottom, 15)
            Image("launch")
                .resizable()
                .aspectRatio(contentMode: fadeout ? .fit : .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(width: fadeout ? 200 : 100)
                .transition(.opacity)
                
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut(duration: 0.8)){
                    self.fadeout.toggle()
                    
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(.easeInOut(duration: 5.0)){
                            toggle.toggle()
                        }
                    }
                }
            
            }
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
            .opacity(easeout ? 0 : 1)
            .edgesIgnoringSafeArea(.all)
            .onChange(of: toggle) { toggle in
                if toggle {
                  text = ""
                  "Taletrip".enumerated().forEach { index, character in
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                      text += String(character)
                    }
                  }
                } else {
                  text = "This is short."
                }
              }
            .onDisappear{
                    withAnimation(.easeOut(duration: 3.0)){
                        self.easeout.toggle()
                }
            }
        
        
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}

//
//  StatusBarDescriptionStoryView.swift
//  Taletrip
//
//  Created by Davide Biancardi on 22/02/22.
//

import SwiftUI

struct StatusBarDescriptionStoryView: View {
    
    var lengthOfTheStory : Longevity
    @Binding var showModal : Bool
    @EnvironmentObject var storiesStore : StoriesStore
    
    var body: some View {
        
        VStack{
        
        HStack(alignment: .center){
            
            CapsuleView(longevity: lengthOfTheStory, width: 66, height: 24, textSize: 13,displayTime: true)
                .padding(.leading,15)
            
            Spacer()
            
            Button {
                
                showModal.toggle()
                storiesStore.unshowStory(of: storiesStore.tappedStory)
                
            } label: {
                
                    Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.backgroundBeige)
                    .font(.system(size: 36))
                    .padding(.trailing,15)
                
            }
            
        }
        
            Spacer()
        
        }
        .padding(.top,10)
        .ignoresSafeArea()
    }
}

struct StatusBarDescriptionStoryView_Previews: PreviewProvider {
    static var previews: some View {
        StatusBarDescriptionStoryView(lengthOfTheStory: .medium ,showModal: .constant(true))
    }
}

//
//  EmptyMeetingView.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

struct EmptyMeetingView: View {
    
    
   // let imageName: String
    let message: String
    
    
    
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack{
            Image("meeting")
                    .resizable()
                    .scaledToFit()
                
                Text(message)
                    //.font(.title3)
                    .font(Font.custom("Avenir Heavy", size: 16))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .offset(y: -50)
        }
    }
}

struct EmptyMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyMeetingView( message: "You have no meetings listed.\n Please select some meetngs")
    }
}


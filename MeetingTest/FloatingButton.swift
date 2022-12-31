//
//  FloatingButton.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

struct FloatingButtonView: View {
    @EnvironmentObject var dateHolder: DateHolder
    var body: some View {
       // Spacer()
        HStack{
            NavigationLink(destination: AddMeetingView(selectedMeeting: nil, initialDate: Date()).environmentObject(dateHolder)) {
                Text("+ Add Meeting")
                    .font(.headline)
            }
            .padding(15)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(30)
            .padding(30)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        }
    }
}

struct FloatingButtonView_Previews: PreviewProvider {
    static var previews: some View {
       
            FloatingButtonView()
        
    }
}


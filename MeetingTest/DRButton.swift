//
//  DRButton.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

struct DRButton: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .bold()
            .frame(width: 280, height: 44)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

struct DRButton_Previews: PreviewProvider {
    static var previews: some View {
        DRButton(title: "Create Profile")
    }
}

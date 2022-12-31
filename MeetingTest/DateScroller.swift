//
//  DateScroller.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

struct DateScroller: View {
    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.managedObjectContext) var viewContext
    
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: moveBack){
                Image(systemName: "arrow.left")
                    .imageScale(.medium)
            }
            
            Text(dateFormatted())
                .font(.title)
                .animation(.none)
                .frame(maxWidth: .infinity)
            
            Button(action: moveForward) {
                Image(systemName: "arrow.right")
                    .imageScale(.medium)
            }
        }
    }
    
    func moveBack() {
        withAnimation {
            dateHolder.moveDate(days: -1, viewContext)
        }
        
    }
    
    func moveForward() {
        withAnimation {
            dateHolder.moveDate(days: +1, viewContext)
        }
    }
    
    func dateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd LLL YY"
        return dateFormatter.string(from: dateHolder.date)
    }
}

struct DateScroller_Previews: PreviewProvider {
    static var previews: some View {
        DateScroller()
    }
}


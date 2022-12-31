//
//  MeetingList.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

struct MeetingList: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    
    @State private var showOptions = false
    
    @ObservedObject var selectedMeeting: Meeting
    // @State private var showOptions = false
    
    
    
    
    var body: some View {
        HStack {
            //            MapView(location: meeting.address ?? "N/A")
            //                .scaledToFit()
            //                .frame(width: 80, height: 80)
            //                .clipShape(Rectangle())
            //                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(selectedMeeting.name ?? "n/a")
                    .font(Font.custom("Avenir Heavy ", size: 20))
                // .font(.headline)
                // .fontWeight(.regular)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                Text(selectedMeeting.address ?? "n/a" )
                    .font(Font.custom("Avenir", size: 15))
                // .font(.subheadline)
                    .fontWeight(.thin)
                    .lineLimit(3)
                if selectedMeeting.isCompleted() && selectedMeeting.isWeekly{
                   // Text(selectedMeeting.meetingDate!, formatter: itemFormatter)
                    Text(selectedMeeting.dueDateTimeOnly())
                }
                // HStack{
                //    AvatarView(size: 35)
                //   AvatarView(size: 35)
                //   AvatarView(size: 35)
                //   AvatarView(size: 35)
                // }
                
                
                if selectedMeeting.isFavourite{
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                }
            }
            .contextMenu{
                Button(action: {self.selectedMeeting.isFavourite.toggle()
                })
                {
                    HStack{
                        Text(selectedMeeting.isFavourite ? "Remove from Favourites" : "Add to Favourites")
                        Image(systemName: "heart")
                    }
                }
                
                Button(action: {self.showOptions.toggle()
                })  {
                    HStack{
                        Text("Share")
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .sheet(isPresented: $showOptions) {
                
                let defaultText = "Just checking in at \(selectedMeeting.name)"
                
                if let imageToShare = UIImage(named: "cafedeadend") {
                    ActivityView(activityItems: [defaultText, imageToShare])
                } else {
                    ActivityView(activityItems: [defaultText])
                }
            }
            
        }
    }
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
//    private func dueMeeting() -> String{
//        let due = selectedMeeting.meetingDate{
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "hh:mm a"
//            return dateFormatter.string(from: due)
//        }
//
//        return ""
//    }
    
    struct MeetingList_Previews: PreviewProvider {
        static var previews: some View {
            MeetingList(selectedMeeting: (PersistenceController.testData?.first)!)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
    
}

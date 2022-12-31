//
//  MeetingDetailView.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

struct MeetingDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var selectedMeeting: Meeting
    @State  var showMap: Bool
  
    let colums = [GridItem(.flexible()),
                  GridItem(.flexible()),
                  GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 16) {
            
//            MapView(interactionMode: [], location: meeting.address ?? "N/A")
//                .frame(minWidth: 0, maxWidth: .infinity)
//                .frame(height: 250)
//                .cornerRadius(20)
//                .padding([.leading, .trailing])
//            Spacer()
            HStack(alignment:.top) {
                VStack(alignment: .leading) {
                    Text("ADDRESS")
                        //.font(.system(.caption, design: .rounded))
                        .font(Font.custom("Avenir Heavy", size: 16))

                    Text(selectedMeeting.address ?? "n/a")
                        //.font(.headline)
                        .font(Font.custom("Avenir", size: 16))
                    .foregroundColor(.secondary)
                    .lineLimit(4)
                    
                   
                }
                .padding(.leading)
                Spacer()
                VStack{
                    Text("TIME")
                       // .font(.system(.caption, design: .rounded))
                        .font(Font.custom("Avenir Heavy", size: 16))
                    Text(dateFormatter.string(from: selectedMeeting.meetingDate!))
                   // .font(.headline)
                        .font(Font.custom("Avenir", size: 16))
                    .foregroundColor(.secondary)
                    
                }
                
                Spacer()
                
            }
            
            Text(selectedMeeting.name ?? "n/a")
               // .font(.headline)
                .font(Font.custom("Avenir Heavy", size: 16))
            
                      Text(dateFormatter.string(from: selectedMeeting.meetingDate!))
            
                //.font(.headline)
                    .font(Font.custom("Avenir Heavy", size: 16))
            
            Text(selectedMeeting.detail ?? "n/a")
                .font(Font.custom("Avenir", size: 16))
                .lineLimit(3)
                .minimumScaleFactor(0.75)
                .frame(height: 70)
                .padding(.horizontal)
            
            ZStack{
                Capsule()
                    .frame(height: 80)
                    .foregroundColor(Color(.secondarySystemBackground))

                HStack(spacing: 20){
                    Button{
                      //  viewModel.getDirections()
                        showMap = true
                    } label: {
                        DRButton(title: "View Map")
                    }


                }
            }
            .padding(.horizontal)
            
           
            
            Spacer()
            
        }
        .navigationTitle(selectedMeeting.name ?? "n/a")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar{
           // ToolbarItem(placement: .navigationBarLeading) {
            //    Button(action:{
             //       dismiss()
             //   }) {
               //     Text("\(Image(systemName: "chevron.left"))")
               // }
            //}
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    selectedMeeting.isFavourite.toggle()
                }) {
                    Image(systemName: selectedMeeting.isFavourite ? "heart.fill": "heart")
                        .font(.system(size: 25))
                        .foregroundColor(selectedMeeting.isFavourite ? .yellow : .white)
                    
                }
            }
                
            }
            
            .onChange(of: selectedMeeting) { _ in
                if self.viewContext.hasChanges{
                    try? self.viewContext.save()
                }
            }
            .sheet(isPresented: $showMap) {
              //  AddressMapView(location: meeting.address ?? "N/A")
            }
           
        }
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}

    
    struct MeetingDetailView_Previews: PreviewProvider {
        static var previews: some View {
            MeetingDetailView(selectedMeeting: (PersistenceController.testData?.first)!, showMap: true)
                .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
        }
    }


//
//  ContentView.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

struct MeetingListView: View {
    
    @Environment(\.managedObjectContext)  var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    @FetchRequest(entity: Meeting.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Meeting.meetingDate, ascending: true)],
                  animation: .default)
    var meeting: FetchedResults<Meeting>
    
    @State var selectedFilter = MeetingFilter.All
    
    
    @Environment(\.dismiss) var dismiss
    @State private var showMeeting = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                DateScroller()
                    .padding()
                    .environmentObject(dateHolder)
                ZStack {
                    ZStack {
                        List{
                            if meeting.count == 0 {
                                EmptyMeetingView(message: "You have no listed meetings.\nPlease add some meetings")
                                
                            } else {
                                ForEach (meeting.indices, id: \.self) { index in
                                    NavigationLink(destination:
                                                    MeetingDetailView(selectedMeeting: meeting[index], showMap: false)) {
                                        MeetingList(selectedMeeting: meeting[index])
                                    }
                                }
                                .onDelete(perform: deleteRecord)
                            }
                        }
                        
                        .listStyle(.plain)
                        
                    }
                }
                FloatingButtonView().environmentObject(dateHolder)
            }
            .navigationTitle("My Meetings")
            .font(Font.custom("Avenir Heavy ", size: 24))
            .navigationBarTitleDisplayMode(.automatic)
            //            .toolbar{
            //                Button(action: {
            //                    self.showMeeting = true
            //                }) {
            //                    Image(systemName: "plus")
            //                }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("", selection: $selectedFilter.animation()){
                        ForEach(MeetingFilter.allFilters, id: \.self) {
                            filter in
                            Text(filter.rawValue)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showMeeting) {
            //AddMeetingView(name: "", type: "",  meetingDate:  Date(), address: "", detail: "", isWeekly: true)
            AddMeetingView(selectedMeeting: Meeting(), initialDate: Date()).environmentObject(dateHolder)
        }
        
        
    }
    
    
    
    private func deleteRecord(indexSet: IndexSet) {
        
        for index in indexSet {
            let itemToDelete = meeting[index]
            viewContext.delete(itemToDelete)
        }
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
                
            } catch {
                print(error)
            }
        }
    }
    
    private func filteredMeeting() -> [Meeting] {
        if selectedFilter == MeetingFilter.Next{
            return dateHolder.selectedMeeting.filter{$0.isOverDue()}
        }
        
        //        if selectedFilter == MeetingFilter.time{
        //            return dateHolder.meeting.filter{$0.isTime()}
        //        }
        //
        //        if selectedFilter == MeetingFilter.favourite{
        //            return dateHolder.meeting.filter{$0.isFavour()}
        //        }
        
        return dateHolder.selectedMeeting
    }
    
    
    
    
    
    struct MeetingListView_Previews: PreviewProvider {
        static var previews: some View {
            
            // let meetingContext =  NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            
            MeetingListView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            // .environmentObject(DateHolder)
            
        }
    }
    
    
}

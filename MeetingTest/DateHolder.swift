//
//  DateHolder.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import CoreData
import SwiftUI

class DateHolder: ObservableObject {
    
    @Published var date = Date()
    @Published var selectedMeeting: [Meeting] = []
    
    let calendar: Calendar = Calendar.current
    
    init(_ context: NSManagedObjectContext) {
        refreshedMeetingItems(context)
    }
    
    func moveDate(days: Int,_ context: NSManagedObjectContext) {
        date = calendar.date(byAdding: .day, value: days, to: date)!
        
        
    }
    
    func weeklyDate(days: Int,_ context: NSManagedObjectContext) {
        date = calendar.date(byAdding: .day, value: days, to: date)!
    }
    
    
    fileprivate func refreshedMeetingItems(_ context: NSManagedObjectContext) {
        selectedMeeting = fetchMeetingItem(context)
    }
    
    func fetchMeetingItem(_ context: NSManagedObjectContext) -> [Meeting] {
        do {
            return try context.fetch(dailyFetch()) as [Meeting]
        }
        catch let error {
            fatalError("Unresolved error \(error)")
            
        }
    }
    
    func dailyFetch() -> NSFetchRequest<Meeting> {
        let request = Meeting.fetchRequest()
        
        request.sortDescriptors = sortOrder()
        request.predicate = predicate()
        return request
    }
    
    private func sortOrder() -> [NSSortDescriptor] {
        let daySort = NSSortDescriptor(keyPath: \Meeting.meetingDate, ascending: true)
       // let timeSort = NSSortDescriptor(keyPath: \Meeting.meetingTime, ascending: true)
        let favouriteSort = NSSortDescriptor(keyPath: \Meeting.isFavourite, ascending: true)
        
        return [daySort, favouriteSort]
    }
    
    private func predicate() -> NSPredicate {
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        
        return NSPredicate(format: "meetingDate >= %@ AND meetingDate <= %@", start as NSDate, end! as NSDate)
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
            refreshedMeetingItems(context)
            
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
}

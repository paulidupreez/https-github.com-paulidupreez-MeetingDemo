//
//  Meeting+Extn.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

extension Meeting {
    
    func isCompleted() -> Bool {
        return meetingDate != nil
    }
    

    func isOverDue() -> Bool {
        if let due = meetingDate {
            return !isCompleted() && isWeekly && due < Date()
        }
        return false
    }

    func overDueColor() -> Color {
        return isOverDue() ? .red : .black
    }
    
    
    func dueDateTimeOnly() -> String {
        
        if let due = meetingDate{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: due)
        }
        
        
        return ""
    }
    
}

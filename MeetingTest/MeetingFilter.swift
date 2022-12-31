//
//  MeetingFilter.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

enum MeetingFilter: String {
    
    static var allFilters: [MeetingFilter] {
        return [.Next,.All]
    }
    
    case All = "All"
    case Next = "Next"
    
    
    
}

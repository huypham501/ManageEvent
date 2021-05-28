//
//  EventManager.swift
//  ManageEvent
//
//  Created by TMA on 26/05/2021.
//

import Foundation
import EventKit
import UIKit

class EventManager {
    let eventStore = EKEventStore()
    
    public func checkAuthorization() -> Bool {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        print("Checking")
        
        switch status {
        case .notDetermined:
            print("Not Determined")
        case .authorized:
            print("Authorized")
            return true
        case .denied:
            print("Denied")
        case .restricted:
            print("Restricted")
        default:
            print("Default")
        }
        
        return false
    }
    
    public func requestAccess() -> Bool{
        print("REQUEST")
        
        eventStore.requestAccess(to: EKEntityType.event) {
            (granted, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error request access")
                
            }
        }
        
        return eventStore.accessibilityActivate()
    }
    
    public func loadCalendar() -> [EKCalendar] {
        return eventStore.calendars(for: EKEntityType.event)
    }
}


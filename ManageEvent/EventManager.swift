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
            return requestAccess()
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
        
        print("Status checking : \(status)" )
        return false
    }
    
    public func requestAccess() -> Bool{
        print("REQUEST")
        
        var status:Bool?
        
        let mySemaphore : DispatchSemaphore = DispatchSemaphore(value: 0)
        
        eventStore.requestAccess(to: EKEntityType.event) {
            (granted, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error request access")
            }
            status = granted
            mySemaphore.signal()

        }
        mySemaphore.wait()
        
        print("Status request : \(((status) != nil))")
        
        return ((status) != nil)
    }
    
    public func loadEvent(startDate:Date, endDate:Date) -> [EKEvent] {
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        return eventStore.events(matching: predicate)
    }
}


//
//  NotificationCenter+AppEvents.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 13/12/2018.
//

#if os(OSX)
import AppKit
#elseif os(iOS)
import UIKit
#endif

internal protocol AppEventsNotificationCenter {
    func observeAppWillEnterBackgroundEvent(callback: @escaping () -> ())
    func observeAppWillTerminateEvent(callback: @escaping () -> ()) -> ObservationToken
}

extension NotificationCenter: AppEventsNotificationCenter {
    
    func observeAppWillEnterBackgroundEvent(callback: @escaping () -> ()) {
        
    }
    
    func observeAppWillTerminateEvent(callback: @escaping () -> ()) -> ObservationToken {
        let notificationName: NSNotification.Name
        #if os(OSX)
        notificationName = NSApplication.willTerminateNotification
        #elseif os(iOS)
        notificationName = UIApplication.willTerminateNotification
        #endif
        let token = self.addObserver(forName: notificationName, object: nil, queue: .main) { _ in
            callback()
        }
        
        return ObservationToken(notificationCenter: self, token: token, notificationName: notificationName)
    }
}

//
//  ObservationToken.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.06.2018.
//

import Foundation

public class ObservationToken {
    
    private let notificationCenter: NotificationCenter
    private let token: NSObjectProtocol
    private let notificationName: Notification.Name
    
    internal init(notificationCenter: NotificationCenter,
                  token: NSObjectProtocol,
                  notificationName: Notification.Name) {
        self.notificationCenter = notificationCenter
        self.token = token
        self.notificationName = notificationName
    }
    
    deinit {
        notificationCenter.removeObserver(token, name: notificationName, object: nil)
    }
}

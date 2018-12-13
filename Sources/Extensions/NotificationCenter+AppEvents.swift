//
//  NotificationCenter+AppEvents.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 13/12/2018.
//

import Foundation

internal protocol AppEventsNotificationCenter {
    func observeAppWillEnterBackgroundEvent(callback: @escaping () -> ())
    func observeAppWillTerminateEvent(callback: @escaping () -> ())
}

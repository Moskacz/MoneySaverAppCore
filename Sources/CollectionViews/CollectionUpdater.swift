//
//  TableViewUpdater.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 14.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import CoreData

protocol CollectionUpdater {
    func beginUpdates()
    func endUpdates()
    
    func insertRow(at indexPaths: [IndexPath])
    func deleteRow(at indexPaths: [IndexPath])
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath)
    func reload(at indexPaths: [IndexPath])
    
    func insertSection(index: Int)
    func deleteSection(index: Int)
    
    func reloadAll()
}

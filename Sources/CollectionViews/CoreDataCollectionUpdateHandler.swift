//
//  CoreDataCollectionUpdateHandler.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 14.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataCollectionUpdateHandler: NSObject, NSFetchedResultsControllerDelegate {
    
    private let collectionUpdater: CollectionUpdater
    
    public init(collectionUpdater: CollectionUpdater) {
        self.collectionUpdater = collectionUpdater
    }
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionUpdater.beginUpdates()
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            collectionUpdater.insertSection(index: sectionIndex)
        case .delete:
            collectionUpdater.deleteSection(index: sectionIndex)
        case .update, .move:
            break
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            collectionUpdater.insertRow(at: [newIndexPath!])
        case .delete:
            collectionUpdater.deleteRow(at: [indexPath!])
        case .update:
            collectionUpdater.reload(at: [indexPath!])
        case .move:
            collectionUpdater.move(from: indexPath!, to: newIndexPath!)
        }
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionUpdater.endUpdates()
    }
}

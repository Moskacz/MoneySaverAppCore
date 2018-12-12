//
//  CoreDataTransactionCategoryRepository.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 17.09.2018.
//

import Foundation
import MMFoundation
import CoreData

internal class CoreDataTransactionCategoryRepository: TransactionCategoryRepository {
    
    private let context: NSManagedObjectContext
    
    internal init(context: NSManagedObjectContext, userPrefs: UserPreferences) {
        self.context = context
        
        if !userPrefs.initialDataInsertDone {
            performInitialInsert()
            userPrefs.initialDataInsertDone = true
        }
    }
    
    private func performInitialInsert() {
        let categoriesData = [(Image(named: "bill")!, "Bills"),
                              (Image(named: "car")!, "Clothes"),
                              (Image(named: "cosmetics")!, "Cosmetics"),
                              (Image(named: "education")!, "Education"),
                              (Image(named: "gift")!, "Gift"),
                              (Image(named: "groceries")!, "Groceries"),
                              (Image(named: "bill")!, "Bills"),
                              (Image(named: "health")!, "Health"),
                              (Image(named: "homeware")!, "Homeware"),
                              (Image(named: "party")!, "Party"),
                              (Image(named: "publictransport")!, "Public transport"),
                              (Image(named: "travel")!, "Travel")]
        for data in categoriesData {
            let category = TransactionCategoryManagedObject.createEntity(inContext: context)
            category.cd_identifier = UUID()
            category.cd_icon = data.0.pngRepresentation as NSData?
            category.cd_name = data.1
        }
        try! context.save()
    }
    
    var allCategoriesResultController: ResultsController<TransactionCategoryProtocol> {
        let request: NSFetchRequest<TransactionCategoryManagedObject> = TransactionCategoryManagedObject.fetchRequest()
        request.fetchBatchSize = 20
        request.sortDescriptors = [NSSortDescriptor(key: TransactionCategoryManagedObject.KeyPaths.name.string,
                                                    ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return TransactionCategoryResultsController(controller: frc)
    }
    
    func addCategory(with data: TransactionCategoryData) {
        context.perform {
            let category = TransactionCategoryManagedObject.createEntity(inContext: self.context)
            category.cd_name = data.name
//            category.cd_icon = //
        }
    }
}

private class TransactionCategoryResultsController: ResultsController<TransactionCategoryProtocol> {
    
    private let controller: ResultsController<TransactionCategoryManagedObject>
    
    internal init(controller: NSFetchedResultsController<TransactionCategoryManagedObject>) {
        self.controller = CoreDataResultsController(frc: controller)
    }
    
    override var delegate: ResultsControllerDelegate? {
        set { controller.delegate = newValue }
        get { return controller.delegate }
    }
    
    override func loadData() throws {
        try controller.loadData()
    }
    
    override var sectionsCount: Int {
        return controller.sectionsCount
    }
    
    override func objectsIn(section: Int) -> [TransactionCategoryProtocol]? {
        return controller.objectsIn(section: section)
    }
    
    override func object(at indexPath: IndexPath) -> TransactionCategoryProtocol {
        return controller.object(at: indexPath)
    }
}

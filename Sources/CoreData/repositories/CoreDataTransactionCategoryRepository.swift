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
    
    internal init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    var allCategoriesResultController: ResultsController<TransactionCategoryProtocol> {
        let request: NSFetchRequest<TransactionCategoryManagedObject> = TransactionCategoryManagedObject.fetchRequest()
        request.fetchBatchSize = 20
        request.sortDescriptors = [NSSortDescriptor(key: TransactionCategoryManagedObject.KeyPaths.name.rawValue,
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

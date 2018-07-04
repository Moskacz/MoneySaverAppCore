//
//  BudgetRepositoryImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 04.07.2018.
//

import Foundation
import CoreData

internal class BudgetRepositoryImpl: BudgetRepository {
    
    private let context: NSManagedObjectContext
    private let logger: Logger
    
    internal init(context: NSManagedObjectContext, logger: Logger) {
        self.context = context
        self.logger = logger
    }
    
    func observeBudgetChanged(completion: @escaping ((BudgetProtocol) -> Void)) -> ObservationToken {
        fatalError()
    }
    
    private func makeEntitiesFRC() -> NSFetchedResultsController<BudgetManagedObject> {
        let request = allEntitiesFetchRequest
        request.sortDescriptors = [BudgetManagedObject.SortDescriptors.value.descriptor]
        
        return NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: context,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }
    
    internal func saveBudget(withValue value: Decimal) {
        let request = allEntitiesFetchRequest
        do {
            let entities = try context.fetch(request)
            if entities.isEmpty {
                createNewBudget(value: value)
            } else {
                updateBudget(value: value, entities: entities)
            }
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
    
    private func createNewBudget(value: Decimal) {
        let entity = BudgetManagedObject.createEntity(inContext: context)
        entity.value = value as NSDecimalNumber
    }
    
    private func updateBudget(value: Decimal, entities: [BudgetManagedObject]) {
        if entities.count > 1 {
            for entity in entities.dropFirst() {
                context.delete(entity)
            }
        } else {
            let entity = entities[0]
            entity.value = value as NSDecimalNumber
        }
    }
    
    private var allEntitiesFetchRequest: NSFetchRequest<BudgetManagedObject> {
        return BudgetManagedObject.fetchRequest()
    }
}

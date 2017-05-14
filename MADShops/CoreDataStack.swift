
import Foundation
import CoreData

struct CoreDataStack {
    
    // MARK: - Static Properties
    private static let _sharedInstance = CoreDataStack()
    static var sharedInstance: CoreDataStack {
        get {
            return _sharedInstance
        }
    }
    
    // MARK: - Static methods
    private static func loadDataModel() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "MADShops")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("Store URL: \(String(describing: storeDescription.url))")
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    // MARK: - Instance properties
    private let _container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        get {
            return _container.viewContext
        }
    }
    
    // MARK: - Constructor
    private init() {
        _container = CoreDataStack.loadDataModel()
    }
    
    // MARK: - Instance methods
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



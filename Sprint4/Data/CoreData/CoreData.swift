import Foundation
import CoreData

class Sprint4CoreData: ObservableObject {
    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    init() {
        container = NSPersistentContainer (name: "Sprint4")
        setupDatabase()
    }
    func setupDatabase() {
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

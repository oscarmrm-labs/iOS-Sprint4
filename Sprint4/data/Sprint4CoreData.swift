import Foundation
import CoreData

final class ContactsProvider {
    
    static let shared = ContactsProvider()
    
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer (name: "Sprint4")
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
}

import Foundation
import CoreData

final class ContactEntity: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var lastName: String
    @NSManaged var dateOfBirth: Date
    @NSManaged var favouriteColor: String
    @NSManaged var favouriteSport: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}

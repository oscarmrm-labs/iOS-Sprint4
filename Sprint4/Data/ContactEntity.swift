import Foundation
import CoreData

final class ContactModel: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var lastName: String
    @NSManaged var dateOfBirth: String
    @NSManaged var favouriteColor: String
    @NSManaged var favouriteSport: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}

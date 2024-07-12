import Foundation
import SwiftUI
import CoreData

struct DetailScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var contact: FetchedResults<ContactsEntity>
    
    init(contactID: UUID) {
        _contact = FetchRequest<ContactsEntity>(
            entity: ContactsEntity.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "id == %@", contactID as CVarArg)
        )
    }
    
    var body: some View {
        if let contact = contact.first {
            VStack(alignment: .leading) {
                Text("Name: \(contact.name ?? "N/A")")
                Text("Last Name: \(contact.lastName ?? "N/A")")
                Text("Date of Birth: \(contact.dateOfBirth ?? Date(), formatter: DateFormatter.shortDate)")
                Text("Favourite Color: \(contact.favouriteColor ?? "N/A")")
                Text("Favourite Sport: \(contact.favouriteSport ?? "N/A")")
                Text("Latitude: \(contact.latitude)")
                Text("Longitude: \(contact.longitude)")
            }
            .padding()
            .navigationTitle("\(contact.name ?? "") \(contact.lastName ?? "")")
        } else {
            Text("Contact not found")
                .padding()
        }
    }
}

extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}


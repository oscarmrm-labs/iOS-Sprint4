import SwiftUI

struct DetailScreen: View {
    @StateObject private var viewModel: ContactDetailViewModel
    
    init(coreData: Sprint4CoreData, contactID: UUID) {
        let repository = ContactsRepository(coreData: coreData)
        let useCase = ContactsUseCase(contactsRepository: repository)
        _viewModel = StateObject(wrappedValue: ContactDetailViewModel(useCase: useCase, contactID: contactID))
    }

    var body: some View {
        if let contact = viewModel.contact {
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
            .navigationTitle("\(contact.name ?? "N/A") \(contact.lastName ?? "N/A")")
        } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .padding()
        } else {
            Text("Contact not found")
                .padding()
        }
    }
}

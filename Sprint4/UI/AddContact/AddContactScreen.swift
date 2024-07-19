import Foundation
import SwiftUI
import CoreData

struct AddContactScreen: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var viewModel: AddContactViewModel

    init(coreData: Sprint4CoreData) {
        let repository = ContactsRepository(coreData: coreData)
        let useCase = ContactsUseCase(contactsRepository: repository)
        _viewModel = StateObject(wrappedValue: AddContactViewModel(useCase: useCase))
    }

    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Name", text: $viewModel.name)
                TextField("Last Name", text: $viewModel.lastName)
                DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                TextField("Favourite Color", text: $viewModel.favouriteColor)
                TextField("Favourite Sport", text: $viewModel.favouriteSport)
            }

            Section(header: Text("Location")) {
                TextField("Latitude", value: $viewModel.latitude, formatter: NumberFormatter())
                TextField("Longitude", value: $viewModel.longitude, formatter: NumberFormatter())
            }
        }
        .navigationBarTitle("Add Contact", displayMode: .inline)
        .navigationBarItems(trailing: Button("Save") {
            viewModel.addContact()
            if viewModel.errorMessage == nil {
                presentationMode.wrappedValue.dismiss()
            }
        })
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

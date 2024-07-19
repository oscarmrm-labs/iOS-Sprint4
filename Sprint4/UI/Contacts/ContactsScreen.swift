import SwiftUI
import CoreData

struct ContactScreen: View {
    @StateObject private var viewModel: ContactsViewModel
    @State private var contacts: [ContactsEntity] = []
    let coreData: Sprint4CoreData

    init(coreData: Sprint4CoreData) {
        self.coreData = coreData
        let repository = ContactsRepository(coreData: coreData)
        let useCase = ContactsUseCase(contactsRepository: repository)
        _viewModel = StateObject(wrappedValue: ContactsViewModel(useCase: useCase))
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                contactList()
                    .onAppear {
                        viewModel.loadContacts()
                    }
                    .navigationTitle("Contacts")
                    .overlay(
                        floatingActionButton()
                    )
            }
        }
    }

    func contactList() -> some View {
        List {
            ForEach(viewModel.filteredContacts, id: \.self) { contact in
                NavigationLink(destination: DetailScreen(contactID: contact.id!)) {
                    VStack(alignment: .leading) {
                        Text(contact.name ?? "No Name")
                            .font(.headline)
                        Text(contact.lastName ?? "No Last Name")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
    
    func floatingActionButton() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: AddContactScreen(coreData: coreData)) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
            }
        }
    }
}

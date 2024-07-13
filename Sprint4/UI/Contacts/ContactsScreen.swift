import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: ContactsViewModel

    var body: some View {
        NavigationView {
            VStack{
                SearchBar(text: $viewModel.searchText)
                contactList()
                .navigationTitle("Contacts")
                .overlay(
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(destination: AddContactScreen()) {
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
}

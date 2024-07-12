import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: ContactsEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ContactsEntity.name, ascending: true)]
    ) private var contacts: FetchedResults<ContactsEntity>
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                SearchBar(text: $searchText)
                List {
                    ForEach(filteredContacts, id: \.self) { contact in
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
    private var filteredContacts: [ContactsEntity] {
        if searchText.isEmpty {
            return Array(contacts)
        } else {
            return contacts.filter {
                ($0.name?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                ($0.lastName?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
}

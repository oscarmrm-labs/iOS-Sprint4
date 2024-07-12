import Foundation
import SwiftUI
import CoreData

struct AddContactScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var favouriteColor: String = ""
    @State private var favouriteSport: String = ""
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Name", text: $name)
                TextField("Last Name", text: $lastName)
                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                TextField("Favourite Color", text: $favouriteColor)
                TextField("Favourite Sport", text: $favouriteSport)
            }
            
            Section(header: Text("Location")) {
                TextField("Latitude", value: $latitude, formatter: NumberFormatter())
                TextField("Longitude", value: $longitude, formatter: NumberFormatter())
            }
        }
        .navigationBarTitle("Add Contact", displayMode: .inline)
        .navigationBarItems(trailing: Button("Save") {
            addContact()
        })
    }
    
    private func addContact() {
        let newContact = ContactsEntity(context: viewContext)
        newContact.id = UUID()
        newContact.name = name
        newContact.lastName = lastName
        newContact.dateOfBirth = dateOfBirth
        newContact.favouriteColor = favouriteColor
        newContact.favouriteSport = favouriteSport
        newContact.latitude = latitude
        newContact.longitude = longitude
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

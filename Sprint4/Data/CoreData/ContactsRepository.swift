import Foundation
import CoreData


struct ContactsRepository {
    private let coreData: Sprint4CoreData
    
    init(coreData: Sprint4CoreData) {
        self.coreData = coreData
    }
    
    func getContactsList(completion: @escaping(Result<[ContactsEntity], Error>) -> Void) {
        let context = coreData.context
        context.perform {
            let fetchRequest: NSFetchRequest<ContactsEntity> = ContactsEntity.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            
            do {
                let result = try context.fetch(fetchRequest)
                print(result)
                completion(.success(result))
            } catch {
                print("Repository -> Error en la busqueda")
            }
        }
    }
    
    func insertContact(contact: ContactModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = coreData.container.viewContext
        let newContact = ContactsEntity(context: context)
        newContact.id = UUID()
        newContact.name = contact.name
        newContact.lastName = contact.lastName
        newContact.dateOfBirth = contact.dateOfBirth
        newContact.favouriteColor = contact.favouriteColor
        newContact.favouriteSport = contact.favouriteSport
        newContact.latitude = contact.latitude
        newContact.longitude = contact.longitude
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getContact(byID id: UUID, completion: @escaping (Result<ContactsEntity?, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<ContactsEntity> = ContactsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let results = try coreData.context.fetch(fetchRequest)
            completion(.success(results.first))
        } catch {
            completion(.failure(error))
        }
    }
}

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
}

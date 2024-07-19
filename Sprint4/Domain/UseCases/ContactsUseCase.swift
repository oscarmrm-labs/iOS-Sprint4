import Foundation

struct ContactsUseCase {
    private let contactsRepository: ContactsRepository
    
    init(contactsRepository: ContactsRepository) {
        self.contactsRepository = contactsRepository
    }
    
    func getContactsList(completion: @escaping(Result<[ContactsEntity], Error>) -> Void) {
        contactsRepository.getContactsList { result in
            completion(result)
        }
    }
    
    func addContact(contact: ContactModel, completion: @escaping (Result<Void, Error>) -> Void) {
        contactsRepository.addContact(contact: contact, completion: completion)
    }
}

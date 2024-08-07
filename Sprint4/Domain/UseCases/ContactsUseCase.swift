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
        contactsRepository.insertContact(contact: contact, completion: completion)
    }
    
    func execute(contactID: UUID, completion: @escaping (Result<ContactsEntity?, Error>) -> Void) {
        contactsRepository.getContact(byID: contactID, completion: completion)
    }
}

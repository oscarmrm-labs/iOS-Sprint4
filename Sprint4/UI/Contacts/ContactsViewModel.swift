import Foundation
import SwiftUI
import CoreData
import Combine

class ContactsViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published private(set) var filteredContacts: [ContactsEntity] = []

    private let contactsUseCase: ContactsUseCase
    private let contactsPublisher: PassthroughSubject<[ContactsEntity], Never> = .init()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: ContactsUseCase) {
        self.contactsUseCase = useCase
        loadContacts()
        setupFilteredContactsPublisher()
    }
    
    var contact: AnyPublisher<[ContactsEntity], Never> {
        contactsPublisher.eraseToAnyPublisher()
    }
    
    private func setupFilteredContactsPublisher() {
        $searchText
            .combineLatest(contact)
            .map { searchText, contacts in
                contacts.filter {
                    searchText.isEmpty ||
                    ($0.name?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                    ($0.lastName?.localizedCaseInsensitiveContains(searchText) ?? false)
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredContacts)
    }
    
    func loadContacts() {
        contactsUseCase.getContactsList { [weak self] result in
            switch result {
                case .success(let data):
                    print(data)
                    self?.contactsPublisher.send(data)
                case .failure(let error):
                    print(error)
            }
        }
    }
}

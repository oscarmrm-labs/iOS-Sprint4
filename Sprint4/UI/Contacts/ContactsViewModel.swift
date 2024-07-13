import Foundation
import SwiftUI
import CoreData
import Combine

class ContactsViewModel: ObservableObject {
    
    private let contactsUseCase: ContactsUseCase
    private let contactsPublisher: PassthroughSubject<[ContactsEntity], Never> = .init()
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: ContactsUseCase) {
        self.contactsUseCase = useCase
        loadContacts()
        setupFilteredContactsPublisher()
    }
    
    var contacts: AnyPublisher<[ContactsEntity], Never> {
        contactsPublisher.eraseToAnyPublisher()
    }
    
    @Published private(set) var filteredContacts: [ContactsEntity] = []
    
    private func setupFilteredContactsPublisher() {
        $searchText
            .combineLatest(contacts)
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

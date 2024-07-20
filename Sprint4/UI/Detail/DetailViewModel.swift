import SwiftUI
import Combine

class ContactDetailViewModel: ObservableObject {
    @Published var contact: ContactsEntity?
    @Published var errorMessage: String?

    private let contactsUseCase: ContactsUseCase
    private var cancellables = Set<AnyCancellable>()

    init(useCase: ContactsUseCase, contactID: UUID) {
        self.contactsUseCase = useCase
        fetchContactDetail(contactID: contactID)
    }

    func fetchContactDetail(contactID: UUID) {
        contactsUseCase.execute(contactID: contactID) { [weak self] result in
            switch result {
            case .success(let contact):
                DispatchQueue.main.async {
                    self?.contact = contact
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Error fetching contact: \(error.localizedDescription)"
                }
            }
        }
    }
}

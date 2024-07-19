import Foundation
import Combine

class AddContactViewModel: ObservableObject {
    private let useCase: ContactsUseCase
    private var cancellables = Set<AnyCancellable>()

    @Published var name: String = ""
    @Published var lastName: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var favouriteColor: String = ""
    @Published var favouriteSport: String = ""
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var errorMessage: String = ""

    init(useCase: ContactsUseCase) {
        self.useCase = useCase
    }

    func addContact() {
        let contact = ContactModel(
            name: name,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            favouriteColor: favouriteColor,
            favouriteSport: favouriteSport,
            latitude: latitude,
            longitude: longitude
        )

        useCase.addContact(contact: contact) { [weak self] result in
            switch result {
            case .success:
                self?.clearFields()
            case .failure(let error):
                print("error in contact insert")
            }
        }
    }

    private func clearFields() {
        name = ""
        lastName = ""
        dateOfBirth = Date()
        favouriteColor = ""
        favouriteSport = ""
        latitude = 0.0
        longitude = 0.0
    }
}

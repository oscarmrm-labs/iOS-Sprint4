import Foundation
import Combine
import CoreLocation

class AddContactViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let useCase: ContactsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    private var locationManager: CLLocationManager?

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
        super.init()
        configureLocationManager()
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
                DispatchQueue.main.async {
                    self?.errorMessage = "Error in contact insert: \(error.localizedDescription)"
                }
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
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager?.distanceFilter = kCLDistanceFilterNone
        locationManager?.requestWhenInUseAuthorization()
    }

    func requestCurrentLocation() {
        locationManager?.startUpdatingLocation()
    }

    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async { [weak self] in
                self?.latitude = location.coordinate.latitude
                self?.longitude = location.coordinate.longitude
                // Consider stopping updates if you want just one location
                self?.locationManager?.stopUpdatingLocation()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = "Failed to find user's location: \(error.localizedDescription)"
        }
    }
}

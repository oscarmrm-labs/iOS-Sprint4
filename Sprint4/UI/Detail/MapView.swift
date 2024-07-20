import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let latitude: Double
    let longitude: Double

    func makeUIView(context: Context) -> MKMapView {
        return MKMapView(frame: .zero)
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = false
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

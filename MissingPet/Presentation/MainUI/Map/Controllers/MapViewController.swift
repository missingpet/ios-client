//
//  MapViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit
import MapKit

class MapViewController: Controller<MapPresenter>, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()

        /*for announcement in presenter!.announcementRepository.feed {
            let annotation = AnnouncementPointAnnotation(id: announcement.id)
            annotation.coordinate = CLLocationCoordinate2D(latitude: announcement.latitude, longitude: announcement.longitude)
            mapView.addAnnotation(annotation)
        }*/
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation is AnnouncementPointAnnotation else { return nil }

        let identifier = "AnnouncementAnnotationView"

        var announcementAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if announcementAnnotationView == nil {
            announcementAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            announcementAnnotationView!.annotation = annotation
        }

        announcementAnnotationView!.image = UIImage(named: "map-marker-blue")!

        return announcementAnnotationView
    }

    func mapView(_ mapView: MKMapView, didSelect: MKAnnotationView) {
        guard let annotation = didSelect.annotation as? AnnouncementPointAnnotation else { return }
        let announcementId = annotation.id

        #if DEBUG
        print("Annotation with announcement id \(announcementId) has selected")
        #endif

        //presenter?.pushInspectAnnouncementViewController(with: announcement)

        self.mapView.deselectAnnotation(annotation, animated: false)
    }

    func mapView(_ mapView: MKMapView, didDeselect: MKAnnotationView) {}

}

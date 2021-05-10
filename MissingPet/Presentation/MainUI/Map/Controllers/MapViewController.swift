//
//  MapViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit
import MapKit

class MapViewController: Controller<MapPresenter>, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var largeActivityIndicatorView: UIActivityIndicatorView!

    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        presenter?.reloadResults = { [weak self] in
            if let annotations = self?.mapView.annotations {
                self?.mapView.removeAnnotations(annotations)
            }
            if let items = self?.presenter?.getItems() {
                for item in items {
                    let annotation = AnnouncementPointAnnotation(id: item.id)
                    annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude,
                                                                   longitude: item.longitude)
                    self?.mapView.addAnnotation(annotation)
                }
            }
        }
        presenter?.startLoadingSetter = { [weak self] in
            self?.loadingView.isHidden = false
            self?.largeActivityIndicatorView.startAnimating()
            self?.view.isUserInteractionEnabled = false
            self?.tabBarController?.view.isUserInteractionEnabled = false
        }
        presenter?.stopLoadingSetter = { [weak self] in
            self?.loadingView.isHidden = true
            self?.largeActivityIndicatorView.stopAnimating()
            self?.view.isUserInteractionEnabled = true
            self?.tabBarController?.view.isUserInteractionEnabled = true
        }

        super.viewDidLoad()

        mapView.delegate = self

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()

        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation,
                                            latitudinalMeters: 800,
                                            longitudinalMeters: 800)
            mapView.setRegion(region, animated: false)
        }

        presenter?.loadItems()
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
        presenter?.openConcreteItem(self, id: annotation.id)
        mapView.deselectAnnotation(annotation, animated: false)
    }

}

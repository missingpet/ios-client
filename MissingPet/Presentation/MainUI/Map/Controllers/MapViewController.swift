//
//  MapViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit
import MapKit

class MapViewController: Controller<MapPresenter>, MKMapViewDelegate {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var largeActivityIndicatorView: UIActivityIndicatorView!

    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        presenter?.reloadResults = { [weak self] (_) in
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
        presenter?.loadingSetter = { [weak self] isLoading in
            if isLoading {
                self?.loadingView.isHidden = false
                self?.largeActivityIndicatorView.startAnimating()
                self?.view.isUserInteractionEnabled = false
                self?.tabBarController?.view.isUserInteractionEnabled = false
            } else {
                self?.loadingView.isHidden = true
                self?.largeActivityIndicatorView.stopAnimating()
                self?.view.isUserInteractionEnabled = true
                self?.tabBarController?.view.isUserInteractionEnabled = true
            }
        }

        super.viewDidLoad()

        mapView.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()

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
        presenter?.openConcreteItem(id: annotation.id)
        self.mapView.deselectAnnotation(annotation, animated: false)
    }

    func mapView(_ mapView: MKMapView, didDeselect: MKAnnotationView) {}

}

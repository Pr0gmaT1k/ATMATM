//
//  HomeViewController.swift
//  atmatm
//
//  Created by azerty on 13/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa
import RealmSwift

/// The main VC (the first) who show the atm on the map.
final class HomeViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK:- IBAction
    @IBAction func locateButtonDidTouch(_ sender: Any) {
        self.mapView.setRegion(MKCoordinateRegion(center: lastKnowedLoc.value, latitudinalMeters: 3000, longitudinalMeters: 3000), animated: true)
    }
    
    // MARK:- Private properties
    private var token: NotificationToken?
    private let disposeBag = DisposeBag()
    private let realm = Realm.safeInstance()
    private let geoServ = GeolocationService.instance
    private let lastKnowedLoc = Variable(CLLocationCoordinate2D())
    private let defaultRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.880740,
                                                                                  longitude: 8.577222),
                                                   latitudinalMeters: 400000,
                                                   longitudinalMeters: 400000)
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.register(SonectAnnoationView.self, forAnnotationViewWithReuseIdentifier: SonectAnnoationView.reuseIdentifier)
        self.mapView.setRegion(defaultRegion, animated: true) // Set switherland as default
        
        let realmAtms = realm.objects(Atm.self)
        let atms: [Atm] = realmAtms.compactMap { $0 }
        let atmPin = atms.compactMap { SonectAnnotation(atm: $0) }
        self.mapView.addAnnotations(atmPin)
        token = realmAtms.observe { [weak self] (changes: RealmCollectionChange) in
            guard let newValue: [Atm] = (self?.realm.objects(Atm.self).compactMap { $0 }) else { return }
            let atmPin = newValue.compactMap { SonectAnnotation(atm: $0) }
            self?.mapView.removeAnnotations(self?.mapView.annotations ?? [])
            self?.mapView.addAnnotations(atmPin)
        }
        
        geoServ.location
            .drive(lastKnowedLoc)
            .disposed(by: disposeBag)
    }
    
    private func annotationfromAtm(atm: Atm) -> MKPointAnnotation {
        let annoation = MKPointAnnotation.init()
        guard let latitudeStr = atm.latitude,
            let longitudeStr = atm.longitude,
            let latitude = Double(latitudeStr),
            let longitude = Double(longitudeStr) else { return annoation }
        
        annoation.coordinate.latitude = latitude
        annoation.coordinate.longitude = longitude
        return annoation
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? SonectAnnotation else { return nil }
        let annotationView = SonectAnnoationView(annotation: annotation, reuseIdentifier: SonectAnnoationView.reuseIdentifier)
        annotationView.fill(atm: annotation.atm)
        return annotationView
    }
}

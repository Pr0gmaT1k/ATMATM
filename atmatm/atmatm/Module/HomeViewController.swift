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

/// The main VC (the first) who show the atm on the map.
final class HomeViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK:- IBAction
    @IBAction func locateButtonDidTouch(_ sender: Any) {
        self.mapView.setCenter(lastKnowedLoc.value, animated: true)
    }
    
    // MARK:- Private properties
    private let disposeBag = DisposeBag()
    private let sonectWS = SonectWSClient()
    private let geoServ = GeolocationService.instance
    private let lastKnowedLoc = Variable(CLLocationCoordinate2D())
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.register(SonectAnnoationView.self, forAnnotationViewWithReuseIdentifier: SonectAnnoationView.reuseIdentifier)
        
        geoServ.location
            .drive(lastKnowedLoc)
            .disposed(by: disposeBag)
        
        sonectWS.getAtm()
        .observeOn(MainScheduler.instance)
        .subscribe { event in
            switch event {
            case .completed: break
            case .error(let error): print(error)
            case .next(let atms):
                let atmPin = atms?.compactMap { SonectAnnotation(atm: $0) }
                self.mapView.addAnnotations(atmPin ?? [])
            }
        }.disposed(by: disposeBag)
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

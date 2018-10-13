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

/// The main VC (the first) who show the atm on the map.
final class HomeViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK:- Private properties
    private let disposeBag = DisposeBag()
    private let sonectWS = SonectWSClient()
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sonectWS.getAtm()
        .observeOn(MainScheduler.instance)
        .subscribe { event in
            switch event {
            case .completed: break
            case .error(let error): print(error)
            case .next(let atms):
                print(atms)
            }
        }.disposed(by: disposeBag)
    }
}

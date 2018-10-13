//
//  ViewController.swift
//  atmatm
//
//  Created by azerty on 13/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let sonectWS = SonectWSClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sonectWS.getAtm().observeOn(MainScheduler.instance)
        .subscribe { event in
            switch event {
            case .completed: break
            case .error(let error): print(error)
            case .next: break
            }
        }.disposed(by: disposeBag)
    }
}

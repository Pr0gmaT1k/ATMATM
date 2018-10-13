//
//  Sync.swift
//  atmatm
//
//  Created by azerty on 14/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

final class Sync {
    // MARK:- Properties
    private let sonectWS = SonectWSClient()
    private let realm = Realm.safeInstance()
    private let disposeBag = DisposeBag()
    
    // MARK:- func
    func sync() {
        sonectWS.getAtm()
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .completed: break
                case .error(let error): print(error)
                case .next(let atms):
                    guard let atms = atms else { return }
                    try? self.realm.write {
                        self.realm.add(atms, update: true)
                    }
                }
            }.disposed(by: disposeBag)
    }
    
}

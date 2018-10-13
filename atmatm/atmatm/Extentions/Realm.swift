//
//  Realm.swift
//  issoues
//
//  Created by azerty on 27/09/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

extension Realm {
    static func safeInstance() -> Realm {
        do {
            return try Realm()
        } catch {
            fatalError("\(error)")
        }
    }
}

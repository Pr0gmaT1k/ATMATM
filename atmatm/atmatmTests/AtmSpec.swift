//
//  AtmSpec.swift
//  atmatmTests
//
//  Created by azerty on 14/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RealmSwift
@testable import atmatm

class AtmSpec: QuickSpec {
    private let typicalJSONObject:  [String : Any] = ["sonectId": "c032faa283f43772bc089945ba",
                                                      "category": "GENERAL",
                                                      "tagline": "Good thai food",
                                                      "longitude": "8.5496211",
                                                      "latitude": "47.3630063",
                                                      "imagePath": "",
                                                      "categoryText": "General"]
    
    override func spec() {
        super.spec()
        
        beforeSuite {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        }
        
        beforeEach {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }
        
        context("initialize with typical JSON Object") {
            it("initializes and assign properties correctly") {
                
                let atm = Atm(JSON: self.typicalJSONObject)
                
                expect(atm?.sonectId) == "c032faa283f43772bc089945ba"
                expect(atm?.category) == "GENERAL"
                expect(atm?.tagline) == "Good thai food"
                expect(atm?.latitude) == "47.3630063"
                expect(atm?.longitude) == "8.5496211"
                expect(atm?.imagePath) == ""
                expect(atm?.categoryText) == "General"
            }
        }
        
        context("initialize with typical JSON + save") {
            it("init & save") {
                let atm = Atm(JSON: self.typicalJSONObject)
                let realm = try? Realm()
                if let atm = atm {
                    try? realm?.write {
                        realm?.add(atm)
                    }
                }
                expect(realm?.objects(Atm.self).count).to(equal(1))
            }
        }
        
        context("init, add and remove") {
            it("init, add and remove") {
                let atm = Atm(JSON: self.typicalJSONObject)
                let realm = try? Realm()
                if let atm = atm {
                    try? realm?.write {
                        realm?.add(atm)
                    }
                }
                expect(realm?.objects(Atm.self).count).to(equal(1))
                
                if let atm = atm {
                    try? realm?.write {
                        realm?.delete(atm)
                    }
                }
                expect(realm?.objects(Atm.self).count).to(equal(0))
            }
        }
    }
}

//
//  SonectWSClientTests.swift
//  atmatmTests
//
//  Created by azerty on 14/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import XCTest
import RxTest
import RxBlocking
@testable import atmatm

class SonectWSClientTests: XCTestCase {
    private let sonectWSClient = SonectWSClient()

    func testGetATM() {
        let result = try? sonectWSClient.getAtm().materialize().toBlocking().first()
        switch result {
        case .next(let element)??: XCTAssert(element != nil)
        case .error(let error)??: XCTFail(error.localizedDescription)
        default: break
        }
    }
}

//
//  SonectWSClient.swift
//  atmatm
//
//  Created by azerty on 13/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import RxSwift
import Alamofire
import NetworkStack
import ObjectMapper
import RealmSwift

/** The webservice client implementation for SonectWS */
final class SonectWSClient {
    /// MARK:- Properties
    private let realm = Realm.safeInstance()
    fileprivate static let keychainService = KeychainService(serviceType: Environment.Sonect.appName)
    fileprivate static let networkStack = NetworkStack(baseURL: Environment.Sonect.baseURL,
                                                       keychainService: keychainService)
    
    /// MARK:- GET
    func getAtm() -> Observable<[Atm]?> {
        let requestParameters = RequestParameters(method: .get,
                                                  route: SonectRoutes.getATM)
        
        return SonectWSClient.networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters)
            .map({ (_, json) in
                return Mapper<Atm>().mapArray(JSONObject: json)
            })
    }
}

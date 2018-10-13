//
//  SonectRoutes.swift
//  atmatm
//
//  Created by azerty on 13/10/2018.
//  Copyright © 2018 azerty. All rights reserved.
//

import NetworkStack

public enum SonectRoutes: Routable {
    case getATM
    
    public var path: String {
        switch self {
        case .getATM: return "/data/ATM_20181005_DEV.json"
        }
    }
}

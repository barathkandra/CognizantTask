//
//  Utility.swift
//  CognizantTask
//
//  Created by Barath on 20/06/20.
//  Copyright © 2020 Barath. All rights reserved.
//

import Foundation
import Reachability

class Utility: NSObject
{
    class func isConnectedtoNetwork() -> Bool{
        let reachability = try! Reachability()
        return reachability.connection != .unavailable
    }
}

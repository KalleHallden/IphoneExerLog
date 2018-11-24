//
//  PersonalStats.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-22.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation
import UIKit

class PersonalStats: NSObject, Codable {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(bodyWeight, forKey: "bodyweight")
        aCoder.encode(bicepSize, forKey: "bicepsize")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let bodyweight = aDecoder.decodeObject(forKey: "bodyweight") as? [Double],
        let bicepsize = aDecoder.decodeObject(forKey: "bicepsize") as? [Double] else {
            print("didn't work")
            return nil
        }
        self.init(bodyweight: bodyweight, bicepSize: bicepsize)
    }

    
    private var bodyWeight = [Double]()
    private var bicepSize = [Double]()
    
    init(bodyweight: [Double], bicepSize: [Double]) {
        self.bodyWeight = bodyweight
        self.bicepSize = bicepSize
    }
    
    override init() {
    }
}

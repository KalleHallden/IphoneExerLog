//
//  Theme.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-22.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Theme: NSObject, Codable {
   
        func encode(with aCoder: NSCoder) {
            aCoder.encode(theme, forKey: "thme")
            aCoder.encode(superDark, forKey: "superdark")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let thme = aDecoder.decodeObject(forKey: "thme") as? Bool,
            let suprdark = aDecoder.decodeObject(forKey: "superdark") as? Bool else {
                print("didn't work")
                return nil
        }
        self.init(theme: thme, superDark: suprdark)
    }
    private var theme = false
    private var superDark = false
    
    init(theme: Bool, superDark: Bool) {
        self.theme = theme
        self.superDark = superDark
    }
    override init() {}
    
    
    func getTheme() -> Bool {
        return self.theme
    }
    
    func getSuperDark() -> Bool {
        return self.superDark
    }
    
    func setTheme(themeHasBeenSet: Bool) {
        self.theme = themeHasBeenSet
    }
    
    func setSuperDark(themeHasBeenSet: Bool) {
        self.superDark = themeHasBeenSet
    }
    
}

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
            aCoder.encode(Theme.theme, forKey: "thme")
            aCoder.encode(Theme.superDark, forKey: "superdark")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let thme = aDecoder.decodeObject(forKey: "thme") as? Bool,
            let suprdark = aDecoder.decodeObject(forKey: "superdark") as? Bool else {
                print("didn't work")
                return nil
        }
        self.init(theme: thme, superDark: suprdark)
    }
    private static var theme = false
    private static var superDark = false
    
    init(theme: Bool, superDark: Bool) {
        Theme.theme = theme
        Theme.superDark = superDark
    }
    override init() {}
    
    
    func getTheme() -> Bool {
        return Theme.theme
    }
    
    func getSuperDark() -> Bool {
        return Theme.superDark
    }
    
    func setTheme(themeHasBeenSet: Bool) {
        Theme.theme = themeHasBeenSet
    }
    
    func setSuperDark(themeHasBeenSet: Bool) {
        Theme.superDark = themeHasBeenSet
    }
    
}

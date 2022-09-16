//
//  CacheLogics.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 09.09.2022.
//

import UIKit

final class CacheLogics {

    func addElement(key: URL, image: Data) {
        Cache.cache.setObject(image as NSData, forKey: key as NSURL)
    }

    func takeElement(key: URL) -> Data {
        if checkAvailability(key: key) {
            return Cache.cache.object(forKey: key as NSURL)! as Data
        }
        return Data()
    }

    func checkAvailability(key: URL) -> Bool {
        if Cache.cache.object(forKey: key as NSURL) != nil {
            return true
        } else {
            return false
        }
    }
}

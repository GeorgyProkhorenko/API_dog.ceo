//
//  Cache.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 09.09.2022.
//

import UIKit

final class Cache: NSCache<AnyObject, AnyObject> {

    static var cache = NSCache<NSURL, NSData>()
}

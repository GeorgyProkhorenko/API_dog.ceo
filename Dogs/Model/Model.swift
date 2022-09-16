//
//  Model.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 25.07.2022.
//

import Foundation
import UIKit

struct Welcome: Decodable {
    var message: [String: [String]]
    let status: String
}

struct DogsImage: Decodable {
    let message: [String]
    let status: String
}

struct Dogs {
    let name: String
    let image: String
}

struct Constants {
    static let distanseToView: CGFloat = 10
    static let minimumLineSpace: CGFloat = 5
    static let contentWidth: CGFloat = (UIScreen.main.bounds.width - 2 * distanseToView - minimumLineSpace * 2) / 2
    static let widthIndicator = 40
    static let heightIndicator = 40
    static let xIndicator = 0
    static let yIndicator = 0
    static let headerSectionSpace = CGSize(width: UIScreen.main.bounds.width, height: 30)
}

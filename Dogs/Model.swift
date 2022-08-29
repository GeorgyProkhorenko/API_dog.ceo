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

extension Dogs {
    
    static func image(urlImage: String, list: @escaping([String]) -> ()) {
            
        let urlImage = URL(string: urlImage)

        URLSession.shared.dataTask(with: urlImage!,
                                   completionHandler: { data, response, error in
            if let error = error {
                print("ERROR:", error)
                return
            }
            guard let data = data else { return }

            do {
                let dogImage = try JSONDecoder().decode(DogsImage.self, from: data)
                list(dogImage.message)
            } catch {
                print("ERROR2:", error)
            }
        }).resume()

    }
    
    static func getDogsList(list: @escaping([String : [String]]) -> ()) {
        let url = URL(string: "https://dog.ceo/api/breeds/list/all")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                list(welcome.message)
            } catch {
                print(error)
            }
           
        }.resume()
    }
}



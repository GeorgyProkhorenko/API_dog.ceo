//
//  DogsAPIInput.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 05.09.2022.
//

import Foundation
import UIKit

final class DogsAPI {

    func image(urlImage: String, list: @escaping([String]) -> Void) {

        let urlImage = URL(string: urlImage)

        URLSession.shared.dataTask(with: urlImage!,
                                   completionHandler: { data, response, error in
            if let error = error {
                print("ERROR:", error)
                return
            }
            guard let data = data else { return }
            guard response != nil else { return }
            do {
                let dogImage = try JSONDecoder().decode(DogsImage.self, from: data)
                list(dogImage.message)
            } catch {
                print("ERROR2:", error)
            }
        }).resume()

    }

    func getDogsList(list: @escaping([String: [String]]) -> Void) {
        let url = URL(string: "https://dog.ceo/api/breeds/list/all")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard response != nil else { return }
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

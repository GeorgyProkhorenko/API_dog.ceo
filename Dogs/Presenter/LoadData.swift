//
//  loadImage.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 05.09.2022.
//

import Foundation

extension DogsAPI {
    func loadImageInImagesViewController(api: String) {
        let imagesViewController = ImagesViewController()
        print("api:", api)
        self.image(urlImage: api) { list in
            imagesViewController.imagesURLList = list
            DispatchQueue.main.async {
                imagesViewController.cview.reloadData()
                imagesViewController.indicator.stopAnimating()
                imagesViewController.indicator.isHidden = true
            }
        }
    }

    func loadListInViewController() {
        let viewController = ViewController()
        self.getDogsList { [weak viewController] list in
            var dog: [Dogs] = []
            for (name, subname) in list {
                if subname.isEmpty {
                    let urlImage = "https://dog.ceo/api/breed/\(name)/images"
                    dog.append(Dogs(name: name, image: urlImage))
                } else {
                    for sub in subname {
                        let urlImage = "https://dog.ceo/api/breed/\(name)/\(sub)/images"
                        dog.append(Dogs(name: "\(sub) \(name)", image: urlImage))
                    }
                }
            }
            viewController?.dogsList = dog
            DispatchQueue.main.async {
                viewController?.tableView.reloadData()
                viewController?.indicator.stopAnimating()
                viewController?.indicator.isHidden = true
            }
        }
    }

//    func loadListInViewController(list: [String: [String]]) -> [Dogs] {
//        var dog: [Dogs] = []
//        for (name, subname) in list {
//            if subname.isEmpty {
//                let urlImage = "https://dog.ceo/api/breed/\(name)/images"
//                dog.append(Dogs(name: name, image: urlImage))
//            } else {
//                for sub in subname {
//                    let urlImage = "https://dog.ceo/api/breed/\(name)/\(sub)/images"
//                    dog.append(Dogs(name: "\(sub) \(name)", image: urlImage))
//                }
//            }
//        }
//        return dog
//    }
}

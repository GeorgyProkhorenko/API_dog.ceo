//
//  AddFavoriteLogics.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 08.09.2022.
//

import UIKit

final class AddFavorit {

    func longPress(breed: String, image: URL) {
        if FavoritViewController.breedsAct.contains(breed) {
            var array = FavoritViewController.favoritePhotoAct[breed]
            array?.append(image)
            FavoritViewController.favoritePhotoAct[breed] = array
        } else {
            FavoritViewController.breedsAct.append(breed)
            FavoritViewController.favoritePhotoAct.updateValue([image], forKey: breed)
        }
    }

    func checkAvailability(breed: String, image: URL) -> Bool {
        if FavoritViewController.breedsAct.contains(breed) {
            if FavoritViewController.favoritePhotoAct[breed]!.contains(image) {
                return true
            }
        }
        return false
    }

    func deleteLongPress(breed: String, image: URL) {
        if checkAvailability(breed: breed, image: image) {
            var list: [URL] = FavoritViewController.favoritePhotoAct[breed]!
            list.remove(at: list.firstIndex(of: image)!)
            FavoritViewController.favoritePhotoAct[breed] = list
            if FavoritViewController.favoritePhotoAct[breed] == [] {
                FavoritViewController.breedsAct.remove(at: FavoritViewController.breedsAct.firstIndex(of: breed)!)
            }
        }
    }
}

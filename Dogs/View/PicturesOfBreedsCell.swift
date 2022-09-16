//
//  PicturesOfBreedsCell.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 24.08.2022.
//

import UIKit

final class ImageCell: UICollectionViewCell {

    var reusedId = "ImageCell"
    var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        image.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        image.contentMode = .scaleToFill
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {

    func load(url: URL) {
        let cache = CacheLogics()
        if cache.checkAvailability(key: url) {
            let data = cache.takeElement(key: url)
            self.image = UIImage(data: data)
        } else {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    cache.addElement(key: url, image: data)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }

    func add(data: Data) {
        self.image = UIImage(data: data)
    }
}

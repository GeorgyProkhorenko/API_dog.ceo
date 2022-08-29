//
//  CollectionViewCell.swift // название опять не говорит ничего
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 24.08.2022.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let reuseId = "ImageCell"

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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

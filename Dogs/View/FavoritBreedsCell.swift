//
//  FavoritBreedsCell.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 08.09.2022.
//

import UIKit

final class FavoritCell: UICollectionReusableView {

    static let reuseId = "SectionHeader"
    let title = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        customElement()
        setupConstrains()
    }

    private func customElement() {
        title.textColor = .black
        title.font = UIFont(name: "avenir", size: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstrains() {
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.rightAnchor.constraint(equalTo: rightAnchor),
            title.leftAnchor.constraint(equalTo: leftAnchor)])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

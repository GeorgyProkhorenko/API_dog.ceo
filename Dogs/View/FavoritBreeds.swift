//
//  FavoritBreeds.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 07.09.2022.
//

import UIKit

final class FavoritViewController: UIViewController {

    static var favoritePhotoAct: [String: [URL]] = [:]
    static var breedsAct: [String] = []
    private var favoritePhoto: [String: [URL]] = [:]
    private var breeds: [String] = []
    private var table = UITableView.init(frame: .zero, style: .grouped)
    private var cview = UICollectionView(frame: CGRect.zero,
                                         collectionViewLayout: UICollectionViewLayout.init())
    private let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    private var imageCell = ImageCell()
    private let info: UILabel = {
        let info = UILabel()
        info.text = "No photo yet"
        info.font = info.font.withSize(20)
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        setupInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        favoritePhoto = FavoritViewController.favoritePhotoAct
        breeds = FavoritViewController.breedsAct
        if breeds != [] { info.isHidden = true } else { info.isHidden = false }
        cview.reloadData()
    }

    private func setupInfo() {
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            info.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            info.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }

    private func setupCV() {
        cview.contentInset = UIEdgeInsets(top: Constants.distanseToView,
                                          left: Constants.distanseToView,
                                          bottom: Constants.distanseToView,
                                          right: Constants.distanseToView)
        cview.setCollectionViewLayout(layout, animated: true)
        cview.delegate = self
        cview.dataSource = self
        cview.backgroundColor = UIColor.white
        cview.frame = view.frame
        cview.register(ImageCell.self, forCellWithReuseIdentifier: imageCell.reusedId)
        cview.register(FavoritCell.self,
                       forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                       withReuseIdentifier: FavoritCell.reuseId)
        view.addSubview(cview)
        view.addSubview(info)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = Constants.minimumLineSpace
        title = "Favorit breed"
    }
}

extension FavoritViewController: UICollectionViewDelegate,
                                 UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("breeds count: ", breeds.count)
        return breeds.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return Constants.headerSectionSpace
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let rows = favoritePhoto[breeds[section]]?.count else { return 0 }
        return rows
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.contentWidth, height: Constants.contentWidth)
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cview.dequeueReusableCell(withReuseIdentifier: imageCell.reusedId,
                                                   for: indexPath) as? ImageCell else {
            let cell = cview.dequeueReusableCell(withReuseIdentifier: imageCell.reusedId,
                                                           for: indexPath)
            print("ERROR CELLFORITEMAT")
            return cell
        }
        let value = favoritePhoto[breeds[indexPath.section]]
        cell.image.load(url: value![indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = cview.dequeueReusableSupplementaryView(ofKind: kind,
                                                                  withReuseIdentifier: FavoritCell.reuseId,
                                                                  for: indexPath) as? FavoritCell else {
            let header = cview.dequeueReusableSupplementaryView(ofKind: kind,
                                                                withReuseIdentifier: FavoritCell.reuseId,
                                                                for: indexPath)
            print("ERROR ELEMENTOFKIND")
            return header
        }
        header.title.text = breeds[indexPath.section]
        print("title: ")
        return header
    }
}

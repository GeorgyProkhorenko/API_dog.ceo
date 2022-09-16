//
//  PicturesOfBreeds.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 18.08.2022.
//

import UIKit

final class ImagesViewController: UIViewController {

    var api: String = ""
    var breed: String = ""
    var imagesURLList: [String] = []
    private var indicator = UIActivityIndicatorView(frame:
                                                CGRect(x: Constants.xIndicator,
                                                       y: Constants.yIndicator,
                                                       width: Constants.widthIndicator,
                                                       height: Constants.heightIndicator))
    private let cview: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:
                                                    UICollectionViewFlowLayout.init())
    private let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    private var imagesList: [UIImageView] = []
    private var cache = CacheLogics()
    private let loadData = DogsAPI()
    private let imageCell = ImageCell()
    private let longPress = UILongPressGestureRecognizer()
    private let popVC = AddPopVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCview()
        setupActivityIndicator()
        indicator.startAnimating()
        loadImageInImagesViewController(api: api)
    }

    private func setupActivityIndicator() {
        print("Breed:", breed)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    private func loadImageInImagesViewController(api: String) {
        loadData.image(urlImage: api) { [weak self] list in
            self?.imagesURLList = list
            DispatchQueue.main.async {
                self?.cview.reloadData()
                self?.indicator.stopAnimating()
                self?.indicator.isHidden = true
            }
        }
    }

    private func setupCview() {
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
        view.addSubview(cview)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = Constants.minimumLineSpace
        longPress.addTarget(self, action: #selector(clickLongPress))
        cview.addGestureRecognizer(longPress)
        breed = breed.capitalized
        title = breed
    }

    @objc private func clickLongPress() {
        print("long press")
        if longPress.state == UIGestureRecognizer.State.began {
            let touchPoint = longPress.location(in: cview)
            if let indexPath = cview.indexPathForItem(at: touchPoint) {
                popVC.breed = self.breed
                popVC.image = URL(string: imagesURLList[indexPath.row])!
                setupPopVC(index: indexPath)
                present(popVC, animated: true)
            }
        }
    }

    private func setupPopVC(index: IndexPath) {
        popVC.modalPresentationStyle = .popover
        let popVCPopover = self.popVC.popoverPresentationController
        popVCPopover?.delegate = self
        popVCPopover?.sourceView = self.cview.cellForItem(at: index)
        popVCPopover?.sourceRect = CGRect(x: Constants.contentWidth / 2,
                                          y: Constants.contentWidth - 20,
                                          width: 0, height: 0)
    }
}

extension ImagesViewController: UICollectionViewDataSource,
                                UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                    UIPopoverPresentationControllerDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURLList.count
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
            return cell
        }
        let url = URL(string: imagesURLList[indexPath.row])!
        cell.image.load(url: url)
        return cell
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

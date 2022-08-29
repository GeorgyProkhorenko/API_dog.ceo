//
//  ImagesDog.swift // названия файлов должны соответсвовать объектам в них
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 18.08.2022.
//

import UIKit

// Использовать final class
// UICollectionViewDataSource UICollectionViewDelegate, UICollectionViewDelegateFlowLayout в отдельных extension должны быть
// Принты убрать по проекту 
class ImagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
	// если из внешних объектов эти свойства не нужны, то нужно их делать приватными
    var api: String!
    var indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)) // значения в константы
    let cv:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var imagesURLList: [String] = []
    var imagesList: [UIImageView] = []
    lazy var cache = NSCache<NSString, UIImageView>()
    
    override func viewDidLoad() {
        activityIndicator()
        super.viewDidLoad()
        cv.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
        view.addSubview(cv)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = Constants.minimumLineSpace
        cv.contentInset = UIEdgeInsets(top: Constants.distanseToView, left: Constants.distanseToView, bottom: Constants.distanseToView, right: Constants.distanseToView)
        cv.setCollectionViewLayout(layout, animated: true)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.white
        cv.frame = view.frame
        Dogs.image(urlImage: api) {
            list in
            self.imagesURLList = list
            DispatchQueue.main.async {
                self.cv.reloadData()
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("rows", imagesURLList.count)
        return imagesURLList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.contentWidth, height: Constants.contentWidth)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell")
        let cell = cv.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as! ImageCell
        let url = URL(string: imagesURLList[indexPath.row])!
        if let image = self.cache.object(forKey: imagesURLList[indexPath.row] as NSString) {
            cell.image = image
            print("using cache")
        } else {
            cell.image.load(url: url)
            self.cache.setObject(cell.image, forKey: imagesURLList[indexPath.row] as NSString)
        }
        return cell
    }

	// странный метод, если я его вызову дважды то он повторно настроится и разместится, если ты хочешь сделать метод в
	// котором настраиваешь индикатор, назови его  setupActivityIndicator и убери indicator.startAnimating()
    func activityIndicator() {
        print("act")
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
   
    struct Constants {
        static let distanseToView: CGFloat = 10
        static let minimumLineSpace:CGFloat = 5
        static let contentWidth: CGFloat = (UIScreen.main.bounds.width - 2 * distanseToView - minimumLineSpace * 2) / 2
    }
}


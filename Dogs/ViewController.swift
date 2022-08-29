//
//  ViewController.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 23.07.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var indicator = UIActivityIndicatorView()
    let tableView = UITableView()
    var dogsList: [Dogs] = []
    var api: String!


    override func viewDidLoad() {
        activityIndicator()
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 65
        Dogs.getDogsList {
            list in
            var dog: [Dogs] = []
            for (name, subname) in list{
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
            
            self.dogsList = dog
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            }
        }
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dog = dogsList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = dog.name
        
//        content.image = UIImage
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.api = dogsList[indexPath.row].image
        goToImageVC()
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.backgroundColor = .white
        indicator.startAnimating()
    }
    
    func goToImageVC() {
        let ivc = ImagesViewController()
        ivc.api = self.api
        present(ivc, animated: true)
    }

}

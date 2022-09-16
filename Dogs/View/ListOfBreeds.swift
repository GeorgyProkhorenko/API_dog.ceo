//
//  ViewController.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 23.07.2022.
//

import UIKit

final class ViewController: UIViewController {

    var indicator = UIActivityIndicatorView(style: .large)
    let tableView = UITableView()
    var dogsList: [Dogs] = []
    var api = ""
    private let loadData = DogsAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func setupViewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        setupActivityIndicator()
        indicator.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 65
        title = "All breed"
        loadListInViewController()
    }

    private func setupActivityIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    private func loadListInViewController() {
        loadData.getDogsList { [weak self] list in
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
            self?.dogsList = dog
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.indicator.stopAnimating()
                self?.indicator.isHidden = true
            }
        }
    }

    private func goToImageVC(indexPath: IndexPath) {
        let ivc = ImagesViewController()
        ivc.breed = self.dogsList[indexPath.row].name
        ivc.api = self.api
        navigationController?.pushViewController(ivc, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dog = dogsList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = dog.name
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.api = dogsList[indexPath.row].image
        goToImageVC(indexPath: indexPath)
        tableView.reloadData()
    }
}

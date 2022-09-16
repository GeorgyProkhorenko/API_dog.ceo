//
//  AddPopVC.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 09.09.2022.
//

import UIKit

final class AddPopVC: UITableViewController {

    var breed: String!
    var image: URL!
    private let add = "Add new photo"
    private let del = "Delete photo"
    private let addBreed = AddFavorit()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "add")
    }

    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 155, height: tableView.contentSize.height)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if addBreed.checkAvailability(breed: breed, image: image) {
            addBreed.deleteLongPress(breed: breed, image: image)
        } else {
            addBreed.longPress(breed: breed, image: image)
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "add", for: indexPath)
        if addBreed.checkAvailability(breed: breed, image: image) {
            cell.textLabel!.text = self.del
        } else {
            cell.textLabel!.text = self.add
        }
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

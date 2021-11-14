//
//  SharedHistoryViewController.swift
//  URLsharer
//
//  Created by 原直也 on 2021/06/16.
//

import UIKit

class SharedHistoryViewController: UIViewController {
    @IBOutlet var sharedHistoryTableView: UITableView!

    let todo = ["渋谷", "五反田", "新宿"]
    private var presenter: SharedHistoryPresenterInput!
    func inject(presenter: SharedHistoryPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sharedHistoryTableView.register(UINib(nibName: "URLHistoryTableVIewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }
}

extension SharedHistoryViewController: SharedHistoryPresenterOutput {}

extension SharedHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return todo.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sharedHistoryTableView.dequeueReusableCell(withIdentifier: "CustomCell") as! URLHistoryTableVIewCell
        cell.textLabel?.text = todo[indexPath.row]
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 100
    }
}

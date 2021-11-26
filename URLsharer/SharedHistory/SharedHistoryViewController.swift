//
//  SharedHistoryViewController.swift
//  URLsharer
//
//  Created by 原直也 on 2021/06/16.
//

import UIKit

class SharedHistoryViewController: UIViewController {
    @IBOutlet var sharedHistoryTableView: UITableView!

    private var presenter: SharedHistoryPresenterInput!
    func inject(presenter: SharedHistoryPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sharedHistoryTableView.register(UINib(nibName: "URLHistoryTableVIewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        inject(presenter: SharedHistoryPresenter(view: self))

        presenter.fetchURLMetadata()
    }
}

// MARK: - SharedHistoryTableView Extention

extension SharedHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return presenter.todo.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sharedHistoryTableView.dequeueReusableCell(withIdentifier: "CustomCell") as! URLHistoryTableVIewCell
        cell.textLabel?.text = presenter.todo[indexPath.row]
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - SharedHistoryPresenterOutput

extension SharedHistoryViewController: SharedHistoryPresenterOutput {
    func showURLMetadata() {
        sharedHistoryTableView.reloadData()
    }
}

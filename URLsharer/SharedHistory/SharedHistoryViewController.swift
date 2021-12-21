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
        sharedHistoryTableView.register(UINib(nibName: "URLHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        presenter.fetchURLMetadata()
    }
}

// MARK: - SharedHistoryTableView Extention

extension SharedHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return presenter.linkMetadata.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sharedHistoryTableView.dequeueReusableCell(withIdentifier: "CustomCell") as! URLHistoryTableViewCell
        cell.siteMetadataInfo = presenter.linkMetadata[indexPath.row]
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        sharedHistoryTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SharedHistoryPresenterOutput

extension SharedHistoryViewController: SharedHistoryPresenterOutput {
    func sharedHistoryTableViewReloadData() {
        DispatchQueue.main.async {
            self.sharedHistoryTableView.reloadData()
        }
    }
}

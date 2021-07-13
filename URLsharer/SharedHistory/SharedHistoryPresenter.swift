//
//  SharedHistoryPresenter.swift
//  URLsharer
//
//  Created by 原直也 on 2021/07/12.
//

import Foundation

protocol SharedHistoryPresenterInput {}

protocol SharedHistoryPresenterOutput: AnyObject {}

final class SharedHistoryPresenter: SharedHistoryPresenterInput {
    private weak var view: SharedHistoryPresenterOutput!

    init(view: SharedHistoryPresenterOutput) {
        self.view = view
    }
}

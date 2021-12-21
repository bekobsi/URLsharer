//
//  FetchLinkMetadata.swift
//  URLsharer
//
//  Created by 原直也 on 2021/11/28.
//

import Foundation
import LinkPresentation
import MobileCoreServices
import RxSwift

protocol LinkMetadataRepository {
    func get() -> Single<[LPLinkMetadata]>
}

final class FetchLinkMetadata: LinkMetadataRepository {
    func get() -> Single<[LPLinkMetadata]> {
        let groupName = "group.UrldataShareGroups"
        let userDefaults = UserDefaults(suiteName: groupName)
        let urlHistoryList = userDefaults?.stringArray(forKey: "urlHistoryList") ?? []
        let converedUrlHistoryList = urlHistoryList.map { self.convert(url: URL(string: $0)!) }

        return Observable.zip(converedUrlHistoryList).take(1).asSingle()
    }

   private func convert(url: URL) -> Observable<LPLinkMetadata> {
        return Observable.create { observer in
            let metadataProvider = LPMetadataProvider()
            metadataProvider.startFetchingMetadata(for: url) { metadata, error in
                if error != nil { return }
                guard let metadata = metadata else { return }
                observer.onNext(metadata)
            }
            return Disposables.create()
        }
    }
}

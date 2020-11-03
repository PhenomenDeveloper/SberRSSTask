//
//  FeedViewModel.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation

protocol MainVCViewModelType {
    var news: [Feed] { get set }
    var currentSource: Source { get set }
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath: IndexPath) -> NewsTableViewCellViewModelType?
}

class FeedViewModel: MainVCViewModelType {

    var news: [Feed] = []
    var currentSource: Source = Source(title: "Банки.РУ", url: "https://www.banki.ru/xml/news.rss")
    
    func numberOfRows() -> Int {
        return news.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsTableViewCellViewModelType? {
        let feed = news[indexPath.row]
        return NewsTableViewCellViewModel(feed: feed)
    }
    
}

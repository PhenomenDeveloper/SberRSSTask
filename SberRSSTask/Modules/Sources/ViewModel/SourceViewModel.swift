//
//  SourceViewModel.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation

protocol SourceViewModelType {
    var sources: [Source] { get set }
    var currentSource: Source? { get set }
    
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath: IndexPath) -> SourceTableViewCellViewModelType?
    func saveSourcesInUserDefaults()
    func loadSources()
    func refreshIsCurrent()
    func setIsCurrent()
}

class SourceViewModel: SourceViewModelType {
    var sources: [Source] = []
    
    var currentSource: Source?
    
    func numberOfRows() -> Int {
        return sources.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SourceTableViewCellViewModelType? {
        let source = sources[indexPath.row]
        
        return SourceTableViewCellViewModel(source: source)
    }
    
    func saveSourcesInUserDefaults() {
        var sourcesTitle: [String] = []
        var sourcesURL: [String] = []
        
        for i in 0..<sources.count {
            sourcesTitle.append(sources[i].title)
            sourcesURL.append(sources[i].url)
        }
        
        UserDataManager.saveSources(sourcesTitle: sourcesTitle, sourcesURL: sourcesURL)
    }
    
    func loadSources() {
        sources = []
        let title = UserDataManager.getSourcesTitle()
        let url = UserDataManager.getSourcesURL()
        
        if !title.isEmpty {
            for i in 0..<title.count {
                sources.append(Source(title: title[i], url: url[i], isCurrent: false))
            }
        }
    }
    
    func refreshIsCurrent() {
        if !sources.isEmpty {
            for i in 0..<sources.count {
                sources[i].isCurrent = false
            }
        }
    }
    
    func setIsCurrent() {
        if !sources.isEmpty {
            sources[0].isCurrent = true
        }
    }
}


//
//  NewsVC.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import UIKit
import CoreData

class NewsVC: UIViewController {
    
    // MARK: - Свойства
    private let rssParser: RSSParser = RSSParser()
    private var viewModel: MainVCViewModelType?
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var refreshControl = UIRefreshControl()
    
    private let emptyNewsLabel: UILabel = {
        let label = UILabel()
        label.text = "Не удалось загрузить новости\n по текущуему адресу"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptyNewsImage: UIImageView = {
        let image = #imageLiteral(resourceName: "not-found")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Функции
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9607843137, alpha: 1)
        
        viewModel = FeedViewModel()
        
        setupTableView()
        
        updateNews()
    }
    
    private func updateNews() {
        
        viewModel?.news = []
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            guard let url = viewModel?.currentSource.url else { return }
            refreshControl.beginRefreshing()
            rssParser.updateNews(currentSource: url) {[weak self] (objects) in
                self?.viewModel?.news = objects
                self?.tableView.reloadData()
            }
            refreshControl.endRefreshing()
        } else {
            print("Internet Connection not Available!")
            guard let news = CoreDataManager.shared.loadNews() else { return }
            viewModel?.news = news
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let news = viewModel?.news else { return }
        
        CoreDataManager.shared.saveNews(news: news)
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        updateNews()
    }

    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)

        tableView.addSubview(refreshControl)
        tableView.addSubview(emptyNewsLabel)
        tableView.addSubview(emptyNewsImage)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseId)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Потяните для обновления")
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        setupConstraints()
    }
    
    // Установка Constraint для UITableView
    private func setupConstraints() {
        tableView.fillToSuperView(view: view)
        
        emptyNewsLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        emptyNewsLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 50).isActive = true

        emptyNewsImage.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        emptyNewsImage.topAnchor.constraint(equalTo: emptyNewsLabel.bottomAnchor, constant: 25).isActive = true
    }
}
//MARK:- UITableViewDataSource
extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyNewsLabel.isHidden = viewModel?.numberOfRows() != 0
        emptyNewsImage.isHidden = viewModel?.numberOfRows() != 0
        
       return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseId, for: indexPath) as? NewsTableViewCell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
}

//MARK:- UITableViewDelegate
extension NewsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailNewsVC()
        viewModel?.news[indexPath.row].isReading = true
        tableView.reloadData()
        detailVC.rssItem = viewModel?.news[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK:- SourceListDataDelegate
extension NewsVC: SourceListDataDelegate {
    func updateSource(source: Source) {
        viewModel?.currentSource = source
        updateNews()
    }
}





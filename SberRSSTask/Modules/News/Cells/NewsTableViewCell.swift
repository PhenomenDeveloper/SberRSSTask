//
//  NewsTableViewCell.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    static let reuseId = "NewsTableViewCell"
    
    weak var viewModel: NewsTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            dateLabel.text = viewModel.date
            isSelectedView.isHidden = viewModel.isReading ? false : true
        }
    }
    
   // MARK: - Создание объектов кастомной ячейки

   private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let isSelectedView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeManager.Color.sberColor
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)

        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true

        overlayFirstLayer()
        overlaySecondLayer()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Наложение первого слоя UI
    func overlayFirstLayer() {
        addSubview(cardView)
        addSubview(isSelectedView)

        cardView.setPosition(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 12,
                             paddingLeft: 16,
                             paddingBottom: 12,
                             paddingRight: 12)
        
        isSelectedView.setPosition(top: cardView.topAnchor,
                                  left: cardView.leftAnchor,
                                  bottom: cardView.bottomAnchor,
                             right: nil,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 4,
                             height: 0)
    }
    
    ///Наложение второго слоя UI
    func overlaySecondLayer() {

        cardView.addSubview(titleLabel)
        cardView.addSubview(dateLabel)
        
        titleLabel.setPosition(top: cardView.topAnchor,
                                       left: cardView.leftAnchor,
                                       bottom: nil,
                                       right: cardView.rightAnchor,
                                       paddingTop: 16,
                                       paddingLeft: 12,
                                       paddingBottom: 0,
                                       paddingRight: 20)

        dateLabel.setPosition(top: titleLabel.bottomAnchor,
                              left: titleLabel.leftAnchor,
                              bottom: cardView.bottomAnchor,
                              right: nil,
                              paddingTop: 4,
                              paddingLeft: 0,
                              paddingBottom: 12,
                              paddingRight: 0)
    }
}

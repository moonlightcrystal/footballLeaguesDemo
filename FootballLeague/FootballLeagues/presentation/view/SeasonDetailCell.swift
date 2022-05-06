//
//  SeasonDetailCell.swift
//  FootballLeagues
//
//  Created by Kristina Rudakova on 06.05.2022.
//

import UIKit

protocol SeasonDetailCellProtocol {
    static var id: String { get }
}

class SeasonDetailCell: UITableViewCell {
    
    var model: Standing? {
        didSet {
            updateUI()
        }
    }
    
    private let scrollView = UIScrollView()
    private let scrollViewContentView = UIView()
    private let nameLabel = UILabel()
    private let statsTitlesStackView = UIStackView()
    private let statsValuesStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.addSubview(nameLabel)
        scrollViewContentView.addSubview(statsTitlesStackView)
        scrollViewContentView.addSubview(statsValuesStackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContentView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        statsTitlesStackView.axis = .horizontal
        statsTitlesStackView.distribution = .fillEqually
        statsTitlesStackView.spacing = 5
        statsTitlesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        statsValuesStackView.axis = .horizontal
        statsValuesStackView.distribution = .fillEqually
        statsValuesStackView.spacing = 5
        statsValuesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            scrollViewContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 5),
            nameLabel.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: 30),
            nameLabel.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor, constant: -30),
            nameLabel.widthAnchor.constraint(equalToConstant: 220),

            statsTitlesStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 15),
            statsTitlesStackView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor),
            statsTitlesStackView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -5),

            statsValuesStackView.leadingAnchor.constraint(equalTo: statsTitlesStackView.leadingAnchor),
            statsValuesStackView.topAnchor.constraint(equalTo: statsTitlesStackView.bottomAnchor),
            statsValuesStackView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -5),
            statsValuesStackView.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor, constant: -5)
        ])
    }
    
    private func updateUI() {
        guard let model = model else { return }
        
        nameLabel.text = model.team.displayName
        
        for stat in model.stats {
            let shortName = stat.shortDisplayName
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = shortName.rawValue
            statsTitlesStackView.addArrangedSubview(label)

            let value = stat.displayValue
            let _label = UILabel()
            _label.translatesAutoresizingMaskIntoConstraints = false
            _label.text = value
            statsValuesStackView.addArrangedSubview(_label)
        }
    }

}

extension SeasonDetailCell: SeasonDetailCellProtocol {
    static var id: String {
        return String(describing: self)
    }
}

//
//  SeasonLeagueCell.swift
//  FootballLeagues
//
//  Created by Kristina Rudakova on 06.05.22.
//

import Foundation
import UIKit

protocol SeasonLeagueCellProtocol {
    static var id: String { get }
}

class SeasonLeagueCell: UITableViewCell {
    var season: SeasonInfo? {
        didSet {
            updateUI()
        }
    }
    
    private let stackView = UIStackView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let hasStandingsLabel = UILabel()
    
    private let initialDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
        return df
    }()
    
    private let presentableDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        return df
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(stackView)
        [nameLabel, hasStandingsLabel, dateLabel].forEach { label in
            stackView.addArrangedSubview(label)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func configureUI() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textAlignment = .center
        
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        hasStandingsLabel.textAlignment = .center
    }
    
    private func formatDate(from date: String) -> String {
        if let date = initialDateFormatter.date(from: date) {
            return presentableDateFormatter.string(from: date)
        }
        return ""
    }
    
    private func updateUI() {
        guard let model = season else { return }
        nameLabel.text = model.name
        let date = formatDate(from: model.startDate) + " - " + formatDate(from: model.endDate)
        dateLabel.text = date
        hasStandingsLabel.text = "The season has \(model.hasStandings ? "" : "no ")standings"
    }
}

extension SeasonLeagueCell: SeasonLeagueCellProtocol {
    static var id: String {
        return String(describing: self)
    }
}

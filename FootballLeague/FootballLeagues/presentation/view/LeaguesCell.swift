//
//  LeaguesCell.swift
//  FootballLeagues
//
//  Created by Kristina Rudakova on 06.05.22.
//

import Foundation
import UIKit

protocol LeaguesCellProtocol {
    static var id: String { get }
}

class LeaguesCell: UITableViewCell {
    private let _imageView = UIImageView()
    private let title = UILabel()
    private let subtitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(_imageView)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            _imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            _imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            _imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            _imageView.widthAnchor.constraint(equalToConstant: 70.0),
            _imageView.heightAnchor.constraint(equalToConstant: 70.0),
            
            title.leadingAnchor.constraint(equalTo: _imageView.trailingAnchor, constant: 30),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            subtitle.trailingAnchor.constraint(equalTo: title.trailingAnchor)
        ])
    }
    
    private func configureUI() {
        _imageView.layer.cornerRadius = 5.0
        _imageView.contentMode = .scaleAspectFit
        
        title.numberOfLines = 2
        
        subtitle.font = .systemFont(ofSize: 12, weight: .light)
        subtitle.alpha = 0.8
    }
    
    func configureCell(league: League) {
        title.text = league.name
        subtitle.text = league.abbr
    }
    
    func configureIcon(image: UIImage) {
        _imageView.image = image
    }
}

extension LeaguesCell: LeaguesCellProtocol {
    static var id: String {
        return String(describing: self)
    }
}

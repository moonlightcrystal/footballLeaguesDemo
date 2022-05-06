//
//  SeasonDetailViewController.swift
//  FootballLeagues
//
//  Created by Kristina Rudakova on 06.05.22.
//

import Foundation
import UIKit

class SeasonDetailViewController: UIViewController {
    
    private let networkService = NetworkService.shared
    
    let tableView = UITableView()
    
    var standings: [Standing] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var year: String
    
    init(yearOfSeason: String) {
        self.year = yearOfSeason
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubviews()
        makeConstraints()
        
        networkService.tableOfLeague(year: year) { standings in
            self.standings = standings
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        title = "Season Detail"
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SeasonDetailCell.self, forCellReuseIdentifier: SeasonDetailCell.id)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SeasonDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeasonDetailCell.id, for: indexPath) as? SeasonDetailCell else { return UITableViewCell() }
        
        cell.model = standings[indexPath.row]
        
        return cell
    }
}

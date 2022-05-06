//
//  LeagueDetailViewController.swift
//  FootballLeagues
//
//  Created by Kristina Rudakova on 06.05.22.
//

import Foundation
import UIKit

class LeagueDetailViewController: UIViewController {
    
    var seasons: [Season] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let yearLeagueLabel = UILabel()
    private let tableView = UITableView()
    private var id: String?
    private let networkService = NetworkService.shared
    
    init(idLeague: String) {
        super.init(nibName: nil, bundle: nil)
        id = idLeague
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        if let leagueId = self.id {
            networkService.league(id: leagueId) { [weak self] seasons in
                self?.seasons = seasons
            }
        }
    }
    
    func setupUI() {
        view.addSubview(yearLeagueLabel)
        view.addSubview(tableView)
        
        yearLeagueLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yearLeagueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            yearLeagueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            yearLeagueLabel.topAnchor.constraint(equalTo: view.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: yearLeagueLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configureUI() {
        title = "Seasons"
        view.backgroundColor = .white
        tableView.register(SeasonLeagueCell.self, forCellReuseIdentifier: SeasonLeagueCell.id)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension LeagueDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print(indexPath)
        let year = seasons[indexPath.row].year
        let vc = SeasonDetailViewController(yearOfSeason: String(year))
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LeagueDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeasonLeagueCell.id, for: indexPath) as? SeasonLeagueCell else {
            return UITableViewCell(frame: .zero)
        }
        let infoSeason = seasons[indexPath.row].types.first
        cell.season = infoSeason
        return cell
    }
}

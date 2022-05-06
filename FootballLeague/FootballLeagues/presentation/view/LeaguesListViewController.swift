//
//  LeaguesListViewController.swift
//  FootballLeagues
//
//  Created by Kristina Rudakova on 06.05.22.
//

import Foundation
import UIKit

class LeaguesListViewController: UIViewController {
    
    var leagues: [League] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView = UITableView()
    private let networkService = NetworkService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        networkService.leagues { [weak self] leagues in
            self?.leagues = leagues
        }
    }

    private func setupUI() {
        title = "Leagues"
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureUI() {
        tableView.register(LeaguesCell.self, forCellReuseIdentifier: LeaguesCell.id)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension LeaguesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print(indexPath)
        let league = leagues[indexPath.row]
        print(league.id)
        let vc = LeagueDetailViewController(idLeague: league.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LeaguesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaguesCell.id, for: indexPath) as? LeaguesCell else {
            return UITableViewCell(frame: .zero)
        }
        let league = leagues[indexPath.row]
        networkService.getImage(string: league.logos.light) { image in
            cell.configureIcon(image: image)
        }
        cell.configureCell(league: league)
        return cell
    }
}

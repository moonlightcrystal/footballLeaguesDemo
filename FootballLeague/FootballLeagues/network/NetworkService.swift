//
//  NetworkService.swift
//  FootballLeagues
//
//  Created by Kristina Rudakova on 06.05.22.
//

import Foundation
import UIKit

public struct Endpoint: RawRepresentable, Equatable, Hashable {
    public let rawValue: URL
    
    public init(rawValue: URL) {
        self.rawValue = rawValue
    }

    public static let allLeaguesAvailable = Endpoint(rawValue: URL(string: "https://api-football-standings.azharimm.site/leagues")!)
}

protocol NetworkServiceProtocol {
    typealias LeaguesResultBlock = ([League]) -> Void
    typealias LeagueImageResultBlock = (UIImage) -> Void
    typealias LeagueDetailResultBlock = ([Season]) -> Void
    typealias TableOfLeagueResultBlock = ([Standing]) -> Void

    func leagues(with completion: @escaping LeaguesResultBlock)
    func league(id: String, completion: @escaping LeagueDetailResultBlock)
    func getImage(string: String, with completion: @escaping LeagueImageResultBlock)
    func tableOfLeague(year: String, completion: @escaping TableOfLeagueResultBlock)
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    func leagues(with completion: @escaping LeaguesResultBlock) {
        getData(url: Endpoint.allLeaguesAvailable.rawValue) { dataRes, response, Error in
            if let data = dataRes {
                do {
                    print(data)
                    let response = try JSONDecoder().decode(ResponseLeagues.self, from: data)
                    DispatchQueue.main.async {
                        completion(response.data)
                    }
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
    func league(id: String, completion: @escaping LeagueDetailResultBlock) {
        if let url = createURL(string: "https://api-football-standings.azharimm.site/leagues/\(id)/seasons") {
            getData(url: url) { data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(ResponseLeaguesSeason.self, from: data)
                        DispatchQueue.main.async {
                            completion(response.data.seasons)
                        }
                    } catch {
                        print("\(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func tableOfLeague(year: String, completion: @escaping TableOfLeagueResultBlock) {
        if let url = createURL(string: "https://api-football-standings.azharimm.site/leagues/eng.1/standings?season=\(year)&sort=asc") {
            getData(url: url) { data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(ResponseTableOfLeague.self, from: data)
                        let standings = response.data.standings
                        DispatchQueue.main.async {
                            completion(standings)
                        }
                    } catch {
                        print("\(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func getImage(string: String, with completion: @escaping LeagueImageResultBlock) {
        if let url = createURL(string: string) {
            getData(url: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        completion(image)
                    }
                }
            }
        }
    }
}

private extension NetworkService {
    func createURL(string: String) -> URL? {
        guard let url = URL(string: string) else {
            print("not valid url address is \(string)")
            return nil
        }
        return url
    }
    
    func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> () ) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

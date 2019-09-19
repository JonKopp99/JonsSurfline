//
//  SpitCastNetwork.swift
//  SurflineJonathanKopp
//
//  Created by Jonathan Kopp on 9/17/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
class SpitCastNetwork{
    
    //MARK: Fetch models
    func fetchSpots(countyName: String, completion: @escaping (Spots?) -> Void) {
        let url = self.urlBuilder(path:"/api/county/spots", county: self.formatCountyName(countyName: countyName))
        //print(url)
        if let url = url {
            createSpotModel(url: url) { (spots, _) in
                completion(spots)
            }
        }
    }
    
    func fetchSwells(spot: String, completion: @escaping (SwellElement?) -> Void) {
        let url = self.urlBuilder(path:"/api/spot/forecast", spot: spot)
        //print(url)
        if let url = url {
            createSwellModel(url: url) { (swell, _) in
                completion(swell)
            }
        }
    }
    
    //MARK: Create models
    private func createSwellModel(url: URL, completion: @escaping (_ response: SwellElement?, _ networkError: Error?) -> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil, err)
            }
            do {
                _ = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                //Updating UI keep on main thread!
                DispatchQueue.main.async {
                    let swells = try! JSONDecoder().decode(Swell.self, from: data!)
                    let swell = swells.first
                    completion(swell,nil)
                    
                }
            } catch {
                print("Error decoding swell model!")
                completion(nil,nil)
            }
        }.resume()
    }
    
    private func createSpotModel(url: URL, completion: @escaping (_ response: Spots?, _ networkError: Error?) -> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil, err)
            }
            do {
                _ = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                //Updating UI keep on main thread!
                DispatchQueue.main.async {
                    let spots = try! JSONDecoder().decode(Spots.self, from: data!)
                    completion(spots,nil)
                    
                }
            } catch {
                print("Error decoding spot model!")
                completion(nil,nil)
            }
        }.resume()
    }
    
}

// MARK: URL Building
extension SpitCastNetwork {
    func urlBuilder(path: String, spot: String? = nil, county: String? = nil)-> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.spitcast.com"
        components.path = path
        
        if let spot = spot
        {
            components.path = path + "/\(spot)"
        }
        if let county = county
        {
            components.path = path + "/\(county)"
        }
        
        return components.url
    }

    //API requires countys to be desplayes as xxx-xxx -> Lowercase && dashes ! spaces
    func formatCountyName(countyName: String)-> String {
        
        return countyName.replacingOccurrences(of: " ", with: "-").lowercased()
    }
}

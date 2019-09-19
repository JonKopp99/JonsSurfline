//
//  SpotsVC.swift
//  SurflineJonathanKopp
//
//  Created by Jonathan Kopp on 9/17/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class SpotsVC: UIViewController
{
    var countyName = String()
    var spots = Spots()
    var spitCastNetwork = SpitCastNetwork()
    var tableView = UITableView()
    var mapView = MapView()
    lazy var spotDetial = SpotDetialView()
    
    //MARK: ViewController Setup
    //Load all UI here so presentaiton animation from HomeVC() is clean
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = countyName
        navigationController?.view.backgroundColor = .white
        view.backgroundColor = .white
        
        tableLayout()
        spotsSetup()
    }
    
    //Pin mapView to bottom of safeArea top!
    override func viewSafeAreaInsetsDidChange() {
        //Sets up mapView to start at end of navController
        let safeYCoordinate = view.safeAreaInsets.top
        mapView.frame = CGRect(x: 0, y: safeYCoordinate, width: view.bounds.width, height: view.bounds.height * 0.4 - safeYCoordinate)
    }
    
    //MARK: Spots Network Setup
    func spotsSetup() {
        spitCastNetwork.fetchSpots(countyName: countyName) { (spots) in
            if let spots = spots {
                self.spotsFetched(spots: spots)
            }
            
        }
    }
    
    func spotsFetched(spots: Spots) {
        self.spots = spots
        mapView.spots = spots
        view.addSubview(mapView)
        
        mapView.setUp()
        view.addSubview(tableView)
        tableView.reloadData()
        
    }
    
    
    
}

extension SpotsVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: TableView Setup
    func tableLayout() {
        tableViewHeaderSetUp()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(SpotsCell.self, forCellReuseIdentifier: "spotsCell")
        //Pin underneath the mapView(0.4) and have a height(0.6) of 60% of the screen
        tableView.frame = CGRect(x: 0, y: view.bounds.height * 0.4, width: view.bounds.width, height: view.bounds.height * 0.6)
    }
    
    func tableViewHeaderSetUp() {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Surf spots in \(self.countyName)!"
        label.textAlignment = .center
        label.frame = CGRect(x: 5, y: 5, width: view.bounds.width - 20, height: 35)
        self.tableView.tableHeaderView = label
    }
    
    //MARK: TableView Rows/Sections
    //Spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //Use sections so we can use section headers as spacing between cells :)
    func numberOfSections(in tableView: UITableView) -> Int {
        return spots.count
    }
    //Return empty header so we have blank/clear spacing inbetween cells
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Cells are equal to 15% of the total views height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spotsCell", for: indexPath) as! SpotsCell
        cell.spot = spots[indexPath.section]
        
        return cell
    }
    
    //MARK: Select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let spot = spots[indexPath.section]
        let latitude = spot.latitude
        let longitude = spot.longitude
        mapView.centerMapOnLocation(latitude: latitude, longitude: longitude, distance: 1000)
        swellSetup(spot: spot)
    }
}

extension SpotsVC {
    //MARK: Swell network
    func swellSetup(spot: Spot) {
        spitCastNetwork.fetchSwells(spot: "\(spot.spotID)") { (swell) in
            if let swell = swell {
                //print(swell)
                self.showSpotDetialView(swell: swell)
            }
        }
    }
    
    //MARK: SpotDetialView
    //Animate spotDetailView over the top of the tableView
    func showSpotDetialView(swell: SwellElement) {
        //Set the views y coordinate to the views height so we can animate it!
        //SpotDetail takes up 60% of the view(same as tableView)
        spotDetial.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height * 0.6)
        spotDetial.swellData = swell
        spotDetial.layout()
        view.addSubview(spotDetial)
        
        //Animate subView to land directly underneath the mapView
        UIView.animate(withDuration: 0.35, animations: {
            self.spotDetial.frame = CGRect(x: 0, y: self.view.bounds.height * 0.4, width: self.view.bounds.width, height: self.view.bounds.height * 0.6)
        })
    }
}

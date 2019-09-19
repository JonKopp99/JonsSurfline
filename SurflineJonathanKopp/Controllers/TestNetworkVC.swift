////
////  ViewController.swift
////  SurflineJonathanKopp
////
////  Created by Jonathan Kopp on 9/17/19.
////  Copyright © 2019 Jonathan Kopp. All rights reserved.
////
//
//import UIKit
//
//class TestNetworkVC: UIViewController {
//
//    var spitCastNetwork = SpitCastNetwork()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        swellSetup2()
//        spotSetup()
//    }
//    func swellSetup2()
//    {
//        let url = spitCastNetwork.urlBuilder(path:"/api/spot/forecast",spot: "602")
//        spitCastNetwork.createSwellModel2(url: url, completion: { swell, err in
//            guard err == nil else { fatalError() }
//            guard let swell = swell else { fatalError() }
//            print(swell)
//
//
//        })
//    }
//
//
//    func spotSetup()
//    {
//        let url = spitCastNetwork.urlBuilder(path:"/api/county/spots", county: "orange-county")
//
//        spitCastNetwork.createSpotModel(url: url)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(spotFetched), name: NSNotification.Name(rawValue: "fetchedSpots"), object: nil)
//    }
//    @objc func spotFetched()
//    {
//        if let spots = spitCastNetwork.spots
//        {
//            print("The spot model: ",spots)
//        }
//
//    }
//    @objc func swellFetched()
//    {
//        if let swell = spitCastNetwork.swell
//        {
//            print("The swell model: ", swell)
//        }
//    }
//
//}
//

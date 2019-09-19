//
//  MapView.swift
//  SurflineJonathanKopp
//
//  Created by Jonathan Kopp on 9/18/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapView: UIView, MKMapViewDelegate {
    lazy var mapView = MKMapView()
    lazy var spots = Spots()
    
    func setUp() {
        mapView.frame = CGRect(x: 2.5, y: 2.5, width: frame.width - 5, height: frame.height - 5)
        mapView.layer.cornerRadius = 10
        mapView.delegate = self
        
        let latitude = spots[0].latitude
        let longitude = spots[0].longitude
        
        centerMapOnLocation(latitude: latitude, longitude: longitude, distance: 10000)
        addAnotations()
        addSubview(mapView)
    }
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        //print("Mapview loaded")
        
    }
    func addAnotations() {
        var annotations = [MKPointAnnotation]()
    
        spots.forEach { spot in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude)
            annotation.title = spot.spotName
            mapView.addAnnotation(annotation)
            annotations.append(annotation)
        }

        self.mapView.showAnnotations(annotations, animated: false)
    }
    
    func centerMapOnLocation(latitude: Double, longitude: Double, distance: Double) {
        let coordinate = CLLocation(latitude: latitude, longitude: longitude)
        if(spots.count > 0)
        {
            let regionRadius: CLLocationDistance = distance
            let coordinateRegion = MKCoordinateRegion(center: coordinate.coordinate,latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    //Remove all waypoints or else memory issues occur :(
    deinit {
        mapView.removeAnnotations(mapView.annotations)
    }
}


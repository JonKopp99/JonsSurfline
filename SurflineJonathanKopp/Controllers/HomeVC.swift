//
//  HomeVC.swift
//  SurflineJonathanKopp
//
//  Created by Jonathan Kopp on 9/17/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    //MARK: HomeVC
    var collectionView: UICollectionView!
    
    let counties = CountyConstants.counties
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    view.backgroundColor = .white
    navigationController?.navigationBar.topItem?.title = "Choose County"
    }
    
    //Overriding to allow collectionView to pin to NavController
    override func viewSafeAreaInsetsDidChange() {
        
        setUpCollectionview()
    }
}


extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //MARK: CollectionView setup
    func setUpCollectionview() {
        //Layout setup 5 pixel spacing width & height
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2.5, bottom: 5, right: 2.5)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        
        //CollectionView setup
        //Start cV at bottom of view so we can animate it!
        let collectionFrame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height)
        collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "homeCell")
        collectionView.alpha = 0.0
        view.addSubview(collectionView)
        
        //Animate view to top while increasing transparency.
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionView.alpha = 1.0
            self.collectionView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return counties.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Nice even squares that are as wide and tall as width / 2!
        //Subtract 5 because we have a spacing of 5 pixels in each section
        return CGSize(width: self.view.bounds.width / 2 - 5,height: self.view.bounds.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let vc = SpotsVC()
        vc.countyName = counties[index]
        //Change the < button on navController to white == style: .plain
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Animate with a nice push from the right!
        let animation = CATransition()
        animation.type = .push
        animation.subtype = .fromRight
        animation.duration = 0.35
        self.view.window!.layer.add(animation, forKey: nil)
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCell
        cell.nameLabel.text = counties[index]
        return cell
    }
    
}

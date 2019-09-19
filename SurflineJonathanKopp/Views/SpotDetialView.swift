//
//  SpotDetialView.swift
//  SurflineJonathanKopp
//
//  Created by Jonathan Kopp on 9/18/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class SpotDetialView: UIView
{
    var swellData: SwellElement?
    //MARK: Subviews
    lazy var spotLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        label.shadowOffset = CGSize(width: 0, height: 3.5)
        
        return label
    }()
    
    lazy var spotDescription: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 50, weight: .light)
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        label.shadowOffset = CGSize(width: 0, height: 1.5)
        
        return label
    }()
    
    lazy var backImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "beautiful-color-gradients-backgrounds-047-fly-high")
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()
    
    lazy var closeButton: UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "icons8-close-window-50"), for: .normal)
        b.imageView?.contentMode = .scaleAspectFit
        b.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return b
    }()
    
    //MARK: Layout
    func layout()
    {
        backgroundColor = .white
        backImage.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        addSubview(backImage)
        
        closeButton.frame = CGRect(x: 2.5, y: 5, width: 35, height: 35)
        addSubview(closeButton)
        
        //Start label at 35 so no overlaping with closeButton
        spotLabel.frame = CGRect(x: 35, y: 5, width: bounds.width - 70, height: 35)
        spotLabel.text = swellData?.spotName
        addSubview(spotLabel)
        
        spotDescription.frame = CGRect(x: 5, y: spotLabel.frame.maxY + 5, width: bounds.width - 10, height: bounds.height - (spotLabel.frame.maxY + 10))
        
        if let swell = swellData
        {
        spotDescription.text = "Condition: \(swell.shapeFull)\nSurf Height: \(swell.size)\nWind: \(swell.shapeDetail.wind)\nTide: \(swell.shapeDetail.tide)"
        }
        addSubview(spotDescription)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.closeButtonPressed))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.addGestureRecognizer(swipeDown)
    }
    
    @objc func closeButtonPressed()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect(x: 0, y: 1000, width: self.bounds.width, height: self.bounds.height)
        }, completion: { (finished: Bool) in
            self.removeFromSuperview()
        })
    }
}

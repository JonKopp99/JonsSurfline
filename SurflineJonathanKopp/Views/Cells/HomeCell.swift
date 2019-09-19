//
//  HomeCell.swift
//  SurflineJonathanKopp
//
//  Created by Jonathan Kopp on 9/17/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit
class HomeCell: UICollectionViewCell{
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        label.shadowOffset = CGSize(width: 0, height: 3.5)
        
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        backImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(backImage)
        //5 pixel spacing from sides & height!
        nameLabel.frame = CGRect(x: 5, y: 5, width: frame.width - 10, height: frame.height - 10)
        addSubview(nameLabel)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



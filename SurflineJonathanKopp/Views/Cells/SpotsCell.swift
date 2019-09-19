//
//  SpotsCell.swift
//  SurflineJonathanKopp
//
//  Created by Jonathan Kopp on 9/18/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class SpotsCell: UITableViewCell
{
    var spot: Spot?
    
    lazy var spotLabel: UILabel = {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        //5 pixel spacing from sides!
        backImage.frame = CGRect(x: 5, y: 0, width: frame.width - 10, height: frame.height)
        addSubview(backImage)
        spotLabel.frame = CGRect(x: 5, y: 5, width: frame.width - 10, height: frame.height - 10)
        if let name = spot?.spotName
        {
            spotLabel.text = name
        }
        addSubview(spotLabel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        
    }
}


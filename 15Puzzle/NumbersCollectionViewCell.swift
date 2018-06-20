//
//  NumbersCollectionViewCell.swift
//  15Puzzle
//
//  Created by Kangping Huang on 17/6/18.
//  Copyright © 2018 Kangping Huang. All rights reserved.
//

import UIKit

class NumbersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }

}

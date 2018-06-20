//
//  NumbersCollectionViewFlowLayout.swift
//  15Puzzle
//
//  Created by Kangping Huang on 17/6/18.
//  Copyright © 2018 Kangping Huang. All rights reserved.
//

import UIKit

class NumbersCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Update item size according to current screen size.
    ///
    /// - Parameter collectionViewFrame: The frame of the CollectionView
    func updateItemSize(accordingTo collectionViewFrame: CGRect) {
        let width = collectionViewFrame.width
        // calculate the width of cell by removing margins and divide to 4
        let cellWidth = floor(Double(width - self.sectionInset.left - self.sectionInset.right - 3 * self.minimumInteritemSpacing) / 4)
        let cellHeight = cellWidth
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.invalidateLayout()
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("laying out attributes")
        let attributes = layoutAttributesForItem(at: indexPath)
        return attributes
    }
    
}

//
//  IndexPathExtensions.swift
//  15Puzzle
//
//  Created by Kangping Huang on 17/6/18.
//  Copyright © 2018 Kangping Huang. All rights reserved.
//

import Foundation

extension IndexPath {
    // get horizontal and vertical neigbours' IndexPath
    func getNeighbourIndexPaths(columns: Int) -> [IndexPath] {
        var neighbourIndexes = [IndexPath]()
        let emptyCellIndex = self.item
        switch emptyCellIndex%columns{
        case 0:
            neighbourIndexes = [IndexPath(item: emptyCellIndex-columns, section: section), IndexPath(item: emptyCellIndex+columns, section:section ), IndexPath(item: emptyCellIndex+1, section: section)]
        case columns-1:
            neighbourIndexes = [IndexPath(item: emptyCellIndex-columns, section: section), IndexPath(item: emptyCellIndex+columns, section:section ), IndexPath(item: emptyCellIndex-1, section: section)]
        default:
            neighbourIndexes = [IndexPath(item: emptyCellIndex-columns, section: section), IndexPath(item: emptyCellIndex+columns, section:section ), IndexPath(item: emptyCellIndex-1, section: section), IndexPath(item: emptyCellIndex+1, section: section)]
        }
        return neighbourIndexes
    }
}

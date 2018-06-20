//
//  _5PuzzleTests.swift
//  15PuzzleTests
//
//  Created by Kangping Huang on 17/6/18.
//  Copyright © 2018 Kangping Huang. All rights reserved.
//

import XCTest
@testable import _5Puzzle

class _5PuzzleTests: XCTestCase {
    
    let gameViewController = GameViewController()
    let layout = NumbersCollectionViewFlowLayout()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // test hasWin() method
    func testHasWin() {
        // expect win results
        gameViewController.numbersArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
        XCTAssertTrue(gameViewController.hasWin())
        
        // expect not win when sequences are different
        gameViewController.numbersArray = [2,1,3,4,5,6,7,9,8,10,11,12,0,14,15,13]
        XCTAssertFalse(gameViewController.hasWin())
    }
    
    // test IndexPath Extension method
    func testNeighbourCells() {
        let indexPath = IndexPath.init(item: 3, section: 1)
        let neighbourIndexes = indexPath.getNeighbourIndexPaths(columns: 4)
        XCTAssertTrue(neighbourIndexes.contains(IndexPath.init(item: indexPath.item-1, section: 1)))
        XCTAssertTrue(neighbourIndexes.contains(IndexPath.init(item: indexPath.item+4, section: 1)))
        XCTAssertFalse(neighbourIndexes.contains(IndexPath.init(item: indexPath.item+1, section: 1)))
    }
    
}

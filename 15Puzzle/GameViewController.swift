//
//  GameView.swift
//  15Puzzle
//
//  Created by Kangping Huang on 17/6/18.
//  Copyright © 2018 Kangping Huang. All rights reserved.
//

import UIKit
import GameplayKit

class GameViewController: UIViewController, UICollectionViewDataSource,
    UICollectionViewDelegate {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var numbersCollectionView: UICollectionView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var movesRecord: UILabel!
    
    let reuserIdentifier = "cell"
    
    // the FlowLayout that can render 4 cells in a row and manage spaces
    let layout = NumbersCollectionViewFlowLayout()
    // the array whose element will be displayed in each cell
    
    /**
     For testing purpose: var numbersArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,0,15] (easy to win)
     And then comment out Line 63
    **/
    var numbersArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    var emptyCellIndexPath: IndexPath?
    var neighbourIndexes: [IndexPath]?
    var moves = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerView()
        setupCollectionView()
        setupRefreshButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout.updateItemSize(accordingTo: numbersCollectionView.frame)
    }
    
    fileprivate func setupContainerView() {
        // set the background image
        let backgroundImage = UIImage(named: "wood-background")
        containerView.backgroundColor = UIColor(patternImage: backgroundImage!)
    }
    
    func setupCollectionView() {
        // shuffle the initial array
        numbersArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbersArray) as! [Int]
        
        numbersCollectionView.register(UINib.init(nibName: "NumbersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuserIdentifier)
        
        numbersCollectionView.dataSource = self
        numbersCollectionView.delegate = self
        
        numbersCollectionView.collectionViewLayout = layout
        updateNeighbourCells()
    }
    
    fileprivate func setupRefreshButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(reloadCollectionView))
        refreshButton.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func reloadCollectionView() {
        // shuffle the initial array again
        numbersArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbersArray) as! [Int]
        updateNeighbourCells()
        // set moves to default
        movesRecord.isHidden = true
        moves = 0
    }
    
    // update only those cells around the empty cell
    fileprivate func updateNeighbourCells() {
        // if hasn't won, update neighbour cells, otherwise popup win message to refresh
        if !hasWin() {
            numbersCollectionView.reloadData()
            // to make sure we get the result after all the cells in the collection view loaded
            numbersCollectionView.performBatchUpdates(nil, completion: {
                (result) in
                // get neighbour cells' IndexPath and store to the preset array
                // there are 3 different relative situations of all the neighbours, check IndexPathExtensions
                self.neighbourIndexes = self.emptyCellIndexPath?.getNeighbourIndexPaths(columns: 4)
            })
        } else {
            let winAlert = UIAlertController.init(title: "Win", message: "Congratulations genius!", preferredStyle: .alert)
            winAlert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
               self.reloadCollectionView()
            }))
            self.present(winAlert, animated: true, completion: nil)
        }
    }
    
    // check if win, simply compare the current array(dataSource) and winning array
    func hasWin() -> Bool {
        let winArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
        if numbersArray == winArray {
            return true
        } else {
            return false
        }
    }
    
    // CollectionView delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuserIdentifier, for: indexPath) as! NumbersCollectionViewCell
        cell.numberLabel.text = String(numbersArray[indexPath.item])
        
        // record the empty cell's IndexPath
        if numbersArray[indexPath.item] == 0 {
            emptyCellIndexPath = indexPath
            cell.isHidden = true
        } else {
            cell.isHidden = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (neighbourIndexes?.contains(indexPath))! {
            moves += 1
            movesRecord.text = "\(moves) moves"
            movesRecord.isHidden = false
            // if two cells are next to each other horizontally, use the default move behaviour
            if abs(indexPath.item - (emptyCellIndexPath?.item)!) == 1 {
                collectionView.moveItem(at: indexPath, to: emptyCellIndexPath!)
                numbersArray.swapAt(indexPath.item, self.emptyCellIndexPath!.item)
                // once the item is moved, the neighboured cells need to be re-cacultated
                emptyCellIndexPath = indexPath
                updateNeighbourCells()
            } else {
                // otherwise vertically, customize the move animation
                collectionView.performBatchUpdates({
                    collectionView.moveItem(at: indexPath, to: emptyCellIndexPath!)
                    collectionView.moveItem(at: emptyCellIndexPath!, to: indexPath)
                }) { (finished) in
                    self.numbersArray.swapAt(indexPath.item, self.emptyCellIndexPath!.item)
                    // once the item is moved, the neighboured cells need to be re-cacultated
                    self.emptyCellIndexPath = indexPath
                    self.updateNeighbourCells()
                }
            }
        }
    }
    
}

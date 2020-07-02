//
//  ListTableViewCell.swift
//  BiteThyme
//
//  Created by Maddie Drake on 4/30/20.
//  Copyright © 2020 Maddie Drake. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var ListCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ListCollectionView.delegate = self
        ListCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ListCollectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCellID", for: indexPath) as! ListCollectionViewCell
        cell.storeName.text = "HELLO"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    
}

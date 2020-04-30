//
//  IngredientDetail.swift
//  
//
//  Created by Maddie Drake on 4/28/20.
//

import UIKit

class IngredientDetail: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var storeCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        storeCollectionView.delegate = self
        storeCollectionView.dataSource = self
        //storeCollectionView.register(UINib(nibName: "storeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "storeCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = storeCollectionView.dequeueReusableCell(withReuseIdentifier: "storeCollectionViewCell", for: indexPath) as! storeCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 145, height: 156)
    }
    
}

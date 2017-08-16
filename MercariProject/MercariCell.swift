//
//  MercariCell.swift
//  MercariProject
//
//  Created by Ashok on 8/16/17.
//  Copyright © 2017 Ashok. All rights reserved.
//

import UIKit

class MercariCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var soldImageView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func updateUI(modelMercari: ModelMercari) {
        
        mainImageView.image = modelMercari.mainImage
        if modelMercari.soldState{
            soldImageView.image = #imageLiteral(resourceName: "sold")
        }
        else{
            soldImageView.image = nil
        }
        title.text = modelMercari.title
        
        var x = "$"
        x.append(modelMercari.price)
        price.text = x
    }
}


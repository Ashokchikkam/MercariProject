//
//  ModelMercari.swift
//  MercariProject
//
//  Created by Ashok on 8/16/17.
//  Copyright © 2017 Ashok. All rights reserved.
//

import Foundation
import UIKit

class ModelMercari{
    private var _mainImage: UIImage
    private var _soldState: Bool
    private var _title: String
    private var _price: String
    
    var mainImage: UIImage{
        return _mainImage
    }
    var soldState: Bool{
        return _soldState
    }
    var price: String{
        return _price
    }
    var title: String{
        return _title
    }
    
    init(mainImage: UIImage, soldState: Bool, price: String, title: String) {
        _mainImage = mainImage
        _soldState = soldState
        _price = price
        _title = title
    }
    
}

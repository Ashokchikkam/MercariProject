//
//  RoundedImageView.swift
//  MercariProject
//
//  Created by Ashok on 8/16/17.
//  Copyright © 2017 Ashok. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }

}

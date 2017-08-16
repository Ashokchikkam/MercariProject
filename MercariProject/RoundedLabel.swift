//
//  RoundedLabel.swift
//  MercariProject
//
//  Created by Ashok on 8/16/17.
//  Copyright © 2017 Ashok. All rights reserved.
//

import UIKit

class RoundedLabel: UILabel {

    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }

}

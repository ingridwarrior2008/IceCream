//
//  IceCreamCollectionViewCell.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class IceCreamCollectionViewCell: UICollectionViewCell {
    static let identifier = "IceCreamCollectionViewCell"
    
    @IBOutlet weak var iceCreamView: IceCreamView!
    
    func configure(model: IceCreamModel) {
        iceCreamView.configure(model: model)
    }
}

//
//  IceCreamCollectionViewCell.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class IceCreamCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: IceCreamCollectionViewCell.self)
    
    @IBOutlet weak var iceCreamView: IceCreamView!
    
    func configure(model: IceCreamModel, selected: Bool = false) {
        iceCreamView.configure(model: model, selected: selected)
    }
}

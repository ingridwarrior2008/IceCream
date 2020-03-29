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
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    
    func configure(model: IceCreamModel, selected: Bool, numberOfSelectedTimes: Int) {
        iceCreamView.configure(model: model, selected: selected)
        if numberOfSelectedTimes > 0 {
            countView.layer.cornerRadius = countView.frame.size.width / 2
            countLabel.text = "\(numberOfSelectedTimes)"
        }
        countView.isHidden = !selected
        countLabel.isHidden = !selected
    }
}

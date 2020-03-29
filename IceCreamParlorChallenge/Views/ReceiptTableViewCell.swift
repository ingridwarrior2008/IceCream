//
//  ReceiptTableViewCell.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class ReceiptTableViewCell: UITableViewCell {
    static let identifier = String(describing: ReceiptTableViewCell.self)

    @IBOutlet weak var iceCreamLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: IceCreamModel, total: Int) {
        if total > 1 {
            iceCreamLabel.text = "\(model.iceCreamName) (\(total))"
        } else {
            iceCreamLabel.text = model.iceCreamName
        }
        
        priceLabel.text = model.price
    }

}

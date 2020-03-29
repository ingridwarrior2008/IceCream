//
//  IceCreamView.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class IceCreamView: UIView {
    
    var nibView: UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: IceCreamView.self), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    var contentView: UIView?
    
    @IBOutlet weak var imageBackground: UIView!
    @IBOutlet weak var iceCreamImage: UIImageView!
    @IBOutlet weak var iceCreamLabel: UILabel!
    @IBOutlet weak var iceCreamPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    func setup() {
        guard let view = nibView else { return }
        view.frame = bounds
        addSubview(view)
        contentView = view
    }
    
    func configure(model: IceCreamModel, selected: Bool = false) {
        imageBackground.backgroundColor = UIColor(hexString: model.color)
        imageBackground.layer.cornerRadius = imageBackground.frame.size.width / 2
        iceCreamImage.image = UIImage(named: model.type.imageName)
        iceCreamLabel.text = model.iceCreamName
        iceCreamPriceLabel.text = model.price
        
        if selected {
            
        } else {
            contentView?.layer.borderWidth = 0.3
            contentView?.layer.borderColor = UIColor.gray.cgColor
        }
    }
}

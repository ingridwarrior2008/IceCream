//
//  WelcomeViewDataSource.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class WelcomeViewDataSource: NSObject {

    private(set) weak var viewController: WelcomeViewController?
    private(set) var collectionView: UICollectionView
    private var iceCreams: [IceCreamModel]
    
    init(viewController: WelcomeViewController, collectionView: UICollectionView, iceCreams: [IceCreamModel]) {
        self.viewController = viewController
        self.collectionView = collectionView
        self.iceCreams = iceCreams
        super.init()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension WelcomeViewDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iceCreams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionViewCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IceCreamCollectionViewCell.identifier, for: indexPath) as? IceCreamCollectionViewCell {
            let model = iceCreams[indexPath.row]
            cell.configure(model: model)
            collectionViewCell = cell
        }
        
        return collectionViewCell
    }
}

extension WelcomeViewDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

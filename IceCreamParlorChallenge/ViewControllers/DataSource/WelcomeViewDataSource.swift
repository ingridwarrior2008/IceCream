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
    private(set) weak var delegate: WelcomeViewDelegate?
    private(set) var collectionView: UICollectionView
    private var iceCreams: [IceCreamModel]
    private var iceCreamsSelected: [[IceCreamModel: Int]]
    
    struct Constants {
        static let cellWidth = 153
        static let cellHeight = 219
        static let maxNumberOfSelectedItems = 1
    }

    init(viewController: WelcomeViewController, collectionView: UICollectionView, iceCreams: [IceCreamModel]) {
        self.viewController = viewController
        self.collectionView = collectionView
        self.iceCreams = iceCreams
        self.delegate = viewController
        self.iceCreamsSelected = iceCreams.map { [$0: 0] }
        super.init()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func reloadSelectedItems() {
        iceCreamsSelected.removeAll()
        iceCreamsSelected = iceCreams.map { [$0: 0] }
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
            let iceCreamDictionary = iceCreamsSelected[indexPath.row]
            var isIceCreamSelected = false
            
            if let numberOfSelectedTimes = iceCreamDictionary[model],
                numberOfSelectedTimes > 0 {
                isIceCreamSelected = true
            }
            cell.configure(model: model, selected: isIceCreamSelected)
            collectionViewCell = cell
        }
        
        return collectionViewCell
    }
}

extension WelcomeViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let iceCreamDictionary = iceCreamsSelected[indexPath.row]
        let iceCream = iceCreams[indexPath.row]
        guard var numberOfSelectedTimes = iceCreamDictionary[iceCream] else { return }
        
        if numberOfSelectedTimes > Constants.maxNumberOfSelectedItems {
            delegate?.didRemoveIceCream(item: iceCream)
            iceCreamsSelected[indexPath.row].updateValue(0, forKey: iceCream)
        } else {
            delegate?.didAddIceCream(item: iceCream)
            numberOfSelectedTimes += 1
            iceCreamsSelected[indexPath.row].updateValue(numberOfSelectedTimes, forKey: iceCream)
        }
    }
}

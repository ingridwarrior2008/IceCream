//
//  ViewController.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

protocol WelcomeViewDelegate: class {
    func didAddIceCream(item: IceCreamModel)
    func didRemoveIceCream(item: IceCreamModel)
    func reloadAll()
}

class WelcomeViewController: UIViewController {

    //TODO: Use localizable file
    private struct Constants {
        static let title = "WELCOME"
        static let oderText = "ORDER"
        static let itemSingular = "ITEM"
        static let itemPlural = "ITEMS"
        static let segue = "Receipt"
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var orderButton: UIButton!
    let viewModel = IceCreamViewModel()
    var welcomeViewDataSource: WelcomeViewDataSource?
    var selectedIceCream = [IceCreamModel: Int]()
    
    var numberOfSelectedIceCreams: Int {
        return selectedIceCream.map { $0.value }.reduce(0, +)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segue {
            if let receiptViewController = segue.destination as? ReceiptViewController {
                let sendSelectedIceCreams = selectedIceCream.filter { $0.value > 0 }
                receiptViewController.configure(items: sendSelectedIceCreams, delegate: self)
            }
        }
    }
}

// MARK: - IBActions
extension WelcomeViewController {
    
    @IBAction func didPressOrderButton(_ sender: Any) {
        if numberOfSelectedIceCreams > 0 {
            performSegue(withIdentifier: Constants.segue, sender: self)
        }
    }
}

// MARK: - Private Extensions
fileprivate extension WelcomeViewController {
    func setup() {
        title = Constants.title
        updateButtonTitle()
        viewModel.loadIceCreams { (iceCreams) in
            DispatchQueue.main.async {
                self.welcomeViewDataSource = WelcomeViewDataSource(viewController: self,
                                                                   collectionView: self.collectionView,
                                                                   iceCreams: iceCreams)
            }
        }
    }
    
    func updateButtonTitle() {
        let itemText = numberOfSelectedIceCreams > 1 ? Constants.itemPlural : Constants.itemSingular
        orderButton.setTitle("\(Constants.oderText) \(numberOfSelectedIceCreams) \(itemText)",
            for: .normal)
    }
}

// MARK: - Delegates

extension WelcomeViewController: WelcomeViewDelegate {
    func reloadAll() {
        selectedIceCream.removeAll()
        self.welcomeViewDataSource?.reloadSelectedItems()
        collectionView.reloadData()
        updateButtonTitle()
    }
    
    func didAddIceCream(item: IceCreamModel) {
        collectionView.reloadData()
        guard var numberOfOrderByItem = selectedIceCream[item] else {
            selectedIceCream[item] = 1
            updateButtonTitle()
            return
        }
        
        numberOfOrderByItem += 1
        selectedIceCream[item] = numberOfOrderByItem
        updateButtonTitle()
    }
    
    func didRemoveIceCream(item: IceCreamModel) {
        collectionView.reloadData()
        selectedIceCream[item] = 0
        updateButtonTitle()
    }
}

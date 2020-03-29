//
//  ViewController.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    private struct Constants {
        static let title = "WELCOME"
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = IceCreamViewModel()
    var welcomeViewDataSource: WelcomeViewDataSource?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: - Private Extensions

fileprivate extension WelcomeViewController {
    
    func setup() {
        title = Constants.title
        viewModel.loadIceCreams { (iceCreams) in
            DispatchQueue.main.async {
                self.welcomeViewDataSource = WelcomeViewDataSource(viewController: self, collectionView: self.collectionView, iceCreams: iceCreams)
            }
        }
    }
}

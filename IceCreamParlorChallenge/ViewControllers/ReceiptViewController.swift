//
//  ReceiptViewController.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {

    //TODO: Use localizable file
    private struct Constants {
        static let borderWidth: CGFloat = 2
    }
    
    struct ReceiptModel {
        let iceCreamModel: IceCreamModel
        let numberOfItems: Int
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var newOrderButton: UIButton!
    
    private var receiptItems = [ReceiptModel]()
    private weak var delegate: WelcomeViewDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func configure(items: [IceCreamModel: Int], delegate: WelcomeViewDelegate) {
        receiptItems = items.map { ReceiptModel(iceCreamModel: $0.key, numberOfItems: $0.value) }
        self.delegate = delegate
    }
}

fileprivate extension ReceiptViewController {
    func setup() {
        newOrderButton.layer.borderWidth = Constants.borderWidth
        newOrderButton.layer.borderColor = UIColor.white.cgColor
        loadTotal()
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func loadTotal() {
        let totalPrice = receiptItems.map { (receipt) -> Double in
            let price = receipt.iceCreamModel.price.replacingOccurrences(of: "$", with: "")
            return Double(price) ?? 0
        }.reduce(0, +)
        priceLabel.text = "\(Decimal(totalPrice).deciamlToString())"
    }
}

// MARK: - IBActions
extension ReceiptViewController {
    
     @IBAction func didPressNewOrder(_ sender: Any) {
        delegate?.reloadAll()
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReceiptViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableViewCell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ReceiptTableViewCell.identifier, for: indexPath) as? ReceiptTableViewCell {
            let model = receiptItems[indexPath.row]
            cell.configure(model: model.iceCreamModel, total: model.numberOfItems)
            tableViewCell = cell
        }
        
        return tableViewCell
    }
    
    
}

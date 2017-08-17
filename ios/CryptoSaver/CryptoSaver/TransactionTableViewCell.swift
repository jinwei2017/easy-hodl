//
//  TransactionTableViewCell.swift
//  CryptoSaver
//
//  Created by Simone D'Amico on 17/08/2017.
//  Copyright © 2017 Simone D'Amico. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTransaction(transaction: Transaction){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        timestampLabel.text = dateFormatter.string(from: transaction.timestamp)
        amountLabel.text = "£" + String(Float(transaction.amount) / 100)
        savedLabel.text = "+" + String(transaction.saved) + "p"
        descriptionLabel.text = transaction.__description
    }

}

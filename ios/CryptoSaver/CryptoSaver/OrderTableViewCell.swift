//
//  OrderTableViewCell.swift
//  CryptoSaver
//
//  Created by Simone D'Amico on 17/08/2017.
//  Copyright © 2017 Simone D'Amico. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var ethLabel: UILabel!
    @IBOutlet weak var currencySpentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setOrder(order: Order){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        timestampLabel.text = dateFormatter.string(from: order.timestamp)
        currencySpentLabel.text = "£" + String(order.currencySpent)
        ethLabel.text = "Ξ" + String(order.eth)
    }
}

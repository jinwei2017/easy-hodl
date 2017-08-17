//
//  Transaction.swift
//  CryptoSaver
//
//  Created by Simone D'Amico on 17/08/2017.
//  Copyright © 2017 Simone D'Amico. All rights reserved.
//

import UIKit

class Transaction: NSObject {
    let __description: String
    let timestamp: Date
    let amount: Int
    let saved: Int
    
    init(dict: [String: Any]){
        __description = dict["description"] as! String
        let timestampString = dict["timestamp"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        timestamp = dateFormatter.date(from: timestampString)!
        amount = dict["amount"] as! Int
        saved = dict["saved"] as! Int
    }
}

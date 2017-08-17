//
//  Order.swift
//  CryptoSaver
//
//  Created by Simone D'Amico on 17/08/2017.
//  Copyright © 2017 Simone D'Amico. All rights reserved.
//

import UIKit

class Order: NSObject {
    let timestamp: Date
    let eth: Float
    let currencySpent: Float
    
    
    init(dict: [String: Any]){
        let timestampString = dict["timestamp"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        timestamp = dateFormatter.date(from: timestampString)!
        eth = dict["eth"] as! Float
        currencySpent = dict["currency_spent"] as! Float
    }
}

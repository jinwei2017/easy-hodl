//
//  FirstViewController.swift
//  CryptoSaver
//
//  Created by Simone D'Amico on 16/08/2017.
//  Copyright © 2017 Simone D'Amico. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var noOfTransactionsLabel: UILabel!
    @IBOutlet weak var totalSpendLabel: UILabel!
    @IBOutlet weak var totalSaveLabel: UILabel!
    @IBOutlet weak var ethLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateStats()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateStats(){
        EasyHodlAPI.getStats(){ stats in
            self.noOfTransactionsLabel.text = String(stats["no_of_transactions"] as! Int)
            self.totalSpendLabel.text = "£" + String(Float(stats["total_amount"] as! Int) / 100)
            self.totalSaveLabel.text = "£" + String(Float(stats["total_save"] as! Int) / 100)
            self.ethLabel.text = "Ξ" + String(stats["hodled_eth"] as! Float)
            self.gbpLabel.text = "£" + String(stats["equivalent_gbp"] as! Float)
        }
    }

}


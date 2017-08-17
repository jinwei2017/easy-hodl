//
//  TrueLayerViewController.swift
//  CryptoSaver
//
//  Created by Simone D'Amico on 16/08/2017.
//  Copyright © 2017 Simone D'Amico. All rights reserved.
//

import UIKit

class TrueLayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openTruelayerAuthDialog() {
        let baseURL = "https://auth.truelayer.com/"
        let redirectURI = "cryptosaver://truelayer"
        let scopes = "offline_access%20info%20accounts%20transactions%20balance"
        let clientID = "cryptosaver"
        let url = URL(string: "\(baseURL)?enable_mock=true&response_type=code&client_id=\(clientID)&redirect_uri=\(redirectURI)&scope=\(scopes)&nonce=foo&state=bar");
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


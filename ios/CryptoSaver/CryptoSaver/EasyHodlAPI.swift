//
//  EasyHodlAPI.swift
//  CryptoSaver
//
//  Created by Simone D'Amico on 16/08/2017.
//  Copyright © 2017 Simone D'Amico. All rights reserved.
//
import Alamofire

class EasyHodlAPI {
    static let SECRET_KEY = "secret"
    static let BASE_URL = "https://7b2d892f.ngrok.io"
    
    static func exchangeCode(code: String, failure fail: ((NSError) -> ())? = nil, success succeed: (() -> ())? = nil){
        let params: Parameters = [
            "code": code
        ]
        Alamofire.request(BASE_URL + "/code", method: .post, parameters: params).responseJSON { response in
            
            if let json = response.result.value as? [String: String]{
                let defaults = UserDefaults.standard
                defaults.set(json[SECRET_KEY], forKey: SECRET_KEY)
                if let s = succeed {
                    s()
                }
            }
        }
    }
    
    static func getSecret() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: EasyHodlAPI.SECRET_KEY)
    }
    
    static func getTransactions(failure fail: ((NSError) -> ())? = nil, success succeed: (([Transaction]) -> ())? = nil){
        Alamofire.request(BASE_URL + "/transactions", headers: headers()).responseJSON { response in
            var transactions: [Transaction] = []
            if let transactionsJSON = response.result.value as? [Any]{
                for (transactionJSON) in transactionsJSON {
                    let transactionDict = transactionJSON as! [String: Any]
                    transactions.append(Transaction(dict: transactionDict))
                }
            }
            succeed!(transactions)
        }
    }
    
    static func getOrders(failure fail: ((NSError) -> ())? = nil, success succeed: (([Order]) -> ())? = nil){
        Alamofire.request(BASE_URL + "/orders", headers: headers()).responseJSON { response in
            var orders: [Order] = []
            if let ordersJSON = response.result.value as? [Any]{
                for (orderJSON) in ordersJSON {
                    let orderDict = orderJSON as! [String: Any]
                    orders.append(Order(dict: orderDict))
                }
            }
            succeed!(orders)
        }
    }
    
    static func getStats(failure fail: ((NSError) -> ())? = nil, success succeed: (([String: Any]) -> ())? = nil){
        Alamofire.request(BASE_URL + "/stats", headers: headers()).responseJSON { response in
            if let stats = response.result.value as? [String: Any]{
                succeed!(stats)
            }
        }
    }
    
    static func setKrakenKeys(key: String, secret: String, failure fail: ((NSError) -> ())? = nil, success succeed: (() -> ())? = nil) {
        let params = [
            "kraken_secret": secret,
            "kraken_key": key
        ]
        Alamofire.request(BASE_URL + "/kraken-keys", method: .patch, parameters: params, headers: headers()).response() { _ in
            succeed!()
        }
    }
    
    private static func headers() -> HTTPHeaders{
        let headers: HTTPHeaders = [
            "Authorization": getSecret()!
        ]
        return headers
    }
    
    static func logout(){
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: SECRET_KEY)
    }
}

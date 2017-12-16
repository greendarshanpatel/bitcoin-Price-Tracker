//
//  AppDelegate.swift
//  BitcoinTicker
//
//  Created by darshan p. on 23/01/2016.
//  Copyright © 2016 darshan p. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    
    

    
    
    
//
//    //MARK: - Networking
//    /***************************************************************/
    
    func getPriceData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the Price data")
                    let PriceJSON : JSON = JSON(response.result.value!)

                    self.updatePriceData(json: PriceJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }

    
    
    
//
//    //MARK: - JSON Parsing
//    /***************************************************************/
    
    func updateBitcoinData(json : JSON) {
        
        if let tempResult = json["main"]["temp"].double {
        
        
    }
    




}


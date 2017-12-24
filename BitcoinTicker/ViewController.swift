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
    let currencySymbol = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""
    
    var currencyChoosedSymbol = ""
    

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var dayAverage: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var open: UILabel!
    @IBOutlet weak var openHour: UILabel!
    @IBOutlet weak var high: UILabel!
    
    //MARK- number of components
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        currencyChoosedSymbol = currencySymbol[row]
        return currencyArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getPriceData(url: finalURL)
        
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
       
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    
    

    
    
    
//
//    //MARK: - Networking
//    /***************************************************************/
    
    func getPriceData(url: String) {
        
        Alamofire.request(finalURL, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the Price data")
                    let PriceJSON : JSON = JSON(response.result.value!)
                    print(PriceJSON)

                    self.updateBitcoinData(json: PriceJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }
    
    
   

//
//    //MARK: - JSON Parsing
//    /***************************************************************/
    
    func updateBitcoinData(json : JSON){
        dayAverage.text = currencyChoosedSymbol + String(describing: json["averages"]["day"])
        volume.text = String(describing: json["volume"])
        open.text = currencyChoosedSymbol + String(describing: json["open"]["day"])
        openHour.text = currencyChoosedSymbol + String(describing: json["open"]["hour"])
        high.text = currencyChoosedSymbol + String(describing: json["high"])
        if var tempResult = json["ask"].double {
            bitcoinPriceLabel.text = currencyChoosedSymbol + String(tempResult)
            
           
        }else{
            print("error")
        }
    }
    



    }




//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}


struct CoinManager{
    
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "7C6BB0E2-AA79-4C73-8606-CD4F4066078B"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

   
    
    
    
     func getCoinPrice(for currency: String){
        let finalURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
         performRequest(with: finalURL)
    }
    func performRequest (with finalURL: String){
        // 1) Create URl
        if let url = URL(string: finalURL){
            // 2) Create URLSession
            let session = URLSession(configuration: .default)
            
            //Give a task to URLSession
            
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error! )
                }
                if let safeData = data{
                    let dataString = String(data: safeData, encoding: .utf8)
                    if let coin = self.parseJSON(safeData){
                        delegate?.didUpdateCoin(self, coin: coin)
                        
                    }
                }
            }
            // Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let lastPrice = decodedData.rate
            
            let coin = CoinModel(price: lastPrice)
            return coin
            
        }catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
  
}



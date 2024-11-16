//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Islam Rzayev on 16.11.24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation
struct CoinModel{
    
    
    let price: Double
    
    var priceString: String{
        String(format: "%.2f", price)
    }
}

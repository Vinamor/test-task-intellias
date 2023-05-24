//
//  Quote.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

struct Quote:Codable {
  var symbol:String?
  var name:String?
  var currency:String?
  var readableLastChangePercent:String?
  var last:String?
  var variationColor:String?
  var isFavorite: Bool
  
  enum CodingKeys: String, CodingKey {
    case symbol
    case name
    case currency
    case readableLastChangePercent
    case last
    case variationColor
    case isFavorite
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    symbol = try container.decode(String?.self, forKey: .symbol)
    name = try container.decode(String?.self, forKey: .name)
    currency = try container.decode(String?.self, forKey: .currency)
    readableLastChangePercent = try container.decode(String?.self, forKey: .readableLastChangePercent)
    last = try container.decode(String?.self, forKey: .last)
    variationColor = try container.decode(String?.self, forKey: .variationColor)
    isFavorite = false
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(symbol, forKey: .symbol)
    try container.encode(name, forKey: .name)
    try container.encode(currency, forKey: .currency)
    try container.encode(readableLastChangePercent, forKey: .readableLastChangePercent)
    try container.encode(last, forKey: .last)
    try container.encode(variationColor, forKey: .variationColor)
  }
}

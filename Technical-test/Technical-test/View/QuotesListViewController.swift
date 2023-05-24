//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

enum VariationColor: String {
  case red
  case green
  case gray
  
  var color: UIColor {
    switch self {
    case .red: return .red
    case .green: return .green
    case .gray: return .gray
    }
  }
}

class QuotesListViewController: UITableViewController {
  
  private let dataManager:DataManager = DataManager()
  private var market:Market? = nil
  private var quotes:[Quote] = []
  private var selectedQuoteCellIndex: IndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nib = UINib(nibName: "QuoteTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "QuoteTableViewCell")
    dataManager.fetchQuotes { [weak self] result in
      switch result {
      case .success(let quotes):
        self?.quotes = quotes
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      case .failure(let error):
        print("Error: \(error.localizedDescription)")
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return quotes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell", for: indexPath) as! QuoteTableViewCell
    
    let quote = quotes[indexPath.row]
    cell.nameLabel.text = quote.name
    cell.lastAndCurrencyLabel.text = (quote.last ?? "") + " " + (quote.currency ?? "")
    cell.favoriteButton.setImage(UIImage(systemName: quote.isFavorite ? "star.fill" : "star"), for: .normal)
    cell.favoriteButton.setTitle("", for: .normal)
    cell.lastChangePercentageLabel.text = quote.readableLastChangePercent
    if let variationColor = quote.variationColor {
      cell.lastChangePercentageLabel.textColor = VariationColor(rawValue: variationColor)?.color
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedQuoteCellIndex = indexPath
    let selectedQuote = quotes[indexPath.row]
    let vc = QuoteDetailsViewController(quote: selectedQuote)
    vc.delegate = self
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension QuotesListViewController: QuoteDetailsDelegate {
  func quoteDetailsDidUpdate(_ quote: Quote) {
    if let indexPath = selectedQuoteCellIndex {
      quotes[indexPath.row] = quote
      tableView.beginUpdates()
      tableView.reloadRows(at: [indexPath], with: .fade)
      tableView.endUpdates()
    }
  }
}

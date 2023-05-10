import UIKit

class HeaderCell: UITableViewHeaderFooterView {
    static let reuseIidentifier = "HeaderCell"
    
    @IBOutlet weak var instrumentNameTitlLabel: UILabel!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var amountTitleLabel: UILabel!
    @IBOutlet weak var sideTitleLabel: UILabel!
    
    var viewModel: HeaderCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private func configure() {
        instrumentNameTitlLabel.text = viewModel?.instrumentNameText
        priceTitleLabel.text = viewModel?.priceText
        amountTitleLabel.text = viewModel?.amountText
        sideTitleLabel.text = viewModel?.sideText
    }
    
    private func updateLabelsWithText(instrumentName: String, price: String, amount: String, side: String) {
        instrumentNameTitlLabel.text = instrumentName
        priceTitleLabel.text = price
        amountTitleLabel.text = amount
        sideTitleLabel.text = side
    }
    
    func updateLabels(with viewModel: DealsTableViewType) {
        switch viewModel.sortType {
        case .byTime:
            updateLabelsWithText(instrumentName: "Instrument", price: "Price", amount: "Amount", side: "Side")
        case .byInstrumentName:
            let arrow = viewModel.sortAscending ? " ↓" : " ↑"
            updateLabelsWithText(instrumentName: "Instrument" + arrow, price: "Price", amount: "Amount", side: "Side")
        case .byPrice:
            let arrow = viewModel.sortAscending ? " ↓" : " ↑"
            updateLabelsWithText(instrumentName: "Instrument", price: "Price" + arrow, amount: "Amount", side: "Side")
        case .byAmountCount:
            let arrow = viewModel.sortAscending ? " ↓" : " ↑"
            updateLabelsWithText(instrumentName: "Instrument", price: "Price", amount: "Amount" + arrow, side: "Side")
        case .bySide:
            let arrow = viewModel.sortAscending ? " ↓" : " ↑"
            updateLabelsWithText(instrumentName: "Instrument", price: "Price", amount: "Amount", side: "Side" + arrow)
        case .back:
            updateLabelsWithText(instrumentName: "Instrument", price: "Price", amount: "Amount", side: "Side")
        }
    }
}

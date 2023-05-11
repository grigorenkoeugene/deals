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
    
    func configure(with viewModel: HeaderCellViewModel) {
        self.viewModel = viewModel
        configure()
    }
}

import UIKit

class DealCell: UITableViewCell {
    static let reuseIidentifier = "DealCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var instrumentNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var sideLabel: UILabel!
    
    weak var viewModel: DealsTableViewCellViewModelType? {
        didSet {
            guard let viewModel = viewModel else { return }
            dateLabel.text = viewModel.date
            instrumentNameLabel.text = viewModel.instrumentName
            priceLabel.text = (String(viewModel.price))
            amountLabel.text = (String(viewModel.amount))
            if let side = viewModel.side {
                sideLabel.text = side == .buy ? "Buy" : "Sell"
                sideLabel.textColor = side == .buy ? UIColor.green : UIColor.red
            } else {
                sideLabel.text = ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

import Foundation


class DealsTableViewCellViewModel: DealsTableViewCellViewModelType {

    private var deal: Deal
    
    var date: String {
        formattedDate(deal.dateModifier)
    }
    
    var instrumentName: String {
        deal.instrumentName
    }
    
    var price: Double {
        formatPrice(deal.price)
    }
    
    var amount: Double {
        deal.amount.rounded()
    }
    
    var side: Deal.Side? {
        get {
            return deal.side
        }
    }

    func formatPrice(_ price: Double?) -> Double {
        guard let priceValue = price else {
            return 0.00
        }
        return Double(String(format: "%.2f", priceValue)) ?? 0.00
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    init(deal: Deal) {
        self.deal = deal
    }
}

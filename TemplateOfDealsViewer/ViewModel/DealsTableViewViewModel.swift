import Foundation

enum SortType {
    case byTime
    case byInstrumentName
    case byPrice
    case byAmountCount
    case bySide
    case back
}

class DealsTableViewViewModel: DealsTableViewType {
    
    var sortType: SortType = .byTime
    var sortAscending = true
    var sortingThreshold = 1000
    var hasNewData = false

    private var deal: [Deal] = []
    private var dealCount = 0
    private var dealBuffer: [Deal] = []

    func getDeals(completion: @escaping (Error?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            Server().subscribeToDeals { [weak self] deals in
                guard let self = self else { return }
                self.dealBuffer.append(contentsOf: deals)
                self.dealCount += deals.count

                if self.dealCount >= self.sortingThreshold {
                    self.hasNewData = true
                    self.deal.append(contentsOf: self.dealBuffer)
                    self.sortDeals()
                    self.dealBuffer = []
                    self.dealCount = 0
                }
                completion(nil)
            }
        }
    }
    
    func sortDeals() {
        switch sortType {
        case .byTime:
            deal.sort { sortAscending ? $0.dateModifier > $1.dateModifier : $0.dateModifier < $1.dateModifier }
        case .byInstrumentName:
            deal.sort { sortAscending ? $0.instrumentName > $1.instrumentName : $0.instrumentName < $1.instrumentName }
        case .byPrice:
            deal.sort { sortAscending ? $0.price > $1.price : $0.price < $1.price }
        case .byAmountCount:
            deal.sort { sortAscending ? $0.amount > $1.amount : $0.amount < $1.amount }
        case .bySide:
            deal.sort { sortAscending ? $0.side > $1.side : $0.side < $1.side }
        case .back:
            deal.sort { sortAscending ? $0.dateModifier > $1.dateModifier : $0.dateModifier < $1.dateModifier }
        }
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DealsTableViewCellViewModelType? {
        let deal = deal[indexPath.row]
        return DealsTableViewCellViewModel(deal: deal)
    }
    
    func numberOfRows() -> Int {
        deal.count
    }
}


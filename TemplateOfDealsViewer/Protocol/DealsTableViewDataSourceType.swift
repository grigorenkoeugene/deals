import Foundation

protocol DealsTableViewDataSourceType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DealsTableViewCellViewModelType?
   
}

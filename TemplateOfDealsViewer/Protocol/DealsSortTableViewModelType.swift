import Foundation

protocol DealsSortTableViewModelType {
    var sortType: SortType { get set }
    var sortAscending: Bool { get set }
    func sortDeals()
    func getDeals(completion: @escaping (Error?) -> Void)
}
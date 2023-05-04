import Foundation

protocol DealsTableViewCellViewModelType : AnyObject {
    var date: String { get }
    var instrumentName: String { get }
    var price: Double { get }
    var amount: Double { get }
    var side: Deal.Side? { get }
    func formatPrice(_ price: Double?) -> Double
}

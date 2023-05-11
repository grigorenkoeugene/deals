//
//  HeaderCellViewModel.swift
//  TemplateOfDealsViewer
//
//  Created by admin on 05.05.2023.
//

import Foundation

class HeaderCellViewModel {
    var sortType: SortType
    var sortAscending: Bool

    init(sortType: SortType, sortAscending: Bool) {
        self.sortType = sortType
        self.sortAscending = sortAscending
    }

    var instrumentNameText: String {
        switch sortType {
        case .byInstrumentName:
            return "Instrument" + (sortAscending ? " ↑" : " ↓")
        default:
            return "Instrument"
        }
    }

    var priceText: String {
        switch sortType {
        case .byPrice:
            return "Price" + (sortAscending ? " ↑" : " ↓")
        default:
            return "Price"
        }
    }

    var amountText: String {
        switch sortType {
        case .byAmountCount:
            return "Amount" + (sortAscending ? " ↑" : " ↓")
        default:
            return "Amount"
        }
    }

    var sideText: String {
        switch sortType {
        case .bySide:
            return "Side" + (sortAscending ? " ↑" : " ↓")
        default:
            return "Side"
        }
    }
}

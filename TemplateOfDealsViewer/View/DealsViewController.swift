import UIKit

class DealsViewController: UIViewController {

    private enum Icon: String {
        case arrow = "arrow.up.arrow.down"
        case line = "line.horizontal.3.decrease.circle"
    }
    
    // MARK: - Properties

    private var viewModel: DealsTableViewType?
    private let server = Server()
    private var model: [Deal] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DealsTableViewViewModel()
        setupTableView()
        navigationController()
        viewModel?.sortType = .byTime
        viewModel?.sortDeals()
        self.viewModel?.getDeals{ [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableView.register(UINib(nibName: DealCell.reuseIidentifier, bundle: nil), forCellReuseIdentifier: DealCell.reuseIidentifier)
        tableView.register(UINib(nibName: HeaderCell.reuseIidentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderCell.reuseIidentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Navigation

    private func navigationController() {
        title = "Deals"
        let ascendingButton = UIBarButtonItem(image: UIImage(systemName: Icon.arrow.rawValue), style: .plain, target: self, action: #selector(ascendingAction))
        let sortButton = UIBarButtonItem(image: UIImage(systemName: Icon.line.rawValue), style: .plain, target: self, action: #selector(sortAction))
        self.navigationItem.leftBarButtonItem = ascendingButton
        self.navigationItem.rightBarButtonItem = sortButton
    }
    
    // MARK: - Actions on navigationBar

    @objc func sortAction() {
        let alertController = UIAlertController(title: "Сортировка", message: "Выберите вариант сортировки:", preferredStyle: .actionSheet)
        
        let actions: [(title: String, style: UIAlertAction.Style, sortType: SortType)] = [
            ("Дата изменения сделки", .default, .byTime),
            ("Имя инструмента", .default, .byInstrumentName),
            ("Цена сделки", .default, .byPrice),
            ("Объем сделки", .default, .byAmountCount),
            ("Сторона сделки", .default, .bySide),
            ("Отмена", .cancel, .back)
        ]
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                self.viewModel?.sortType = action.sortType
                self.viewModel?.sortDeals()
                self.tableView.reloadData()
            }
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true)
    }
    
    @objc func ascendingAction() {
        viewModel?.sortAscending.toggle()
        viewModel?.sortDeals()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DealsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DealCell.reuseIidentifier, for: indexPath) as? DealCell
        guard let tableCell = cell else { return UITableViewCell() }
        let cellViewModel = viewModel?.cellViewModel(forIndexPath: indexPath)
        tableCell.viewModel = cellViewModel
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.reuseIidentifier) as! HeaderCell
        
        return cell
    }
}


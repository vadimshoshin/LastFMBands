import UIKit

final class BandsMediator: NSObject {
    let tableView: UITableView
    let dataSource: BandsViewModel
    
    init(tableView: UITableView, dataSource: BandsViewModel) {
        self.tableView = tableView
        self.dataSource = dataSource
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        BandCell.register(in: tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reload() {
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }
}

extension BandsMediator: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BandCell.dequeue(in: tableView, at: indexPath)
        let cellModel = dataSource.bandModel(at: indexPath.row)
        cell.setup(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.processItemSelection(at: indexPath.row)
    }
}

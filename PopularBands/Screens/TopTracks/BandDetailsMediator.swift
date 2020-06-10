import UIKit

final class BandDetailsMediator: NSObject {
    let tableView: UITableView
    let dataSource: BandDetailsViewModel
    
    init(tableView: UITableView, dataSource: BandDetailsViewModel) {
        self.tableView = tableView
        self.dataSource = dataSource
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
//        BandCell.register(in: tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reload() {
        tableView.reloadData()
    }
}

extension BandDetailsMediator: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
//        return dataSource.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BandCell.dequeue(in: tableView, at: indexPath)
//        let cellModel = dataSource.bandModel(at: indexPath.row)
//        cell.setup(with: cellModel)
        return cell
    }
}

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
        TrackCell.register(in: tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reload() {
        tableView.reloadData()
    }
}

extension BandDetailsMediator: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.tracksCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TrackCell.dequeue(in: tableView, at: indexPath)
        let cellModel = dataSource.trackCellModel(at: indexPath.row)
        cell.setup(with: cellModel)
        return cell
    }
}

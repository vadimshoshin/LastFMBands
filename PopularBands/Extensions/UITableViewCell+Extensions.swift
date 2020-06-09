import UIKit

protocol ReusableTableViewCell {
    static var identifier: String { get }
    static var nib: UINib? { get }
    static func register(in tableView: UITableView)
    static func dequeue(in tableView: UITableView, at indexPath: IndexPath) -> Self
}

extension ReusableTableViewCell where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func register(in tableView: UITableView) {
        if let nib = self.nib {
            tableView.register(nib, forCellReuseIdentifier: identifier)
        } else {
            tableView.register(Self.self, forCellReuseIdentifier: identifier)
        }
    }
    
    static func dequeue(in tableView: UITableView, at indexPath: IndexPath) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            as? Self else {
                fatalError("Wrong cell id")
        }
        return cell
    }
}

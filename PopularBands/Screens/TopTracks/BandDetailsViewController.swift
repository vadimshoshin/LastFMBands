import UIKit
import SDWebImage

class BandDetailsViewController: UIViewController {
    @IBOutlet private weak var tracksTableView: UITableView!
    @IBOutlet private weak var artistImage: UIImageView!
    
    var router: NavigationRouter!
    var viewModel: BandDetailsViewModel!
    
    var mediator: BandDetailsMediator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("selectedBandID - \(viewModel.bandName())")
        setupUI()
        mediator = BandDetailsMediator(tableView: tracksTableView, dataSource: viewModel)
        setupViewModelBlocks()
        viewModel.fetchData()
    }
    
    private func setupViewModelBlocks() {
        viewModel.onDataUpdated = { [weak self] in
            self?.mediator.reload()
        }
        
        viewModel.onBandSetup = { [weak self] in
            self?.setupUI()
        }
    }
    
    private func setupUI() {
        title = viewModel.bandName()
        let imageURL = viewModel.bandImageUrl()
        artistImage.sd_setImage(with: URL(string: imageURL ?? ""), completed: nil)
    }
    
    func configure(router: NavigationRouter, viewModel: BandDetailsViewModel) {
        self.router = router
        self.viewModel = viewModel
    }
}

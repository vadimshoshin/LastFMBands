import UIKit

class BandsViewController: UIViewController {

    @IBOutlet private weak var bandsTableView: UITableView!
    
    var router: NavigationRouter!
    var viewModel: BandsViewModel!
    
    var mediator: BandsMediator!
    var countryButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mediator = BandsMediator(tableView: bandsTableView,
                                 dataSource: viewModel)
        setupViewModelBlocks()
        performFetch()
        self.title = "Popular Artists"
        
        #if DEVELOP
        debugPrint("env is develop")
        #else
        debugPrint("env is prod")
        #endif
        
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.selectedCountry, style: .plain, target: self, action: #selector(selectCountry))
        countryButton = navigationItem.rightBarButtonItem
    }
    
    
    @objc func selectCountry() {
        let alertController = UIAlertController(title: "Select Country", message: nil, preferredStyle: .actionSheet)
        let ukraine = UIAlertAction(title: "Ukraine", style: .default) {[weak self] _ in
            self?.viewModel.processCountrySelection(selectedCountry: "Ukraine")
        }
        
        let germany = UIAlertAction(title: "Germany", style: .default) {[weak self] _ in
            self?.viewModel.processCountrySelection(selectedCountry: "Germany")
        }
        
        let china = UIAlertAction(title: "China", style: .default) {[weak self] _ in
            self?.viewModel.processCountrySelection(selectedCountry: "China")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(ukraine)
        alertController.addAction(germany)
        alertController.addAction(china)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func setupViewModelBlocks() {
        viewModel.onBandsLoaded = { [weak self] in
            self?.mediator.reload()
        }
        
        viewModel.onCountryChanged = { [weak self] in
            self?.setupUI()
        }
    }
    
    private func performFetch() {
        viewModel.fetchBands()
    }
    
    func configure(router: NavigationRouter, viewModel: BandsViewModel) {
        self.router = router
        self.viewModel = viewModel
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        router.prepare(for: segue, sender: sender)
    }
}


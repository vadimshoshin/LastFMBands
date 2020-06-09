import UIKit

protocol NavigationRouter: class {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol BandsRouter: NavigationRouter {
    func showDetailsScreen(for bandId: String)
}

class BandsRouterImpl: BandsRouter {
    let dependencies: AppDependencies
    
    weak var controller: BandsViewController?
    
    init(with dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsScreen = segue.destination as? BandDetailsViewController, segue.identifier == "showDetails", let bandID = sender as? String else {
            return
        }
        let bandDetailsRouter = BandDetailsRouterImpl(with: dependencies)
        bandDetailsRouter.start(with: detailsScreen, bandId: bandID)
    }
    
    func start(with controller: BandsViewController) {
        let viewModel = BandsViewModelImpl(with: dependencies)
        viewModel.router = self
        self.controller = controller
        controller.configure(router: self, viewModel: viewModel)
    }
    
    func showDetailsScreen(for bandId: String) {
        controller?.performSegue(withIdentifier: "showDetails", sender: bandId)
    }
    
}

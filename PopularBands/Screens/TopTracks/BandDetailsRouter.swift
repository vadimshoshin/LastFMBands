import UIKit

protocol BandDetailsRouter: NavigationRouter {
    
}

class BandDetailsRouterImpl: BandDetailsRouter {
    let dependencies: AppDependencies
    
    weak var controller: BandDetailsViewController?
    
    init(with dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func start(with controller: BandDetailsViewController, bandId: String) {
        let viewModel = BandDetailsViewModelImpl(with: dependencies)
        viewModel.router = self
        viewModel.selectedBandId = bandId
        self.controller = controller
        controller.configure(router: self, viewModel: viewModel)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    
}

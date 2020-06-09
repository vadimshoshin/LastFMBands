import UIKit

protocol NavigationRouter: class {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol BandsRouter: NavigationRouter {
    
}

class BandsRouterImpl: BandsRouter {
    let dependencies: AppDependencies
    
    weak var controller: BandsViewController?
    weak var navigationController: UINavigationController?
    
    init(with dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func start(with controller: BandsViewController) {
        let viewModel = BandsViewModelImpl(with: dependencies)
        viewModel.router = self
        self.controller = controller
        controller.configure(router: self, viewModel: viewModel)
    }
    
}

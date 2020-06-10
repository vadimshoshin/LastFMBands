import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let dependencies = AppDependencies()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dependencies = AppDependencies()
        if let bandsController = (window?.rootViewController as? UINavigationController)?.viewControllers.first as? BandsViewController {
            let bandsRouter = BandsRouterImpl(with: dependencies)
            bandsRouter.start(with: bandsController)
        }
        return true
    }

}

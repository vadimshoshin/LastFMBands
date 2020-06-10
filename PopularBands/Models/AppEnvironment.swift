import Foundation

enum AppEnvironment: String {
    case develop
    case prod
    
    static var current: AppEnvironment {
        #if DEVELOP
        return .develop
        #else
        return .prod
        #endif
    }
}

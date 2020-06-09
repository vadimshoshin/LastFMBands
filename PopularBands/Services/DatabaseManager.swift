import Foundation
import RealmSwift

protocol DatabaseManager {
    func storeBands(_ bands: [Band])
    func fetchBands() -> [Band]
}

final class RealmManager: DatabaseManager {
    let realm = try! Realm()
    
    func storeBands(_ bands: [Band]) {
        do {
            try realm.write {
                realm.add(bands)
            }
        } catch let error {
            debugPrint("Database storing error - \(error)")
        }
    }
    
    func fetchBands() -> [Band] {
        let bandsResult = realm.objects(Band.self)
        return Array(bandsResult)
    }
}

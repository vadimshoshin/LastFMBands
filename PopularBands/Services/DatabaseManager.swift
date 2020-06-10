import Foundation
import RealmSwift

protocol DatabaseManager {
    func fetchBands() -> [Band]
    func fetchBand(with id: String) -> Band?
    func fetchTracks(with bandID: String) -> [Track] 
    func store<T: Object>(items: [T])
    func storeBands(bands: [Band])
}

final class RealmManager: DatabaseManager {
    let realm = try! Realm()
    
    func store<T: Object>(items: [T]) {
        do {
            try realm.write {
                realm.add(items)
            }
        } catch let error {
            debugPrint("Database storing error - \(error)")
        }
    }
    
    func fetchBands() -> [Band] {
        let bandsResult = realm.objects(Band.self)
        return Array(bandsResult)
    }
    
    func fetchBand(with id: String) -> Band? {
        let result = Array(realm.objects(Band.self).filter( {$0.mbid == id} ))
        return result.first
    }
    
    func fetchTracks(with bandID: String) -> [Track] {
        return Array( realm.objects(Track.self).filter( {$0.artist?.mbid == bandID}))
    }
    
    func storeBands(bands: [Band]) {
        do {
            
            for band in bands {
                realm.add(band)
            }

        } catch let error {
            debugPrint("Database storing error - \(error)")
        }
    }
}

import RealmSwift

class Band: Object, Codable {
    @objc dynamic var name: String
    @objc dynamic var id: String
    let images: Set<BandImage>
    @objc dynamic var listeners: String
    enum CodingKeys: String, CodingKey {
        case name
        case id = "mbid"
        case images = "image"
        case listeners
    }
}

class BandImage:Object, Codable {
    @objc dynamic var size: String
    @objc dynamic var url: String
    
    enum CodingKeys: String, CodingKey {
        case size
        case url = "#text"
    }
}

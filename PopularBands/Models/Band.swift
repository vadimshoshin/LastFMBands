import RealmSwift

class Band: Object, Codable {
    @objc dynamic var name: String?
    @objc dynamic var mbid: String?
    @objc dynamic var listeners: String?
    
    var artistPhoto = List<ArtistImage>()
    enum CodingKeys: String, CodingKey {
        case name
        case mbid
        case artistPhoto = "image"
        case listeners
    }
}

class ArtistImage: Object, Codable {
    @objc dynamic var size: String
    @objc dynamic var url: String
    
    enum CodingKeys: String, CodingKey {
        case size
        case url = "#text"
    }
}

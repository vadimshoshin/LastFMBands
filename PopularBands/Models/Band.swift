import RealmSwift

class Band: Object, Codable {
    let name: String
    let id: String
    let images: Set<BandImage>
    let listeners: String
    enum CodingKeys: String, CodingKey {
        case name
        case id = "mbid"
        case images = "image"
        case listeners
    }
}

class BandImage:Object, Codable {
    let size: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case size
        case url = "#text"
    }
}

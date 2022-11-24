//For random Joke
struct Response:Codable{
    var icon_url:String?
    var id:String?
    var url:String?
    var value:String?
}

//For Joke Search
struct SearchResponse: Codable{
    var total: Int
    var result: [Body]
}

struct Body : Codable{
    var category:[String]?
    var icon_url:String?
    var id:String?
    var url:String?
    var value:String?
}

//For urban dictionary search
struct Definitions:Codable {
    var list : [Definition]
}

struct Definition:Codable {
    var definition: String?
    var permalink:String?
    var thumbs_up:Int?
    var sound_urls:[String?]
    var author:String?
    var word:String?
    var defid:Int?
    var currentVote:String?
    var written_on:String?
    var example:String?
    var thumbs_down:Int?
}


import Foundation

struct Films: Decodable {
  let results: [Properties]
}

struct Properties: Decodable {
  let posterPath: String
  let title: String
  let overview: String
}

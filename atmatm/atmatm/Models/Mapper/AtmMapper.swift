/* DO NOT EDIT | Generated by gyro */

import ObjectMapper

extension Atm: Mappable {

  // MARK: Initializers
  convenience init?(map: Map) {
    self.init()
  }

  // MARK: Mappable
  func mapping(map: Map) {
    // MARK: Attributes
    self.sonectId <- map["sonectId"]
    self.category <- map["category"]
    self.categoryText <- map["categoryText"]
    self.imagePath <- map["imagePath"]
    self.latitude <- map["latitude"]
    self.longitude <- map["longitude"]
    self.name <- map["name"]
    self.tagline <- map["tagline"]

    // MARK: Relationships
    self.address <- map["address"]
    self.openingHours <- map["openingHours"]
  }
}

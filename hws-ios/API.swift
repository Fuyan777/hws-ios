// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum Area: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// 大門
  case daimon
  /// 五稜郭
  case goryokaku
  /// 美原
  case mihara
  /// 石川
  case ishikawa
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "Daimon": self = .daimon
      case "Goryokaku": self = .goryokaku
      case "Mihara": self = .mihara
      case "Ishikawa": self = .ishikawa
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .daimon: return "Daimon"
      case .goryokaku: return "Goryokaku"
      case .mihara: return "Mihara"
      case .ishikawa: return "Ishikawa"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Area, rhs: Area) -> Bool {
    switch (lhs, rhs) {
      case (.daimon, .daimon): return true
      case (.goryokaku, .goryokaku): return true
      case (.mihara, .mihara): return true
      case (.ishikawa, .ishikawa): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [Area] {
    return [
      .daimon,
      .goryokaku,
      .mihara,
      .ishikawa,
    ]
  }
}

public enum Equipment: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Wi-Fi
  case wifi
  /// コンセント
  case outlet
  /// ゴミ箱
  case garbage
  /// 食べ物
  case food
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "Wifi": self = .wifi
      case "Outlet": self = .outlet
      case "Garbage": self = .garbage
      case "Food": self = .food
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .wifi: return "Wifi"
      case .outlet: return "Outlet"
      case .garbage: return "Garbage"
      case .food: return "Food"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Equipment, rhs: Equipment) -> Bool {
    switch (lhs, rhs) {
      case (.wifi, .wifi): return true
      case (.outlet, .outlet): return true
      case (.garbage, .garbage): return true
      case (.food, .food): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [Equipment] {
    return [
      .wifi,
      .outlet,
      .garbage,
      .food,
    ]
  }
}

public enum Category: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// カフェ
  case cafe
  /// レストラン
  case restaurant
  /// コワーキングスペース
  case coworkingSpace
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "Cafe": self = .cafe
      case "Restaurant": self = .restaurant
      case "Coworking_Space": self = .coworkingSpace
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .cafe: return "Cafe"
      case .restaurant: return "Restaurant"
      case .coworkingSpace: return "Coworking_Space"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Category, rhs: Category) -> Bool {
    switch (lhs, rhs) {
      case (.cafe, .cafe): return true
      case (.restaurant, .restaurant): return true
      case (.coworkingSpace, .coworkingSpace): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [Category] {
    return [
      .cafe,
      .restaurant,
      .coworkingSpace,
    ]
  }
}

public final class GetSpaceQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getSpace($spaceID: String!) {
      space(spaceID: $spaceID) {
        __typename
        id
        name
        description
        image
        address
        longitude
        latitude
        area
        equipments
        category
      }
    }
    """

  public let operationName: String = "getSpace"

  public var spaceID: String

  public init(spaceID: String) {
    self.spaceID = spaceID
  }

  public var variables: GraphQLMap? {
    return ["spaceID": spaceID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("space", arguments: ["spaceID": GraphQLVariable("spaceID")], type: .nonNull(.object(Space.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(space: Space) {
      self.init(unsafeResultMap: ["__typename": "Query", "space": space.resultMap])
    }

    public var space: Space {
      get {
        return Space(unsafeResultMap: resultMap["space"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "space")
      }
    }

    public struct Space: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Space"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("image", type: .scalar(String.self)),
          GraphQLField("address", type: .scalar(String.self)),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
          GraphQLField("area", type: .scalar(Area.self)),
          GraphQLField("equipments", type: .list(.nonNull(.scalar(Equipment.self)))),
          GraphQLField("category", type: .scalar(Category.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String, description: String? = nil, image: String? = nil, address: String? = nil, longitude: Double? = nil, latitude: Double? = nil, area: Area? = nil, equipments: [Equipment]? = nil, category: Category? = nil) {
        self.init(unsafeResultMap: ["__typename": "Space", "id": id, "name": name, "description": description, "image": image, "address": address, "longitude": longitude, "latitude": latitude, "area": area, "equipments": equipments, "category": category])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var image: String? {
        get {
          return resultMap["image"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image")
        }
      }

      public var address: String? {
        get {
          return resultMap["address"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address")
        }
      }

      public var longitude: Double? {
        get {
          return resultMap["longitude"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "longitude")
        }
      }

      public var latitude: Double? {
        get {
          return resultMap["latitude"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "latitude")
        }
      }

      public var area: Area? {
        get {
          return resultMap["area"] as? Area
        }
        set {
          resultMap.updateValue(newValue, forKey: "area")
        }
      }

      public var equipments: [Equipment]? {
        get {
          return resultMap["equipments"] as? [Equipment]
        }
        set {
          resultMap.updateValue(newValue, forKey: "equipments")
        }
      }

      public var category: Category? {
        get {
          return resultMap["category"] as? Category
        }
        set {
          resultMap.updateValue(newValue, forKey: "category")
        }
      }
    }
  }
}

public final class GetSpacesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getSpaces {
      spaces(offset: 1, limit: 20) {
        __typename
        id
        name
        description
        image
        address
        longitude
        latitude
        area
        category
        equipments
      }
    }
    """

  public let operationName: String = "getSpaces"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("spaces", arguments: ["offset": 1, "limit": 20], type: .nonNull(.list(.nonNull(.object(Space.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(spaces: [Space]) {
      self.init(unsafeResultMap: ["__typename": "Query", "spaces": spaces.map { (value: Space) -> ResultMap in value.resultMap }])
    }

    public var spaces: [Space] {
      get {
        return (resultMap["spaces"] as! [ResultMap]).map { (value: ResultMap) -> Space in Space(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Space) -> ResultMap in value.resultMap }, forKey: "spaces")
      }
    }

    public struct Space: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Space"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("image", type: .scalar(String.self)),
          GraphQLField("address", type: .scalar(String.self)),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
          GraphQLField("area", type: .scalar(Area.self)),
          GraphQLField("category", type: .scalar(Category.self)),
          GraphQLField("equipments", type: .list(.nonNull(.scalar(Equipment.self)))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String, description: String? = nil, image: String? = nil, address: String? = nil, longitude: Double? = nil, latitude: Double? = nil, area: Area? = nil, category: Category? = nil, equipments: [Equipment]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Space", "id": id, "name": name, "description": description, "image": image, "address": address, "longitude": longitude, "latitude": latitude, "area": area, "category": category, "equipments": equipments])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var image: String? {
        get {
          return resultMap["image"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image")
        }
      }

      public var address: String? {
        get {
          return resultMap["address"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address")
        }
      }

      public var longitude: Double? {
        get {
          return resultMap["longitude"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "longitude")
        }
      }

      public var latitude: Double? {
        get {
          return resultMap["latitude"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "latitude")
        }
      }

      public var area: Area? {
        get {
          return resultMap["area"] as? Area
        }
        set {
          resultMap.updateValue(newValue, forKey: "area")
        }
      }

      public var category: Category? {
        get {
          return resultMap["category"] as? Category
        }
        set {
          resultMap.updateValue(newValue, forKey: "category")
        }
      }

      public var equipments: [Equipment]? {
        get {
          return resultMap["equipments"] as? [Equipment]
        }
        set {
          resultMap.updateValue(newValue, forKey: "equipments")
        }
      }
    }
  }
}

public final class GetUserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getUser {
      user(userID: "test-user-id") {
        __typename
        id
        name
      }
    }
    """

  public let operationName: String = "getUser"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("user", arguments: ["userID": "test-user-id"], type: .nonNull(.object(User.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.resultMap])
    }

    public var user: User {
      get {
        return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}

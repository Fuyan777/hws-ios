//
//  RealmManager.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/07/18.
//

import RealmSwift

final class RealmManager {
    private var realm = try! Realm(configuration: Realm.Configuration(schemaVersion: 0))

    func findAll<T: Object>(type: T.Type) -> Results<T> {
        realm.objects(type)
    }

    func count<T: Object>(type: T.Type) -> Int {
        findAll(type: type).count
    }

    func add<T: Object>(object: T) {
        try! realm.write {
            realm.add(object)
        }
    }
}

// MARK: Favorite Space

extension RealmManager {
    func findFavoriteSpace(spaceId: String) -> Bool {
        let favoriteSpaces = realm.objects(FavoriteSpace.self)
        let spaces = favoriteSpaces.filter("spaceId == %@", spaceId)
        return spaces.count != 0
    }

    func deleteFavoriteSpace(spaceId: String) {
        try! realm.write {
            let object = realm.objects(FavoriteSpace.self).filter("spaceId == %@", spaceId)
            realm.delete(object)
        }
    }
}

class FavoriteSpace: Object {
    @objc dynamic var spaceId = ""
    @objc dynamic var spaceName = ""
    @objc dynamic var spaceDescription = ""
    @objc dynamic var address = ""
    @objc dynamic var imageUrlString = ""
    @objc dynamic var longitude = 0.0
    @objc dynamic var latitude = 0.0
    @objc dynamic var area = ""
    @objc dynamic var category = ""
    var equipments = List<Equipments>()
}

class Equipments: Object {
    @objc dynamic var equipment = ""
}

// MARK: Record Items

extension RealmManager {
    func delete(recordId: String) {
        try! realm.write {
            let object = realm.objects(RecordItems.self).filter("recordId == %@", recordId)
            realm.delete(object)
        }
    }
}

class RecordItems: Object {
    @objc dynamic var recordId = ""
    @objc dynamic var startDate = Date()
    @objc dynamic var endDate = Date()
    @objc dynamic var locationName = ""
    @objc dynamic var congestionName = ""
    @objc dynamic var memo = ""
}

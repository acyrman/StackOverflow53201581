//
//  DB.swift
//  SO 49204823
//
//  Created by acyrman on 11/13/18.
//  Copyright © 2018 iCyrman. All rights reserved.
//

import Foundation

class DB {
    static var shared = DB()
 
    let data: [Song]!
    var count: Int {
        get { return data.count }
    }

    init() {
        data = [
            Song(id: 834,  name: "Alive",  fileName: "0"),
            Song(id: -666, name: "Jeremy", fileName: "1"),
            Song(id: 45,   name: "Black",  fileName: "2")]
    }
    
    func getSong(_ position: Int) -> Song? {
        guard 0...(data.count-1) ~= position else { return nil }
        return data[position]
    }
    
    func getPosition(_ song: Song) -> Int? {
        return data.firstIndex { $0 == song }
    }
}

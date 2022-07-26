//
//  Repository.swift
//  CombineSample19
//
//  Created by cmStudent on 2022/07/18.
//

import SwiftUI

    //パラメーターにはkeywordを使用して検索する
//struct Repository: Decodable, Identifiable{
//    let id: Int
//    let name: String        //店名
//    let address: String     //住所
//    let logoImage: String   //ロゴ
//}

struct Repository: Decodable{
    let name: String        //店名
    let address: String     //住所
    let logoImage: String   //ロゴ
    let access: String   // 交通アクセス
    let budget: Budget       // 予算
    let genre: Genre          // ジャンル
    let open: String         // 営業時間
    let photo: Photo
    let stationName: String  // 最寄り駅
}

struct Result: Decodable{
    var shop: [Repository]
}

struct SearchRepositoryResponse: Decodable{
    let results: Result
}

struct Photo: Decodable{
    let mobile: Mobile                 // モバイル端末向けの写真
    let pc: PC
}

struct PC: Decodable{
    let l: String       //サイズ
    let m: String
    let s: String
}

struct Mobile: Decodable{
   let l: String       //サイズ
   let s: String
}

struct Budget: Decodable{
    let name: String          // 予算
}

struct Genre: Decodable{
    let name: String          // ジャンル
}

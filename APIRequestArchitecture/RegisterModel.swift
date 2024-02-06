//
//  DataModel.swift
//  APIRequestArchitecture
//
//  Created by devang bhavsar on 02/04/22.
//

import Foundation
struct RegisterModel:Decodable {
    let userId : Int?
    let id : Int?
    let title : String?
    let body : String?
    enum CodingKeys : String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
}
struct GFMList : Decodable {
    let gFM : GFM?
    enum CodingKeys: String, CodingKey {
        case gFM = "GFM"
    }
}

struct GFM : Decodable {
    let farsan : [Farsan]?
    let sweet : [Sweet]?
    let biscuite : [Biscuite]?
    let coldDrinks : [ColdDrinks]?

    enum CodingKeys: String, CodingKey {
        case farsan = "Farsan"
        case sweet = "Sweet"
        case biscuite = "Biscuite"
        case coldDrinks = "ColdDrinks"
    }
}
struct Farsan : Decodable {
    let name : String?
    let img : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case img = "img"
    }
}

struct Sweet : Decodable {
    let name : String?
    let img : String?
    let ingredient : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case img = "img"
        case ingredient = "ingredient"
    }
}

struct Biscuite : Decodable {
    let name : String?
    let img : String?
    let ingredient : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case img = "img"
        case ingredient = "ingredient"
    }
}

struct ColdDrinks : Decodable {
    let name : String?
    let img : String?
    let ingredient : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case img = "img"
        case ingredient = "ingredient"
    }
}

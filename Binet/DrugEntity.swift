//
//  DrugEntity.swift
//  Binet
//
//  Created by Al Stark on 02.05.2023.
//

/// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let drugs = try? JSONDecoder().decode(Drugs.self, from: jsonData)

import Foundation

// MARK: - Drug
struct Drug: Codable {
    let id: Int
    let image: String
    let categories: Categories
    let name, description: String
    let documentation: String?
    let fields: [Field]
}

// MARK: - Categories
struct Categories: Codable {
    let id: Int
    let icon, image, name: String
}

// MARK: - Field
struct Field: Codable {
    let typesID: Int
    let type: TypeEnum
    let name, value: String
    let image: Image?
    let flags: Flags
    let show, group: Int

    enum CodingKeys: String, CodingKey {
        case typesID = "types_id"
        case type, name, value, image, flags, show, group
    }
}

// MARK: - Flags
struct Flags: Codable {
    let html, noValue, noName, noImage: Int
    let noWrap, noWrapName, system: Int

    enum CodingKeys: String, CodingKey {
        case html
        case noValue = "no_value"
        case noName = "no_name"
        case noImage = "no_image"
        case noWrap = "no_wrap"
        case noWrapName = "no_wrap_name"
        case system
    }
}

enum Image: String, Codable {
    case uploadContentTypes202206MaskGroup1_9F3Ed884PNG = "/upload/content/types/2022-06/Mask group (1)_9f3ed884.png"
    case uploadContentTypes202206MaskGroup2_42C7A4FdPNG = "/upload/content/types/2022-06/Mask group (2)_42c7a4fd.png"
    case uploadContentTypes202206MaskGroup3_0087Cdd2PNG = "/upload/content/types/2022-06/Mask group (3)_0087cdd2.png"
    case uploadContentTypes202206MaskGroup4879D2FcPNG = "/upload/content/types/2022-06/Mask group_4879d2fc.png"
}

enum TypeEnum: String, Codable {
    case image = "image"
    case list = "list"
    case text = "text"
}

typealias Drugs = [Drug]

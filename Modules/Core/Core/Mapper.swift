//
//  Mapper.swift
//  Core
//
//  Created by Dedi Prakasa on 1/24/21.
//

import Foundation

public protocol Mapper {
    associatedtype Responses
    associatedtype Entities
    associatedtype Domains
    
    func transformResponseToEntity(responses: Responses) -> Entities
    func transformEntityToDomain(entities: Entities) -> Domains
}

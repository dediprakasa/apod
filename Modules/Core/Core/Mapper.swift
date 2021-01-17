//
//  Mapper.swift
//  Core
//
//  Created by Dedi Prakasa on 1/15/21.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponsesToEntities(responses: Response) -> Entity
    func transformEntitiesToDomains(entities: Entity) -> Domain
}

//
//  ApodDetailError.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/8/21.
//

import Foundation

enum ApodDetailError: Error {
  case database(description: String)
  case network(description: String)
}

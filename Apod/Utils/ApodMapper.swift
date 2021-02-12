//
//  ApodMapper.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/23/20.
//

import Foundation
import Weekly
import ApodDetail

final class ApodMapper {

    static func mapWeeklyToDetail(from weekly: WeeklyDomainModel) -> ApodDetailDomainModel {
        return ApodDetailDomainModel(
            id: weekly.id ,
            apodSite: weekly.apodSite,
            copyright: weekly.copyright,
            date: weekly.date,
            itemDescription: weekly.itemDescription,
            hdurl: weekly.hdurl,
            mediaType: weekly.mediaType,
            title: weekly.title,
            url: weekly.url)
    }
}

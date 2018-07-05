//
//  Configuration.swift
//  Cloudy
//
//  Created by Bart Jacobs on 01/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import Foundation

struct Defaults {

    static let Latitude: Double = 51.400592
    static let Longitude: Double = 4.760970

}

struct API {

    static let APIKey = "403e8685baa8271f9f93e0dda2f14cbe"
    static let BaseURL = URL(string: "https://api.darksky.net/forecast/")!

    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(APIKey)
    }
    
}

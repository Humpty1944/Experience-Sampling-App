////
////  RestApi.swift
////  Sampling app
////
////  Created by Назарова on 09.04.2021.
////
//
//import Foundation
//import Siesta
//
//class RestApi{
//    
//   
//    static let sharedInstance = RestApi()
//    
//    private let service = Service(baseURL: "https://api.yelp.com/v3", standardTransformers: [.text, .image])
//
//    private init() {
//      
//        SiestaLog.Category.enabled = [.network, .pipeline, .observers]
//
//      service.configure("**") {
//        $0.headers["Authorization"] =
//        "Bearer B6sOjKGis75zALWPa7d2dNiNzIefNbLGGoF75oANINOL80AUhB1DjzmaNzbpzF-b55X-nG2RUgSylwcr_UYZdAQNvimDsFqkkhmvzk6P8Qj0yXOQXmMWgTD_G7ksWnYx"
//        $0.expirationTime = 60 * 60
//      }
//
//      let jsonDecoder = JSONDecoder()
//
//      service.configureTransformer("/businesses/*") {
//        try jsonDecoder.decode(RestaurantDetails.self, from: $0.content)
//      }
//
//      service.configureTransformer("/businesses/search") {
//        try jsonDecoder.decode(SearchResults<Restaurant>.self, from: $0.content).businesses
//      }
//    }
//
//    func restaurantList(for location: String) -> Resource {
//      return service
//        .resource("/businesses/search")
//        .withParam("term", "pizza")
//        .withParam("location", location)
//    }
//
//    func restaurantDetails(_ id: String) -> Resource {
//      return service
//        .resource("/businesses")
//        .child(id)
//    }
//  }
//}

//
//  RestApi.swift
//  Sampling app
//
//  Created by Назарова on 09.04.2021.
//

import Foundation
import Siesta

class RestApi{
    
   
    static let sharedInstance = RestApi()
    
    private let service = Service(baseURL: "https://45.67.230.70:5001/api", standardTransformers: [.text, .image])

    var authHeader: String? {
            didSet {
                // Clear any cached data now that auth has changed
                //wipeResources()

                // Force resources to recompute headers next time they’re fetched
               // invalidateConfiguration()
            }
        }
    
    
    private init() {
      
        SiestaLog.Category.enabled = [.network, .pipeline, .observers]

      service.configure("**") {
        $0.headers["Authorization"] = self.authHeader 
//        $0.headers["Authorization"] =
//        "Bearer B6sOjKGis75zALWPa7d2dNiNzIefNbLGGoF75oANINOL80AUhB1DjzmaNzbpzF-b55X-nG2RUgSylwcr_UYZdAQNvimDsFqkkhmvzk6P8Qj0yXOQXmMWgTD_G7ksWnYx"
        $0.expirationTime = 60 * 60
      }

      let jsonDecoder = JSONDecoder()

//      service.configureTransformer("/businesses/*") {
//        try jsonDecoder.decode(RestaurantDetails.self, from: $0.content)
//      }
//
//      service.configureTransformer("/businesses/search") {
//        try jsonDecoder.decode(SearchResults<Restaurant>.self, from: $0.content).businesses
//      }
    }

    func participantAuthLogin(id_index: String) -> Resource {
        return service.resource("ParticipantAuth/Login").withParam("id", id_index)
//        //return
////      return service
////        .resource("ParticipantAuth")
////        .withParam("Login", id_num)
//
   }
    
    func participantAuthLogout()->Resource{
        return service.resource("ParticipantAuth/Logout")
    }
    
    func participantGetQuestions()->Resource{
        return service.resource("ParticipantAuth/GetQuestions")
    }
    
    func participantSendAnswer()->Resource{
        return service.resource("Participant/SendAnswer")
    }

//    func restaurantDetails(_ id: String) -> Resource {
//      return service
//        .resource("/businesses")
//        .child(id)
//    }
  }


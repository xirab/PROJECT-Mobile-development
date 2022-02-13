//
//  Model.swift
//  MyEvent
//
//  Created by goldorak on 07/02/2022.
//

import Foundation
import UIKit

struct Records: Codable {
    let records: [Schedule]?
}
struct Schedule--: Codable {
    let id: String
    let fields: Fields
}
struct Fields: Codable {
    let activity: String
    let type: String
    let start: String
    let end: String
    let notes: String?
    let location: [String]
    let speaker: [String]?
    let topic: [String]?
    enum CodingKeys: String, CodingKey {
        case activity = "Activity"
        case type = "Type"
        case start = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        case end = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        case notes = "Notes"
        case location = ["Location"]
        case speaker = ["Speaker"]
        case topic = ["Topic"]
    }
}
struct Response: Codable {
    let id: String
    let deleted: Bool
}
struct ErrorResponse: Codable {
    let error: String
}
enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
enum CustomError: Error {
    case requestError
    case statusCodeError
    case parsingError
}

// Request Factory
protocol RequestFactoryProtocol {
    func createRequest(urlStr: String, requestType: RequestType, params:
[String]?) -> URLRequest
    func getScheduleList(callback: @escaping ((errorType: CustomError?,
     errorMessage: String?), [Schedule]?) -> Void)
}
private let furnitureUrlStr = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule"

class RequestFactory: RequestFactoryProtocol {
    internal func createRequest(urlStr: String, requestType: RequestType,
     params: [String]?) -> URLRequest {
        var url: URL = URL(string: urlStr)!
        if let params = params {
            var urlParams = urlStr
            for param in params {
                urlParams = urlParams + "/" + param
            }
            print(urlParams)
            url = URL(string: urlParams)!
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 100
        request.httpMethod = requestType.rawValue
        let accessToken = "keyizYAq1t1hCQ34"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField:
         "Authorization")
        return request
}
    func getFurnitureList(callback: @escaping ((errorType: CustomError?,
     errorMessage: String?), [Schedule]?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr:
furnitureUrlStr,
if let data = data, error == nil {
    if let responseHttp = response as? HTTPURLResponse {
        if responseHttp.statusCode == 200 {
            if let response = try?
             JSONDecoder().decode(Records.self, from: data) {
                callback((nil, nil), response.records)
}
else {
                callback((CustomError.parsingError, "parsing
                 error"), nil)
} }
     requestType: .get,
     params: nil)) {
(data, response, error)
in

else {
                    callback((CustomError.statusCodeError, "status
                     code: \(responseHttp.statusCode)"), nil)
                }
} }
        else {
            callback((CustomError.requestError,
             error.debugDescription), nil)
        }
}
    task.resume()
}


import Foundation

struct Records: Codable{
    let records: [Schedule]?
}
struct Schedule: Codable, Identifiable{
    let id: String
    let fields: Fields
}
struct Fields: Codable {
    let activity: String
    /*let type: String
    let start: String
    let end: String
    let notes: String?
    let location: [String]
    let speaker: [String]?
    let topic: [String]?*/
    enum CodingKeys: String, CodingKey{
        case activity = "Activity"
        /*case type = "Type"
        case start = "2019-11-15T08:00:00.000Z"
        case end = "2019-11-15T09:00:00.000Z":
        case notes = "Notes"
        case location = "Location"
        case speaker = "Speaker"
        case topic = "Topic"*/
    }
}
struct Response: Codable{
    let id: String
    let deleted: Bool
}
struct ErrorResponse: Codable{
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
protocol RequestFactoryProtocol {
    func createRequest(urlStr: String, requestType: RequestType, params:[String]?) -> URLRequest
    func getScheduleList(callback: @escaping ((errorType: CustomError?, errorMessage: String?), [Schedule]?) -> Void)
}
//private let scheduleUrlStr = https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule

class RequestFactory: RequestFactoryProtocol {
    
    internal func createRequest() -> URLRequest {
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
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func getScheduleList(callback: @escaping ((errorType: CustomError?, errorMessage: String?), [Schedule]?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr: scheduleUrlStr, requestType: RequestType.get, params:nil)){ (data, response, error) in
            if let data = data, error == nil {
                if let responseHttp = response as? HTTPURLResponse {
                    //if responseHttp.statusCode == 200 {
                        if let response = try? JSONDecoder().decode(Records.self, from: data) {
                            callback(true, response.records)
                        }
                        else {
                            callback((CustomError.parsingError, "parsing error"), nil)
                        }
                    //}
                    /*else {
                        callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                    }*/
                }
            }
            else {
                callback((CustomError.requestError, error.debugDescription), nil)
            }
        }
        task.resume()
    }
}

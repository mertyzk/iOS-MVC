import UIKit
import StoreKit
import Foundation

let session = URLSession.shared
let defaultFileManager = FileManager.default
let userDefaults = UserDefaults.standard
let defaultPaymentQueue = SKPaymentQueue.default()



class Data {
    var number : Int = 4
    static let share : Data = Data()
    private init(){
        
    }
}

let d1 = Data.share
d1.number = 10

let d2 = Data.share
d2.number = 99
print(d1.number)
print(d2.number)

// d1 ve d2 99 yazar. cunku ikisi de aynı nesneyi kullaniyor.


typealias VeriTamamlamaBlok = (Data?) -> Void

protocol Oturum {
    func make(request: URLRequest, completionHandler: @escaping VeriTamamlamaBlok)
}

extension URLSession : Oturum{
    func make(request: URLRequest, completionHandler: @escaping VeriTamamlamaBlok) {
        let task = self.dataTask(with: request) { data, _, _ in
            completionHandler(data)
        }
        task.resume()
    }
}

class ApiService{
    var session : Oturum
    init(session : Oturum = URLSession.shared){
        self.session = session
    }
    
    func load(_ request : URLRequest, completionHandler : @escaping VeriTamamlamaBlok){
        self.session.make(request: request, completionHandler: completionHandler)
    }
}

class BenimOturumum : Oturum{
    func make(request: URLRequest, completionHandler: @escaping VeriTamamlamaBlok) {
        var msg = "Message"
        completionHandler(msg.data(using: .utf8))
    }
}

func test() {
    let api = ApiService(session: BenimOturumum())
    let request = URLRequest(url: URL(string: "http://www.udemy.com")!)
    api.load(request) { data in
        print(String(data: data!, encoding: String.Encoding.utf8))
    }
}


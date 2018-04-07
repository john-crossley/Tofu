//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

fileprivate let paramsKey = "io.jonnothebonno"

public func queryString(req: IncomingMessage, res: ServerResponse, next: @escaping Next) {
    // use Foundation to parse the `?a=x`
    if let items = URLComponents(string: req.header.uri)?.queryItems {
        req.userInfo[paramsKey] = Dictionary(grouping: items, by: { $0.name })
            .mapValues { $0.compactMap({ $0.value })
            .joined(separator: ",") }
    }

    next()
}

public extension IncomingMessage {
    func param(_ id: String) -> String? {
        print("[NORI] \(userInfo)")
        return (userInfo[paramsKey] as? [ String : String ])?[id]
    }
}

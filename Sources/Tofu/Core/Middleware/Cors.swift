//
//  Copyright © 2018 John Crossley. All rights reserved.
//

public func cors(allowOrigin origin: String) -> Middleware {
    return { req, res, next in
        res["Access-Control-Allow-Origin"] = origin
        res["Access-Control-Allow-Headers"] = "Accept, Content-Type"
        res["Access-Control-Allow-Methods"] = "GET, OPTIONS"

        if req.header.method == .OPTIONS {
            res["Allow"] = "GET, OPTIONS"
            res.send("")
        } else {
            next()
        }
    }
}

//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1

let app = Nori()

app.use { (req, res, next) in
    print("[NORI] \(req.header.method):", req.header.uri)
    next()
}

app.get("/") { req, res, _ in
    let name = req.param("name") ?? "John Crossley"
    res.send("Hello \(name), I have completed the request.")
}

app.listen(1337)

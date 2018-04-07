//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1

let app = Nori()

// Logging
app.use { (req, res, next) in
    print("[NORI] \(req.header.method):", req.header.uri)
    next()
}

app.get("/") { _, res, _ in
    res.send("Hey, you little fuggle face!")
}

app.listen(1337)

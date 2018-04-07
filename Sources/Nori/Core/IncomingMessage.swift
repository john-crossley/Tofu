//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import NIOHTTP1

open class IncomingMessage {
    public let header: HTTPRequestHead
    public var userInfo = [String: Any]()

    init(header: HTTPRequestHead) {
        self.header = header
    }
}

//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

public extension ServerResponse {
    public subscript(name: String) -> String? {
        set {
            assert(!didWriteHeader, "header is out")
            if let value = newValue {
                headers.replaceOrAdd(name: name, value: value)
            } else {
                headers.remove(name: name)
            }
        }

        get {
            return headers[name].joined(separator: ", ")
        }
    }
}

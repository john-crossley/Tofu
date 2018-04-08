//
//  Copyright © 2018 John Crossley. All rights reserved.
//

public typealias Next = (Any...) -> Void

public typealias Middleware = ( IncomingMessage, ServerResponse, @escaping Next ) -> Void

//
//  Copyright © 2018 John Crossley. All rights reserved.
//

open class Router {
    private var middleware = [Middleware]()

    open func use(_ middleware: Middleware...) {
        self.middleware.append(contentsOf: middleware)
    }

    func handle(request: IncomingMessage, response: ServerResponse, next upperNext: @escaping Next) {
        let stack = self.middleware
        guard !stack.isEmpty else { return upperNext() }

        var next: Next? = { (args: Any...) in }
        var index = stack.startIndex
        next = { (args: Any...) in
            // grab next item from matching middleware array
            let middleware = stack[index]
            index = stack.index(after: index)

            let isLast = index == stack.endIndex
            middleware(request, response, isLast ? upperNext : next!)
        }

        next!()
    }
}

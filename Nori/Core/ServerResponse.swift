//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1

open class ServerResponse {
    public var status: HTTPResponseStatus = .ok
    public var headers = HTTPHeaders()
    public let channel: Channel
    public var didWriteHeader = false
    public var didEnd = false

    public init(channel: Channel) {
        self.channel = channel
    }

    open func send(_ s: String) {
        flushHeader()

        let utf8 = s.utf8
        var buffer = channel.allocator.buffer(capacity: utf8.count)
        buffer.write(bytes: utf8)

        let part = HTTPServerResponsePart.body(.byteBuffer(buffer))
        _ = channel.writeAndFlush(part)
                .mapIfError(handleError)
                .map { self.end() }
    }

    private func flushHeader() {
        guard !didWriteHeader else { return }
        didWriteHeader = true

        let head = HTTPResponseHead(version: .init(major: 1, minor: 1), status: status, headers: headers)
        let part = HTTPServerResponsePart.head(head)
        _ = channel.writeAndFlush(part).mapIfError(handleError)
    }

    private func handleError(_ error: Error) {
        print("[NORI] ServerResponse error: ", error)
        end()
    }

    private func end() {
        guard !didEnd else { return }
        didEnd = true
        _ = channel.writeAndFlush(HTTPServerResponsePart.end(nil))
            .map { self.channel.close() }
    }
}

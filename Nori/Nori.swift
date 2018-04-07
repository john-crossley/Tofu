//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1

open class Nori {

    final class HttpHandler: ChannelInboundHandler {
        typealias InboundIn = HTTPServerRequestPart

        func channelRead(ctx: ChannelHandlerContext, data: NIOAny) {
            let reqPart = unwrapInboundIn(data)

            switch reqPart {
            case .head(let header):

                let head = HTTPResponseHead(version: header.version, status: .ok)
                let part = HTTPServerResponsePart.head(head)
                _ = ctx.channel.write(part)

                var buffer = ctx.channel.allocator.buffer(capacity: 42)
                buffer.write(string: "Hello, World!")
                let bodypart = HTTPServerResponsePart.body(.byteBuffer(buffer))
                _ = ctx.channel.write(bodypart)

                let endpart = HTTPServerResponsePart.end(nil)
                _ = ctx.channel.writeAndFlush(endpart).then {
                    ctx.channel.close()
                }

            case .body, .end: break
            }
        }
    }

    // Create a multithread event loop, think of this as dispatchQueue.
    // This handles IO events.. (DispatchQueue.async)
    let loopGroup = MultiThreadedEventLoopGroup(numThreads: System.coreCount)

    open func listen(_ port: Int) {
        let reuseAddrOpt = ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR)

        // Setup the "Server Channel"
        let bootstrap = ServerBootstrap(group: loopGroup)
            .serverChannelOption(ChannelOptions.backlog, value: 256)
            .serverChannelOption(reuseAddrOpt, value: 1)

            .childChannelInitializer { channel in
                channel.pipeline.configureHTTPServerPipeline().then {
                    channel.pipeline.add(handler: HttpHandler())
                }
            }

        .childChannelOption(ChannelOptions.socket(IPPROTO_TCP, TCP_NODELAY), value: 1)
        .childChannelOption(reuseAddrOpt, value: 1)
        .childChannelOption(ChannelOptions.maxMessagesPerRead, value: 1)

        do {
            let serverChannel = try bootstrap.bind(host: "localhost", port: port).wait()
            print("[NORI] Server running on: ", serverChannel.localAddress!)
            try serverChannel.closeFuture.wait()
        } catch {
            fatalError("[NORI] Failed to start server: \(error)")
        }
    }
}

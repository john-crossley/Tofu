//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1

open class Nori: Router {

    final class HttpHandler: ChannelInboundHandler {
        typealias InboundIn = HTTPServerRequestPart

        let router: Router

        init(router: Router) {
            self.router = router
        }

        func channelRead(ctx: ChannelHandlerContext, data: NIOAny) {
            let reqPart = unwrapInboundIn(data)

            switch reqPart {
            case .head(let header):
                let req = IncomingMessage(header: header)
                let res = ServerResponse(channel: ctx.channel)

                router.handle(request: req, response: res) { (items: Any...) in
                    res.status = .notFound
                    res.send("[NORI] No middleware handled the request!")
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
                    channel.pipeline.add(handler: HttpHandler(router: self))
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

//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
import NIO

public enum FS {
//    static let threadPool: BlockingIOThreadPool = {
//        let pool = BlockingIOThreadPool(numberOfThreads: 4)
//        pool.start()
//        return pool
//    }()
//
//    static let fileIO = NonBlockingFileIO(threadPool: threadPool)

//    public static func read(_ path: String,
//                            eventLoop: EventLoop? = nil,
//                            maxSize: Int = 1024 * 1024,
//                            _ cb: @escaping (Error?, ByteBuffer?) -> ()) {


    public static func read(_ path: URL,
                            _ cb: @escaping (Error?, Data?) -> ()) {

        DispatchQueue.global().async {
            do {
                cb(nil, try Data(contentsOf: path))
            } catch {
                cb(error, nil)
            }
        }

//        let eventLoop = eventLoop ?? MultiThreadedEventLoopGroup.currentEventLoop ?? eventLoop!.next()
//
//        func emit(error: Error? = nil, result: ByteBuffer? = nil) {
//            if eventLoop.inEventLoop {
//                cb(error, result)
//            } else {
//                eventLoop.execute { cb(error, result) }
//            }
//        }
//
//        threadPool.submit {
//            assert($0 == .active, "Unhandled cancellation")
//
//            let handler: NIO.FileHandle
//            do { // blocking
//                handler = try NIO.FileHandle(path: path)
//            } catch {
//                return emit(error: error)
//            }
//
//            fileIO.read(fileHandle: handler, byteCount: maxSize, allocator: ByteBufferAllocator(), eventLoop: eventLoop)
//                .map { try? handler.close(); emit(result: $0) }
//                .whenFailure { try? handler.close(); emit(error: $0) }
//        }
    }
}

# Nori (海苔)

A small lightweight HTTP client built using [SwiftNIO](https://github.com/apple/swift-nio).

This is a slight adaptation of this awesome tutorial on how to build a
web framework using SwiftNIO

[http://www.alwaysrightinstitute.com/microexpress-nio/](http://www.alwaysrightinstitute.com/microexpress-nio/)

```swift
let app = Nori()

// Logging
app.use { (req, res, next) in
    print("[NORI] \(req.header.method):", req.header.uri)
    next()
}

app.get("/") { _, res, _ in
    res.send("Hey, you little fuggle face!")
}

app.get("/queryparams") { req, res, _ in
    let name = req.param("name") ?? "John Crossley"
    res.send("Hello \(name), I have completed the request.")
}

app.listen(1337)
```

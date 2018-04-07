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

// Return an array of models represented as JSON array.
app.get("/food") { (_, res, _) in
    let itemsOfFood = [
        Food(id: 0, name: "Nori", description: "Nori (海苔) is the Japanese name for edible seaweed species of the red algae genus Pyropia"),
        Food(id: 1, name: "Gyoza", description: "Gyoza, are popular weeknight meal as well as a great appetizer for your next dinner party."),
        Food(id: 2, name: "Ramen", description: "Ramen is a Japanese dish. It consists of Chinese-style wheat noodles served in a veggie broth, often flavored with soy sauce or miso.")
    ]

    res.json(itemsOfFood)
}

app.listen(1337)
```

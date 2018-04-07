// swift-tools-version:4.0
//
//  Package.swift
//  Nori
//
//  Created by John Crossley on 07/04/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//
import PackageDescription

let package = Package(
    name: "Nori",

    dependencies: [
        /* Add your package dependencies in here
        .package(url: "https://github.com/AlwaysRightInstitute/cows.git",
                 from: "1.0.0"),
        */
        .package(url: "https://github.com/apple/swift-nio.git", 
                 from: "1.3.1"),
        .package(url: "https://github.com/apple/swift-nio-ssl.git", 
                 from: "1.0.0"),
    ],

    targets: [
        .target(name: "Nori", 
                dependencies: [
                  /* Add your target dependencies in here, e.g.: */
                  // "cows",
                  "NIO",
                  "NIOHTTP1",
                  "NIOOpenSSL",
                ])
    ]
)

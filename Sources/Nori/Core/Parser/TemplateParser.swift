//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class TemplateParser {

    typealias BuilderClosure = (TemplateParser) -> Void

    var template: String = ""
    var replacements: [String: String] = [:]

    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }

    func build() -> String {
        replacements.forEach { (key, value) in replace(key, with: value) }
        return template
    }

    private func replace(_ key: String, with value: String) {
        template = template.replacingOccurrences(of: "{{\(key)}}", with: value)
    }
}

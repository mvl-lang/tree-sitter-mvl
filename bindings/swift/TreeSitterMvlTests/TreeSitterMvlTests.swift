import XCTest
import SwiftTreeSitter
import TreeSitterMvl

final class TreeSitterMvlTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_mvl())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Mvl grammar")
    }
}

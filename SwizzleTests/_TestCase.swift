//
//  _TestCase.swift
//  SwizzleTests
//
//  Created by Yasuhiro Inami on 2014/09/14.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import XCTest

class _TestCase: XCTestCase {
    override func setUp() {
        super.setUp()
        print("\n\n\n")
    }

    override func tearDown() {
        print("\n\n\n")
        super.tearDown()
    }
}

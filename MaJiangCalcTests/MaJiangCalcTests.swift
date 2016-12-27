//
//  MaJiangCalcTests.swift
//  MaJiangCalcTests
//
//  Created by Meng Huang on 11/29/16.
//  Copyright © 2016 Meng Huang. All rights reserved.
//

import XCTest
@testable import MaJiangCalc

class MaJiangCalcTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testMaJiangGroupSetRequirement() {
    let group = MaJiangGroup()
    group.setRequirement(["对子"], 2)
    XCTAssert(group.types == ["对子"])
    XCTAssert(group.capacity == 2)
    
    group.setRequirement(["杠子"], 4)
    XCTAssert(group.types == ["杠子"])
    XCTAssert(group.capacity == 4)
    
    group.setRequirement(["顺子"], 3)
    XCTAssert(group.types == ["顺子"])
    XCTAssert(group.capacity == 3)
  }
  
  func testMaJiangGroupUpdateStatus() {
    let group = MaJiangGroup()
    
    // 没有牌 - 成功
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "空")
    
    // 一张牌 - 成功
    group.members = ["幺鸡"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "幺鸡")
    
    group.members = ["九萬"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "九萬")
    
    // 检测不靠 - 成功
    group.members = ["二饼", "五饼", "八饼"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "不靠")
    
    group.members = ["四饼", "七饼"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "不靠")
    
    group.members = ["三饼", "九饼"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "不靠")
    
    // 两张牌
    // 搭子 - 成功
    group.members = ["二饼", "三饼"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "搭子")
    
    // 搭子 - 成功
    group.members = ["一饼", "三饼"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "搭子")
    
    // 对子 - 成功
    group.members = ["發財", "發財"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "对子")
    
    // 失败
    group.members = ["五饼", "九饼"]
    XCTAssert(group.updateStatus() == false)
    XCTAssert(group.status == nil)
    
    group.members = ["一饼", "六饼"]
    XCTAssert(group.updateStatus() == false)
    XCTAssert(group.status == nil)
    
    group.members = ["九条", "一饼"]
    XCTAssert(group.updateStatus() == false)
    XCTAssert(group.status == nil)
    
    group.members = ["红中", "白板"]
    XCTAssert(group.updateStatus() == false)
    XCTAssert(group.status == nil)
    
    // 三张牌
    // 顺子 - 成功
    group.members = ["一饼", "二饼", "三饼"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "顺子")
    
    // 刻子 - 成功
    group.members = ["五饼", "五饼", "五饼"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "刻子")
    
    // 四张牌
    // 杠子 - 成功
    group.members = ["三条", "三条", "三条", "三条"]
    XCTAssert(group.updateStatus() == true)
    XCTAssert(group.status == "杠子")
    
    // 失败
    group.members = ["三条", "三条", "四条"]
    XCTAssert(group.updateStatus() == false)
    XCTAssert(group.status == nil)
    
    group.members = ["三条", "五条", "六条"]
    XCTAssert(group.updateStatus() == false)
    XCTAssert(group.status == nil)
    
    group.members = ["四条", "四条", "白板"]
    XCTAssert(group.updateStatus() == false)
    XCTAssert(group.status == nil)
    
    group.members = ["二条", "三条", "三条", "三条"]
    XCTAssert(group.updateStatus() == false)
    XCTAssert(group.status == nil)
    
    group.members = ["三条", "三条", "四条", "四条"]
    XCTAssert(group.updateStatus() == false)
    XCTAssert(group.status == nil)
  }
  
  func testMaJiangGroupCheckType() {
    let group = MaJiangGroup()
    group.setRequirement(["对子"], 2)
    
  }
  
  
  func testMaJiangGroupPushAndPop() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    let group = MaJiangGroup()
    XCTAssert(group.push(majiang: "一萬") == true)
    XCTAssert(group.push(majiang: "四萬") == true)
    XCTAssert(group.push(majiang: "七萬") == true)
    XCTAssert(group.push(majiang: "白板") == false)
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}

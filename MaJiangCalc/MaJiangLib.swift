//
//  MaJiangLib.swift
//  MaJiangCalculator
//
//  Created by Meng Huang on 11/9/16.
//  Copyright © 2016 Meng Huang. All rights reserved.
//

import Foundation

let MAX: Int = 255

class MaJiangType {
  var nextTypes : String? = nil
  var capacity : Int = 0
  
  init(_ cap: Int, _ next: String?) {
    self.nextTypes = next
    self.capacity = cap
  }
}

class MaJiangInfo {
  var number: Int = 0
  var isGreen: Bool = false
  var isSym: Bool = false
  var isYao: Bool = false
  
  init(number: Int, is_green: Bool, is_sym: Bool, is_yao: Bool) {
    self.number = number
    self.isGreen = is_green
    self.isSym = is_sym
    self.isYao = is_yao
  }
}

let MaJiangDict = [
  "幺鸡" : MaJiangInfo(number: 1, is_green: false, is_sym: false, is_yao: true),
  "二条" : MaJiangInfo(number: 2, is_green: true, is_sym: true, is_yao: false),
  "三条" : MaJiangInfo(number: 3, is_green: true, is_sym: false, is_yao: false),
  "四条" : MaJiangInfo(number: 4, is_green: true, is_sym: true, is_yao: false),
  "五条" : MaJiangInfo(number: 5, is_green: false, is_sym: true, is_yao: false),
  "六条" : MaJiangInfo(number: 6, is_green: true, is_sym: true, is_yao: false),
  "七条" : MaJiangInfo(number: 7, is_green: false, is_sym: false, is_yao: false),
  "八条" : MaJiangInfo(number: 8, is_green: true, is_sym: true, is_yao: false),
  "九条" : MaJiangInfo(number: 9, is_green: false, is_sym: true, is_yao: true),
  
  "一饼" : MaJiangInfo(number: 21, is_green: false, is_sym: true, is_yao: true),
  "二饼" : MaJiangInfo(number: 22, is_green: false, is_sym: true, is_yao: false),
  "三饼" : MaJiangInfo(number: 23, is_green: false, is_sym: true, is_yao: false),
  "四饼" : MaJiangInfo(number: 24, is_green: false, is_sym: true, is_yao: false),
  "五饼" : MaJiangInfo(number: 25, is_green: false, is_sym: true, is_yao: false),
  "六饼" : MaJiangInfo(number: 26, is_green: false, is_sym: false, is_yao: false),
  "七饼" : MaJiangInfo(number: 27, is_green: false, is_sym: false, is_yao: false),
  "八饼" : MaJiangInfo(number: 28, is_green: false, is_sym: true, is_yao: false),
  "九饼" : MaJiangInfo(number: 29, is_green: false, is_sym: true, is_yao: true),
  
  "一萬" : MaJiangInfo(number: 41, is_green: false, is_sym: false, is_yao: true),
  "二萬" : MaJiangInfo(number: 42, is_green: false, is_sym: false, is_yao: false),
  "三萬" : MaJiangInfo(number: 43, is_green: false, is_sym: false, is_yao: false),
  "四萬" : MaJiangInfo(number: 44, is_green: false, is_sym: false, is_yao: false),
  "五萬" : MaJiangInfo(number: 45, is_green: false, is_sym: false, is_yao: false),
  "六萬" : MaJiangInfo(number: 46, is_green: false, is_sym: false, is_yao: false),
  "七萬" : MaJiangInfo(number: 47, is_green: false, is_sym: false, is_yao: false),
  "八萬" : MaJiangInfo(number: 48, is_green: false, is_sym: false, is_yao: false),
  "九萬" : MaJiangInfo(number: 49, is_green: false, is_sym: false, is_yao: true),
  
  "東風" : MaJiangInfo(number: 60, is_green: false, is_sym: false, is_yao: true),
  "南風" : MaJiangInfo(number: 63, is_green: false, is_sym: false, is_yao: true),
  "西風" : MaJiangInfo(number: 66, is_green: false, is_sym: false, is_yao: true),
  "北風" : MaJiangInfo(number: 69, is_green: false, is_sym: false, is_yao: true),
  
  "红中" : MaJiangInfo(number: 72, is_green: false, is_sym: false, is_yao: true),
  "發財" : MaJiangInfo(number: 75, is_green: true, is_sym: false, is_yao: true),
  "白板" : MaJiangInfo(number: 78, is_green: false, is_sym: true, is_yao: true),
]

class MaJiangGroup {
  var members: [String] = []
  var isRevealed: Bool = false
  var status: String? = nil
  var types: [Int:[String]] = [:]
  var targetVols: [Int] = []
  var capacity: Int = 0
  
  var memory: [String]? = nil
  
  init() {
  }
  
  func reset() {
    self.members = []
    self.isRevealed = false
    self.status = nil
    self.types = [:]
    self.targetVols = []
    self.capacity = 0
    self.memory = nil
  }
  
  func setRequirement(_ requirement: [Int:[String]], _ targets: [Int]) {
    self.types = requirement
    self.targetVols = targets
    self.capacity = targets.max()!
  }
  
  func updateStatus() -> Bool{
    // 当少于两张麻将牌
    if self.members.count == 0 {
      self.status = "空"
      return true
    }
    
    if self.members.count == 1 {
      self.status = self.members[0]
      return true
    }
    
    // 检测不靠
    var flag: Bool = true
    if MaJiangDict[self.members[self.members.count-1]]!.number < 50 {
      for i in 0 ..< self.members.count-1 {
        if MaJiangDict[self.members[i+1]]!.number - MaJiangDict[self.members[i]]!.number != 3
          && MaJiangDict[self.members[i+1]]!.number - MaJiangDict[self.members[i]]!.number != 6
        {
          flag = false
          break
        }
      }
    }
    else {
      flag = false
    }
    
    //    else if MaJiangDict[self.members[0]]!.number > 50 {
    //      for i in 0 ..< self.members.count-1 {
    //        if MaJiangDict[self.members[i+1]]!.number <= MaJiangDict[self.members[i]]!.number
    //        {
    //          flag = false
    //          break
    //        }
    //      }
    //    }
    
    if flag == true {
      self.status = "不靠"
      return true
    }
    
    // 当有两张麻将牌
    if self.members.count == 2 {
      let temp1 = MaJiangDict[self.members[0]]!.number
      let temp2 = MaJiangDict[self.members[1]]!.number
      
      // 检测对子
      if temp1 == temp2 {
        self.status = "对子"
        return true
      }
      
      // 检测搭子
      if temp2 - temp1 < 3 {
        self.status = "搭子"
        return true
      }
      
      self.status = nil
      return false
    }
    
    // 当有三张麻将牌
    if self.members.count == 3 {
      let temp1 = MaJiangDict[self.members[0]]!.number
      let temp2 = MaJiangDict[self.members[1]]!.number
      let temp3 = MaJiangDict[self.members[2]]!.number
      
      // 检测刻子
      if temp1 == temp2 && temp2 == temp3 {
        self.status = "刻子"
        return true
      }
      
      // 检测顺子
      if temp2 - temp1 == 1 && temp3 - temp2 == 1 {
        self.status = "顺子"
        return true
      }
      
      self.status = nil
      return false
    }
    
    // 当有四张麻将牌
    if self.members.count == 4 {
      let temp1 = MaJiangDict[self.members[0]]!.number
      let temp2 = MaJiangDict[self.members[1]]!.number
      let temp3 = MaJiangDict[self.members[2]]!.number
      let temp4 = MaJiangDict[self.members[3]]!.number
      
      // 检测杠子
      if temp1 == temp2 && temp2 == temp3 && temp3 == temp4 {
        self.status = "杠子"
        return true
      }
      
      self.status = nil
      return false
    }
    
    self.status = nil
    return false
  }
  
  func checkType() -> Bool {
    if self.types.isEmpty == true {
      return true
    }
    
    
    
    return true
  }
  
  /*
   ** 要求按照麻将对应编号从小到大依次调用这个函数
   **/
  func push(majiang: String) -> Bool {
    if self.capacity <= self.members.count {
      return false
    }
    self.members.append(majiang)
    let flag = self.updateStatus()
    if flag == false {            // 添加失败
      self.pop()
      return false
    }
    
    return true
  }
  
  func pop() {
    if self.members.count > 0 {
      self.members.removeLast()
      self.updateStatus()
    }
  }
  
  func tryPush(majiang: String) -> Bool {
    if self.memory != nil {
      return false
    }
    
    self.memory = self.members
    
    if self.capacity <= self.members.count {
      return false
    }
    self.members.append(majiang)
    self.members.sort(by: { (MaJiangDict[$0]?.number)! < (MaJiangDict[$1]?.number)! })
    let flag = self.updateStatus()
    if flag == false {            // 添加失败
      tryPop()
      return false
    }
    
    return true
  }
  
  func tryPop() {
    if self.memory == nil {
      return
    }
    
    self.members = self.memory!
    self.memory = nil
  }
  
  func recover() {
    if self.memory != nil {
      self.members = self.memory!
      self.updateStatus()
      self.memory = nil
    }
  }
}

class MaJiangHand {
  var revealed: [[String]] = []
  var grouped: [[String]] = []
  var unrevealed: [String] = []
  
  var finalGroups : [MaJiangGroup] = []
  
  init() {
    
  }
  
  func set(revealed: [[String]], grouped: [[String]], unrevealed: [String]) {
    self.revealed = revealed
    self.unrevealed = unrevealed
    self.grouped = grouped
  }
  
  // 检查牌数是否能够和牌(0表示牌数正好，大于0表示“大相公”，小于0表示”小相公“)
  func isXiangGong() -> Int {
    let temp = self.revealed.count * 3 + self.grouped.count * 3 + self.unrevealed.count
    return temp - 13
  }
  
  func isReavealedValid() -> Bool {
    for group in self.revealed {
      let temp_group = MaJiangGroup()
      for majiang in group {
        if temp_group.push(majiang: majiang) == false {
          return false
        }
      }
    }
    return true
  }
  
  func isGroupedValid() -> Bool {
    for group in self.grouped {
      let temp_group = MaJiangGroup()
      for majiang in group {
        if temp_group.push(majiang: majiang) == false {
          return false
        }
      }
      if temp_group.status != "杠子" {
        return false
      }
    }
    return true
  }
  
  class MaJiangReport {
    var details: [String:Int] = [:]
    
    func getScore() -> Int {
      var result = 0
      for value in details.values {
        result += value
      }
      return result
    }
  }
  
  func analyze(groups: [MaJiangGroup]) -> [String:MaJiangReport] {
    return [:]
  }
  
  func report_helper(groups: inout [MaJiangGroup], cur_index: Int, possibles: inout [String: MaJiangReport]) {
    if cur_index == self.unrevealed.count {
      let cur_possibles: [String:MaJiangReport] = self.analyze(groups: groups)
      for (key, value) in cur_possibles {
        possibles[key] = value
      }
      return
    }
    
    for i in 0 ..< groups.count {
      if groups[i].push(majiang: self.unrevealed[cur_index]) == true {
        self.report_helper(groups: &groups, cur_index: cur_index+1, possibles: &possibles)
        groups[i].pop()
        if groups[i].members.count == 0 {
          break
        }
      }
    }
  }
  
  func report() -> (isTingPai: Bool, possibles: [String: MaJiangReport]?) {
    var groups : [MaJiangGroup] = []
    var possibles : [String:MaJiangReport] = [:]
    var num_unrevealed_group = 5
    
    // 检查是否相公
    if isXiangGong() != 0 {
      return (false, nil)
    }
    
    for temp in self.revealed {
      let new_group : MaJiangGroup = MaJiangGroup()
    }
    
    // 检查暗杠是否合理
    for temp in self.grouped {
      let new_group : MaJiangGroup = MaJiangGroup()
      new_group.setRequirement([4:["杠子"]], 4)
      new_group.isRevealed = false
      for majiang in temp {
        if new_group.push(majiang: majiang) == false {
          return (false, nil)
        }
      }
      if new_group.checkType() == false {
        return (false, nil)
      }
      self.finalGroups.append(new_group)
      num_unrevealed_group -= 1
    }
    
    // 普通和牌: 3 + 3 + 3 + 3 + 2
    for _ in 1 ... num_unrevealed_group {
      let new_group = MaJiangGroup()
      new_group.setRequirement(["顺子", "刻子", "杠子", "不靠"], 4)
      groups.append(new_group)
    }
    
    report_helper(groups: &groups, cur_index: 0, possibles: &possibles)
    
    // 七小对: 2 + 2 + 2 + 2 + 2 + 2 + 2
    if self.revealed.count == 0 && self.grouped.count == 0 {
      groups = []
      for _ in 1 ... 7 {
        let new_group = MaJiangGroup()
        new_group.setRequirement(["对子"], 2)
        groups.append(new_group)
      }
    }
    
    report_helper(groups: &groups, cur_index: 0, possibles: &possibles)
    
    return (false, [:])
  }
}

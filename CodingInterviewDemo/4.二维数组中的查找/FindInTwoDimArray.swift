//
//  FindInTwoDimArray.swift
//  CodingInterviewDemo
//
//  Created by echonn on 2019/1/2.
//  Copyright © 2019年 echonn. All rights reserved.
//

import Foundation

/*
 在一个二维数组中，每一行都按照从左到右递增的顺序排序，
 每一列都按照从上到下递增的顺序排序，请完成一个函数：
 输入这样一个二维数组和一个整数，
 判断数组中是否含有该整数
 
 解决思路：
 1.使用二分法的思想，但选取的对照数字不能是中间的点，如果是中心的点，
   那么选取的位置有重叠，比如选取数字的左方及上方（右方及下方），则变复杂了
 
 2.选取右上角或左下角，可以依次排除某一列或某一行
 */


func find(arr: [[Int]], target: Int) -> Bool {

    guard !arr.isEmpty else {
        return false
    }
    
    guard arr[0].count > 0 else {
        return false
    }
    
    for sub in arr {
        if sub.count != arr[0].count {
            return false
        }
    }
    
//    return topRightCorner(arr: arr, target: target)
    return bottomLeftCorner(arr: arr, target: target)

}

func topRightCorner(arr: [[Int]], target: Int) -> Bool {
    // 选取的点在右上角
    var col = arr[0].count-1
    var row = 0
    
    while row < arr.count && col >= 0 {
        let v = arr[row][col]
        if v > target {
            col -= 1
        }
        else if v < target {
            row += 1
        }
        else {
            return true
        }
    }
    
    return false
}

func bottomLeftCorner(arr: [[Int]], target: Int) -> Bool {
    // 选取的点在左下角
    var col = 0
    var row = arr.count-1
    
    while row >= 0 && col < arr[0].count {
        let v = arr[row][col]
        if v > target {
            row -= 1
        }
        else if v < target {
            col += 1
        }
        else {
            return true
        }
    }
    
    return false
}


func testFindNumberInTwoDimArray(testName: String, inuput: [[Int]], target: Int) {
    print("testName: \(testName)\n input : \(inuput)")
    let res = find(arr: inuput, target: target)
    print("result: \(res)\n")
}

func testFindInTwoDimArray() {
    let num1 = [[1, 2, 8, 9, 10],
                [2, 4, 9, 11, 13],
                [4, 7, 10, 12, 15],
                [6, 8, 11, 13, 18]
                ]
    testFindNumberInTwoDimArray(testName: "要找的数字在数组中", inuput: num1, target: 7)
    
    testFindNumberInTwoDimArray(testName: "要找的数字不在数组中", inuput: num1, target: 5)
    
    testFindNumberInTwoDimArray(testName: "要找的数字是数组中最小的", inuput: num1, target: 1)
    
    testFindNumberInTwoDimArray(testName: "要找的数字是数组中最大的", inuput: num1, target: 18)
}

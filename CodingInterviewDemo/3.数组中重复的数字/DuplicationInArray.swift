//
//  DuplicationInArray.swift
//  CodingInterviewDemo
//
//  Created by echonn on 2018/12/28.
//  Copyright © 2018年 echonn. All rights reserved.
//

import Foundation

/*
 数组：占据一块连续的内容并按照顺序存储数据
 */

// 3-1
/*
 在一个长度为n的数组中，所有数字都在0～n-1的范围，数组中某些数字是重复的，但不知道有几个数字重复了，
 也不知道每个数字重复了几次，请找出数组中任意一个重复的数字
 输入：长度为7的数组 [2, 3, 1, 0, 2, 5, 3]
 输出：2 或 3
 */
func duplicationInArray(_ arr: inout [Int]) -> Int {
    
    let length = arr.count
    guard length > 0 else {
        return -1
    }
    
    var i = 0
    while i < length {
        if arr[i] == i {
            i += 1
        }
        else {
            let swp = arr[i]
            
            if arr[swp] == arr[i] {
                return arr[i]
            }
            else {
                let temp = arr[swp]
                arr[swp] = arr[i]
                arr[i] = temp
            }
        }
    }

    return -1
}

func testDuplicationInArray(testName: String, inuput: inout [Int]) {
    print("testName: \(testName)\n input : \(inuput)")
    let res = duplicationInArray(&inuput)
    print("output : \(inuput)\n result: \(res)\n")
}

func testDuplication() {
    var num1 = [2, 1, 3, 1, 4]
    testDuplicationInArray(testName: "重复数字是数组中最小的", inuput: &num1)
    
    var num2 = [2, 4, 3, 1, 4]
    testDuplicationInArray(testName: "重复数字是数组中最大的", inuput: &num2)
    
    var num3 = [2, 1, 3, 1, 4, 5, 3]
    testDuplicationInArray(testName: "数组中存在多个重复数字", inuput: &num3)
    
    var num4 = [2, 1, 3, 0, 4]
    testDuplicationInArray(testName: "没有重复数字", inuput: &num4)
}


// 3-2. 不修改数组找出重复的数字
/*
 在一个长度为n+1的数组中所有数字都在1-n的范围内， 所以数组中至少有一个数字是重复的，
 请找出数组中任意一个重复的数字，但不能修改输入的数组，
 如输入 [2,3,5,4,3,2,6,7]
 则输出重复的数字2或3
 */
/*
 注：n+1个数字，范围都在1-n,则至少有一个数字重复
 1.用空间换时间：另new一个数组来存放
 2.用时间换空间：使用二分法,
   二分查找法，是在有序的基础上，对位置进行分，
   而这里是对出现重复数字的范围进行分,时间复杂度 O(nlogn)
   因为函数countNum需要被调用O(logn)次，每次需要的时间为O(n)
 */

func dulplicaiton(arr: [Int]) -> Int {
    
    guard !arr.isEmpty else {
        return -1
    }
    
    let len = arr.count
    var high = len - 1
    var low = 1
    
    while low <= high {
        let mid = low + (high-low)/2
        let count = countNum(arr: arr, low: low, high: mid)
        
        if low == high {
            if count > 1 {
                return low
            }
            break
        }
        
        if count > mid-low+1 {
            high = mid
        }
        else {
            low = mid+1
        }
    }
    return -1
}

func countNum(arr: [Int], low: Int, high: Int) -> Int {
    var count = 0
    for i in arr {
        if i >= low && i <= high {
            count += 1
        }
    }
    return count
}

func testDuplicationInArray2(testName: String, inuput: inout [Int]) {
    print("testName: \(testName)\n input : \(inuput)")
    let res = dulplicaiton(arr: inuput)
    print("output : \(inuput)\n result: \(res)\n")
}

func testDuplication2() {
    var num1 = [2, 1, 3, 1, 4]
    testDuplicationInArray2(testName: "重复数字是数组中最小的", inuput: &num1)

    var num2 = [2, 4, 3, 1, 4]
    testDuplicationInArray2(testName: "重复数字是数组中最大的", inuput: &num2)

    var num3 = [2, 1, 3, 1, 4, 5, 3]
    testDuplicationInArray2(testName: "数组中存在多个重复数字", inuput: &num3)

    var num4 = [2, 1, 3, 5, 4]
    testDuplicationInArray2(testName: "没有重复数字", inuput: &num4)
}

// 二分查找法不递归版本, 为避免错漏，遵循以下两点
// 1.中位数 low+(high-low)/2 ，不用 (low+high)/2,以防溢出
// 2.边界，闭区间
func binarySearch(target: Int, arr: [Int]) -> Int {
    var low = 0
    var high = arr.count-1
    while low <= high {
        let mid = low + (high-low)/2
        if arr[mid] <= target {
            low = mid + 1
        }
        else {
            high = mid - 1
        }
    }
    
    if arr[low-1] == target {
        return low-1
    }
    
    return -1
}

//二分查找法递归版本
func binarySearch(target: Int, arr: [Int], low: Int, high: Int) -> Int {
    
    if low > high {
        return low
    }
    
    let mid = low + (high-low)/2
    if arr[mid] < target {
        return binarySearch(target: target, arr: arr, low: mid+1, high: high)
    }
    else {
        return binarySearch(target: target, arr: arr, low: low, high: mid-1)
    }
}

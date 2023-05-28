//
//  Heap.swift
//  Heap
//
//  Created by hana on 2023/05/01.
//

import Foundation

///요소를 힙정렬하는 컬렉션입니다.
///
///힙은 주어진 데이터들 중에서 '최댓값' 혹은 '최솟값'을 빠르게 찾아낼 수 있는 자료구조입니다.
///
///기본적으로 최소힙으로 동작합니다.
///
///---
///
///루트 노드를 초기화할 수 있습니다
///
///    let heap = Heap<Int>(10)
///
///초기화 값으로 HeapType을 줄 수 있습니다.
///
///    let heap = Heap<Int>(type: .min)
///
public struct Heap<T: Comparable>{
    internal var heap: [T] = []
    internal var type: HeapType = .min
    
    public init(){}
    
    ///초기화 값으로 HeapType을 줄 수 있습니다. 기본적으로 최소힙으로 동작합니다.
    ///
    ///- parameters:
    ///  - type: 최소힙, 최대힙을 결정할 수 있습니다.
    ///
    public init(type: HeapType){
        self.type = type
    }
    
    ///루트 노드를 초기화할 수 있습니다
    public init(_ element: T){
        heap.append(element) //0번 인덱스 채움
        heap.append(element) //실제 사용할 root Node
    }

    public var isEmpty: Bool{
        return heap.count <= 1
    }
    public var count: Int{
        return heap.count - 1
    }
    
    ///데이터를 추가할 수 있습니다.
    ///
    ///- parameters:
    ///  - _ element: 추가할 데이터
    ///
    mutating public func insert(_ element: T){
        if heap.isEmpty{
            heap.append(element)
            heap.append(element)
            return
        }
        heap.append(element)
        
        var insertIndex = heap.count - 1
        
        //추가된 값보다 부모가 더 크면 스왑
        while isSwapUp(insertIndex){
            let parentIndex = insertIndex / 2
            
            //작은 숫자를 위로
            heap.swapAt(insertIndex, parentIndex)
            insertIndex = parentIndex
        }
    }
    
    ///최상위 노드의 데이터를 빼냅니다.
    ///- returns: 최상위 노드 데이터
    mutating public func pop() -> T?{
        if heap.count <= 1{
            return nil
        }
        
        //최소값인 루트 값 반환
        let returnValue = heap[1]
        //젤 하위노드를 루트노드로 이동
        heap.swapAt(1, heap.count - 1)
        heap.removeLast()
        
        var popIndex = 1
        
        while isSwapDown(popIndex).0{
            let leftIndex = popIndex * 2
            let rightIndex = popIndex * 2 + 1
            
            //true = 왼쪽 자식노드와 swap, false = 오른쪽 자식노드와 swap
            switch isSwapDown(popIndex).1{
            case true: heap.swapAt(popIndex, leftIndex)
                popIndex = leftIndex
            case false: heap.swapAt(popIndex, rightIndex)
                popIndex = rightIndex
            default: break
            }
        }
        
        return returnValue
        
    }
    
    ///현재노드가 부모노드 보다 작은지 비교. 작으면 true
    private func isSwapUp(_ index: Int) -> Bool{
        //부모노드가 없음
        if index <= 1{
            return false
        }
        
        let parentIndex = index / 2
        
        switch self.type{
        case .min: return heap[index] < heap[parentIndex]
        case .max: return heap[index] > heap[parentIndex]
        }
    }
    
    ///현재노드가 자식노드 보다 큰지 비교. 크면 true,
    private func isSwapDown(_ index: Int) -> (Bool, Bool?){
        let leftIndex = index * 2
        let rightIndex = index * 2 + 1
        
        //자식노드가 없는 경우
        if leftIndex >= heap.count{
            return (false, nil)
        }
        
        //왼쪽 자식노드만 있는 경우
        if rightIndex >= heap.count{
            switch self.type{
            case .min:
                if heap[index] > heap[leftIndex]{
                    return (true, true)
                }
                else{
                    return (false, nil)
                }
            case .max:
                if heap[index] < heap[leftIndex]{
                    return (true, true)
                }
                else{
                    return (false, nil)
                }
            }
        }
        
        //자식노드가 모두 있는 경우
        switch self.type{
        case .min:
            if heap[leftIndex] < heap[rightIndex]{
                //index > left > right
                if heap[index] > heap[leftIndex]{
                    return (true, true)
                }
                //left > right >= index
                else{
                    return (false, nil)
                }
            }
            else{
                //index > right >= left
                if heap[index] > heap[rightIndex]{
                    return (true, false)
                }
                //right >= left >= index
                else{
                    return (false, nil)
                }
            }
        case .max:
            if heap[leftIndex] > heap[rightIndex]{
                if heap[index] < heap[leftIndex]{
                    return (true, true)
                }
                else{
                    return (false, nil)
                }
            }
            else{
                if heap[index] < heap[rightIndex]{
                    return (true, false)
                }
                else{
                    return (false, nil)
                }
            }
        }
    }
}

///Heap 자료구조의 정렬기준을 결정합니다.
///- min: 최소힙을 구현합니다.
///- max: 최대힙을 구현합니다.
public enum HeapType{
    case min
    case max
}

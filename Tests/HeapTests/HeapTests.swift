import XCTest
@testable import Heap

final class HeapTests: XCTestCase {
    func testBasic() throws {
        var heap = Heap<Int>()
        XCTAssertEqual(heap.isEmpty, true)
        
        heap.insert(0)
        XCTAssertEqual(heap.count, 1)
        XCTAssertEqual(heap.isEmpty, false)
        
        XCTAssertEqual(heap.pop(), 0)
        XCTAssertEqual(heap.count, 0)
        
        XCTAssertEqual(heap.pop(), nil)
        XCTAssertEqual(heap.count, 0)
    }
    
    func testMinHeap() throws {
        var heap = Heap<Int>(1)
//        heap.type = .min
        heap.insert(5)
        heap.insert(100)
        heap.insert(10)
        heap.insert(1)
        heap.insert(5)
        heap.insert(11)
        heap.insert(100)
        
        XCTAssertEqual(heap.pop(), 1)
        XCTAssertEqual(heap.pop(), 1)
        XCTAssertEqual(heap.pop(), 5)
        XCTAssertEqual(heap.pop(), 5)
        XCTAssertEqual(heap.pop(), 10)
        XCTAssertEqual(heap.pop(), 11)
        XCTAssertEqual(heap.pop(), 100)
        XCTAssertEqual(heap.pop(), 100)
    }
    
    func testMaxHeap() throws {
        var heap = Heap<Double>(type: .max)
        heap.insert(1.1)
        heap.insert(1.5)
        heap.insert(10)
        heap.insert(2.2)
        heap.insert(0)
        
        XCTAssertEqual(heap.pop(), 10)
        XCTAssertEqual(heap.pop(), 2.2)
        XCTAssertEqual(heap.pop(), 1.5)
        XCTAssertEqual(heap.pop(), 1.1)
        XCTAssertEqual(heap.pop(), 0)
    }
}

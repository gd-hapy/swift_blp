import XCTest
import swift_blp_Example

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
        _testHomeApi()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func _testHomeApi() {
        let hotSearchArr = UserDefaults.standard.value(forKey: "__key_hot_search_key") as! Array<Any>
        XCTAssert(hotSearchArr.count > 5, "pass")
        let top100Arr = UserDefaults.standard.value(forKey: "__key_hot_search_top_100_key") as! Array<Any>
        XCTAssert(top100Arr.count >= 100, "pass")
    }
    
}

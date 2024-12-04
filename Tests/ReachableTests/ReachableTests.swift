import XCTest
import Network
@testable import Reachable
import RxSwift

final class ReachableTests: XCTestCase {
    private var reachabilityService: Reachable!
    private var disposeBag: DisposeBag!
    private var monitor: MockNWPathMonitor!

    override func setUp() {
        super.setUp()
        configureTests()
    }

    override func tearDown() {
        reachabilityService?.monitor.updateHandler = nil
        reachabilityService = nil
        disposeBag = nil
        super.tearDown()
    }

    func testInitOfService() {
        XCTAssertNotNil(reachabilityService, "Reachability Service is nil")
        XCTAssertNotNil(reachabilityService?.monitor, "Reachability Service Monitor is nil")
        XCTAssertNotNil(reachabilityService?.queue, "Reachability Service Queue is nil")
        XCTAssertNotNil(reachabilityService?.monitor.updateHandler, "Reachability Service Monitor Path Update handler is nil")
    }

    func testDefaultReachabilityStatus() {
        let expectation = XCTestExpectation(description: "Network should require connection")
        reachabilityService.start()
        reachabilityService?.status
            .take(1)
            .subscribe(onNext: { status in
                XCTAssertEqual(status, .requiresConnection)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
    }

    func testSatisfiedNetworkStatus() {
        let expectation = XCTestExpectation(description: "Network should be satisfied")
        reachabilityService.start()
        reachabilityService?.status
            .skip(1)
            .subscribe(onNext: { status in
                XCTAssertEqual(status, .satisfied)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        monitor.updateHandler?(MockPathProtocol(status: .satisfied))
        wait(for: [expectation], timeout: 1.0)
    }

    func testUnsatisfiedNetworkStatus() {
        let expectation = XCTestExpectation(description: "Network should be unsatisfied")
        reachabilityService.start()
        reachabilityService?.subject
            .skip(1)
            .subscribe(onNext: { status in
                XCTAssertEqual(status, .unsatisfied)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        let mockPath = MockPathProtocol(status: .unsatisfied)
        monitor.updateHandler?(mockPath)
        wait(for: [expectation], timeout: 1.0)
    }

    func testDeinitOfService() {
        reachabilityService = nil
        disposeBag = nil
        XCTAssertNil(reachabilityService)
        XCTAssertNil(disposeBag)
    }

    func configureTests() {
        monitor = MockNWPathMonitor()
        reachabilityService = Reachable(monitor: monitor)
        disposeBag = DisposeBag()
    }
}

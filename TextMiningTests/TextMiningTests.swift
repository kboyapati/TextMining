//
//  TextMiningTests.swift
//  TextMiningTests
//
//  Created by Naga Kokila Boyapati on 12/24/2021.
//

import XCTest
@testable import TextMining

class TextMiningTests: XCTestCase {
    
    let FullFormEndPoint: SearchEndPoint = .searchFullForm(fullForm: "FBI")
    let shortFormEndPoint: SearchEndPoint = .searchShortForm(shortForm: "ASA")
    
    func testEndpoint() {
        XCTAssertFalse(FullFormEndPoint.baseUrl.isEmpty, "No base url")
        XCTAssertFalse(FullFormEndPoint.path.isEmpty, "No path available for search")
        XCTAssertFalse(FullFormEndPoint.parameters.count == 0, "No parameter added for search")
    }
    
    func testSerachViewModel() {
        let expectation = expectation(description: "API Data")
        let viewModel = SearchViewModel()
        viewModel.dataLoadingState = { [weak self, weak viewModel] loading in
            switch loading {
            case .loading:
                print("data started loading")
                break
            case .finished:
                XCTAssertFalse(viewModel?.rows == 0, "No data loaded")
                let first = viewModel?.model(at: 0)
                XCTAssertNotNil(first, "Item should not be nil")
                XCTAssertFalse(first?.variations.count == 0, "No variations found for \"Federal Bureau of Investigation\"")
                XCTAssertFalse(first!.text != "Federal Bureau of Investigation", "Text is not equal to \"Federal Bureau of Investigation\"")
                self?.checkSearchDetailViewModel(variations: first!.variations)
                expectation.fulfill()
                break
            case .failure(let error):
                XCTAssertThrowsError(error)
                break
            case .noDataFound:
                print("data is not found")
            }
        }
        viewModel.search(text: "FBI", isAbbriviation: true)
        wait(for: [expectation], timeout: 10.0)
    }
    
    func checkSearchDetailViewModel(variations: [FullFormCellViewModel]) {
        let viewModel = DetailViewModel(dataSource: variations)
        XCTAssertFalse(viewModel.rows == 0, "No data loaded")
        let first = viewModel.model(at: 0)
        XCTAssertNotNil(first, "Item should not be nil")
        XCTAssertFalse(first!.text != "Federal Bureau of Investigation", "Text is not equal to \"Federal Bureau of Investigation\"")
    }
}

//
//  RocketsViewModelTests.swift
//  
//
//  Created by Tomáš Brand on 11.04.2023.
//

import XCTest
import Resolver
import UIToolkit
import SharedDomainMocks
@testable import Rockets
import SharedDomain

@MainActor
final class RocketsViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    private let fc = FlowControllerMock<RocketsFlow>(navigationController: UINavigationController())
    private let getRocketsUseCaseMock = GetRocketsUseCaseMock()
    
    // MARK: - Setup
    
    private func createViewModel() -> RocketsViewModel {
        Resolver.registerUseCaseMocks()
        
        return RocketsViewModel(flowController: fc)
    }

    // MARK: - Tests

    func testFetchRockets() async {
        // given
        getRocketsUseCaseMock.executeReturnValue = [Rocket.stubRocket]
        
        // when
        let viewModel = createViewModel()
        viewModel.onIntent(.fetch)
        await viewModel.awaitAllTasks()
        
        // then
        XCTAssertEqual(viewModel.state.isLoading, false)
        XCTAssertEqual(viewModel.state.rockets, [])
    }
    
    func testFetchNotificationsWithError() async {
        // given
        getRocketsUseCaseMock.executeReturnValue = []
        
        // when
        let viewModel = createViewModel()
        viewModel.onIntent(.fetch)
        await viewModel.awaitAllTasks()
        
        // then
        XCTAssertEqual(viewModel.state.rockets, [])
    }
}

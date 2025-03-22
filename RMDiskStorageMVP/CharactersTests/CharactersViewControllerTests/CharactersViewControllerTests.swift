//
//  CharactersViewControllerTests.swift
//  CharactersPresenterTests
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class CharactersViewControllerTests: XCTestCase {
    var viewController: CharactersViewController!
    var mockPresenter: MockPresenter!
    var mockDataSource: MockDataSource!

    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        mockDataSource = MockDataSource()
        viewController = CharactersViewController(presenter: mockPresenter, tableViewDataSource: mockDataSource)
    }

    override func tearDown() {
        viewController = nil
        mockPresenter = nil
        mockDataSource = nil
        super.tearDown()
    }

    func testViewDidLoadCallsPresenterViewDidLoad() {
        // Даем ViewController загрузиться
        viewController.viewDidLoad()

        // Проверяем, что метод viewDidLoad у Presenter был вызван
        XCTAssertTrue(mockPresenter.viewDidLoadCalled, "viewDidLoad() должно вызвать presenter.viewDidLoad()")
    }

    func testSetupViews() {
        // Даем ViewController загрузиться
        viewController.viewDidLoad()

        // Проверяем ли установку dataSource
        XCTAssertNotNil(viewController.tableView.dataSource, "dataSource должен быть установлен")
        XCTAssertTrue(viewController.tableView.dataSource === mockDataSource, "dataSource должен быть равен mockDataSource")

        // Проверяем ли установку delegate
        XCTAssertNotNil(viewController.tableView.delegate, "delegate должен быть установлен")
        XCTAssertTrue(viewController.tableView.delegate === viewController, "delegate должен быть равен CharactersViewController")
    }

    func testUpdateCharactersReloadsData() {
        // Подготовка пустого массива персонажей
        let characters = [Character(name: "John Doe", status: "Alive", species: "Human", gender: "Male", location: Location(name: "Earth"), image: "image_url")]

        // Обновляем список персонажей
        viewController.updateCharacters(characters)

        // Проверяем, что dataSource содержит нужные персонажи
        XCTAssertEqual(mockDataSource.characters, characters, "characters должен быть обновлён в DataSource")
    }
}

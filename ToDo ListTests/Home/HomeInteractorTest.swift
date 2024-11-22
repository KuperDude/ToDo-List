import XCTest
import CoreData
@testable import ToDo_List

class HomeInteractorTest: XCTestCase {
    var interactor: HomeInteractor!
    var mockAPIManager: MockAPIManager!
    var mockToDoDataService: MockToDoDataService!

    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        mockToDoDataService = MockToDoDataService()
        interactor = HomeInteractor(apiManager: mockAPIManager, dataService: mockToDoDataService)
    }

    override func tearDown() {
        interactor = nil
        mockAPIManager = nil
        mockToDoDataService = nil
        super.tearDown()
    }

    func test_HomeInteractor_LoadData_FirstLaunch_FetchesFromAPI() async {
        // Given
        await UIApplication.setFirstLaunch()
        mockAPIManager.mockToDoTasks = [ToDoTask(id: 1, todo: "Test", completed: false, text: "Test Text")]
        // When
        await interactor.loadData()

        // Then
        XCTAssertEqual(interactor.toDoTasks.count, 1)
        XCTAssertEqual(interactor.toDoTasks.first?.todo, "Test")
    }

    func test_HomeInteractor_FiltersCorrectly() {
        // Given
        interactor.toDoTasks = [
            ToDoTask(id: 1, todo: "Buy groceries", completed: false, text: "Milk, Bread"),
            ToDoTask(id: 2, todo: "Write code", completed: false, text: "Finish HomeInteractor"),
            ToDoTask(id: 3, todo: "Call mom", completed: false, text: "Evening call")
        ]

        // When
        let filteredTasks = interactor.filterTasks(by: "code")

        // Then
        XCTAssertEqual(filteredTasks.count, 1)
        XCTAssertEqual(filteredTasks.first?.todo, "Write code")
    }
    
    func test_HomeInteractor_changeCompleted_shouldChangeCompleted() {
        // Given
        let task = ToDoTask(id: 1, todo: "Buy groceries", completed: false, text: "Milk, Bread")
        
        // When
        interactor.changeCompleted(toDoTask: task)
        
        // Then
        XCTAssertEqual(!task.completed, mockToDoDataService.updatedTask?.completed)
    }
}

class MockAPIManager: APIManagerProtocol {
    var mockToDoTasks: [ToDoTask]? = nil
    var shouldReturnError = false

    func getToDoTasks() async -> [ToDoTask]? {
        if shouldReturnError {
            return nil
        }
        return mockToDoTasks
    }
}

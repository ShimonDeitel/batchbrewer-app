import XCTest
@testable import Batchbrewer

@MainActor
final class BatchbrewerTests: XCTestCase {
    var store: Store!

    override func setUp() async throws {
        store = Store()
        store.entries = []
    }

    func testAddEntryIncreasesCount() {
        let before = store.entries.count
        store.add(BatchEntry())
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func testFreshInstallSeedDataBelowFreeLimit() {
        let seed = Store.seedData()
        XCTAssertLessThan(seed.count, Store.freeLimit)
    }

    func testCanAddMoreWhenUnderLimit() {
        store.entries = []
        XCTAssertTrue(store.canAddMore)
    }

    func testCannotAddMoreAtFreeLimit() {
        store.entries = (0..<Store.freeLimit).map { _ in BatchEntry() }
        XCTAssertFalse(store.canAddMore)
    }

    func testAddRespectsLimit() {
        store.entries = (0..<Store.freeLimit).map { _ in BatchEntry() }
        store.add(BatchEntry())
        XCTAssertEqual(store.entries.count, Store.freeLimit)
    }

    func testDeleteAtOffsetRemovesEntry() {
        let entry = BatchEntry()
        store.entries = [entry]
        store.delete(at: IndexSet(integer: 0))
        XCTAssertTrue(store.entries.isEmpty)
    }

    func testDeleteSpecificEntry() {
        let entry = BatchEntry()
        store.entries = [entry]
        store.delete(entry)
        XCTAssertTrue(store.entries.isEmpty)
    }

    func testUpdateEntryReplacesExisting() {
        var entry = BatchEntry()
        store.entries = [entry]
        entry = BatchEntry(id: entry.id)
        store.update(entry)
        XCTAssertEqual(store.entries.first?.id, entry.id)
    }
}

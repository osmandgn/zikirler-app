//
//  ZikirlerTests.swift
//  ZikirlerTests
//
//  Created by osman dogan on 15.05.2025.
//

import Testing
@testable import Zikirler
import Foundation // Required for Date, UUID, JSONEncoder, JSONDecoder

struct ZikirlerTests {

    @Test func example() async throws {
        // This is a default test, can be removed or kept.
        #expect(true == true)
    }

    @Test func testZikirEntryInitializationAndCodable() throws {
        let testID = UUID()
        let testDate = Date()
        let testName = "Test Zikir"
        let testCount = 100

        // 1. Test Initialization
        let entry = ZikirEntry(id: testID, name: testName, count: testCount, date: testDate)
        #expect(entry.id == testID)
        #expect(entry.name == testName)
        #expect(entry.count == testCount)
        #expect(entry.date == testDate)

        // 2. Test Codable Conformance
        // Encode
        let encoder = JSONEncoder()
        let data = try #require(encoder.encode(entry))

        // Decode
        let decoder = JSONDecoder()
        let decodedEntry = try #require(decoder.decode(ZikirEntry.self, from: data))

        // Assert decoded object's properties
        #expect(decodedEntry.id == entry.id)
        #expect(decodedEntry.name == entry.name)
        #expect(decodedEntry.count == entry.count)
        // Date comparison needs to be done carefully due to precision.
        // Encoding and decoding can sometimes result in very minor differences.
        // For practical purposes, comparing timeIntervalSince1970 is robust.
        #expect(abs(decodedEntry.date.timeIntervalSince1970 - entry.date.timeIntervalSince1970) < 0.001)
    }
    
    @Test func testZikirEntryDefaultID() throws {
        let testName = "Default ID Zikir"
        let testCount = 50
        let testDate = Date()
        
        let entry = ZikirEntry(name: testName, count: testCount, date: testDate)
        // Check that an ID was generated
        #expect(entry.id != UUID.null) // UUID.null is a common way to represent an empty/nil UUID
    }


    @Test func testZikirDataManagerSaveLoadClear() throws {
        // 0. Start with a clean slate
        ZikirDataManager.clearAllZikirEntries()
        var loadedEntries = ZikirDataManager.loadZikirEntries()
        #expect(loadedEntries.isEmpty == true, "Entries should be empty after clearing.")

        // 1. Create sample data
        let date1 = Date().addingTimeInterval(-1000)
        let date2 = Date()
        let entry1 = ZikirEntry(name: "Sübhanallah", count: 100, date: date1)
        let entry2 = ZikirEntry(name: "Elhamdülillah", count: 200, date: date2)
        let sampleEntries = [entry1, entry2]

        // 2. Save entries
        ZikirDataManager.saveZikirEntries(sampleEntries)

        // 3. Load entries
        loadedEntries = ZikirDataManager.loadZikirEntries()
        #expect(loadedEntries.count == 2, "Should load 2 entries.")

        // 4. Assert content (order might not be guaranteed by UserDefaults)
        let loadedEntry1 = loadedEntries.first { $0.name == "Sübhanallah" }
        let loadedEntry2 = loadedEntries.first { $0.name == "Elhamdülillah" }

        #expect(loadedEntry1 != nil)
        #expect(loadedEntry1?.count == 100)
        #expect(abs(loadedEntry1!.date.timeIntervalSince1970 - date1.timeIntervalSince1970) < 0.001)
        
        #expect(loadedEntry2 != nil)
        #expect(loadedEntry2?.count == 200)
        #expect(abs(loadedEntry2!.date.timeIntervalSince1970 - date2.timeIntervalSince1970) < 0.001)

        // 5. Test clearing data
        ZikirDataManager.clearAllZikirEntries()
        let finalEntries = ZikirDataManager.loadZikirEntries()
        #expect(finalEntries.isEmpty == true, "Entries should be empty after final clear.")
    }
    
    @Test func testZikirDataManagerLoadEmpty() throws {
        ZikirDataManager.clearAllZikirEntries() // Ensure no data
        let entries = ZikirDataManager.loadZikirEntries()
        #expect(entries.isEmpty == true)
    }
    
    @Test func testZikirDataManagerAddEntry() throws {
        ZikirDataManager.clearAllZikirEntries()
        
        let initialCount = ZikirDataManager.loadZikirEntries().count
        #expect(initialCount == 0)
        
        let testName = "Test Add Zikir"
        let testCount = 33
        let testDate = Date()
        
        ZikirDataManager.addZikirEntry(name: testName, count: testCount, date: testDate)
        
        let entriesAfterAdd = ZikirDataManager.loadZikirEntries()
        #expect(entriesAfterAdd.count == initialCount + 1)
        
        let addedEntry = entriesAfterAdd.first
        #expect(addedEntry != nil)
        #expect(addedEntry?.name == testName)
        #expect(addedEntry?.count == testCount)
        #expect(abs(addedEntry!.date.timeIntervalSince1970 - testDate.timeIntervalSince1970) < 0.001)
        
        // Clean up
        ZikirDataManager.clearAllZikirEntries()
    }
}

// Helper extension for UUID.null if not available (Swift Testing might not need this)
extension UUID {
    static var null: UUID {
        return UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    }
}

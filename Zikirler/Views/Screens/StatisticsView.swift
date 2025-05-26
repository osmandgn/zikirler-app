//
//  StatisticsView.swift
//  Zikirler
//
//  Created by Your Name on \(Date()) // Note: This date won't update dynamically after file creation.
//

import SwiftUI

struct StatisticsView: View {
    @State private var allEntries: [ZikirEntry] = []

    var body: some View {
        VStack {
            Text("İstatistikler")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            // Total Entries for context
            Text("Toplam Kayıtlı Zikir: \(allEntries.count)")
                .font(.headline)
                .padding(.bottom, 10)

            // Weekly Statistics Section
            VStack(alignment: .leading) {
                Text("Haftalık İstatistikler")
                    .font(.title2)
                    .fontWeight(.semibold)
                let weeklyEntries = filterEntries(for: .week)
                Text("Bu Haftaki Zikir Sayısı: \(weeklyEntries.count)")
                    .padding(.top, 5)
                if let firstWeekly = weeklyEntries.first {
                    Text("Örnek Haftalık Zikir: \(firstWeekly.name) (\(firstWeekly.count))")
                        .padding(.top, 5)
                } else {
                    Text("Bu hafta için kayıtlı zikir yok.")
                        .padding(.top, 5)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.bottom, 20)

            // Monthly Statistics Section
            VStack(alignment: .leading) {
                Text("Aylık İstatistikler")
                    .font(.title2)
                    .fontWeight(.semibold)
                let monthlyEntries = filterEntries(for: .month)
                Text("Bu Aylık Zikir Sayısı: \(monthlyEntries.count)")
                    .padding(.top, 5)
                if monthlyEntries.isEmpty {
                    Text("Bu ay için kayıtlı zikir yok.")
                        .padding(.top, 5)
                } else {
                    Text("Bu ay kaydedilen zikirlerden bazıları:")
                        .padding(.top, 5)
                    ForEach(monthlyEntries.prefix(2), id: \.id) { entry in
                        Text("- \(entry.name): \(entry.count)")
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.bottom, 20)

            // Yearly Statistics Section
            VStack(alignment: .leading) {
                Text("Yıllık İstatistikler")
                    .font(.title2)
                    .fontWeight(.semibold)
                let yearlyEntries = filterEntries(for: .year)
                Text("Bu Yıllık Zikir Sayısı: \(yearlyEntries.count)")
                    .padding(.top, 5)
                if !yearlyEntries.isEmpty {
                    Text("Yıl boyunca kaydedilen toplam zikir: \(yearlyEntries.reduce(0) { $0 + $1.count })")
                        .padding(.top, 5)
                } else {
                    Text("Bu yıl için kayıtlı zikir yok.")
                        .padding(.top, 5)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)

            Spacer() // Pushes content to the top
        }
        .padding()
        .navigationTitle("İstatistikler")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadData()
        }
    }

    func loadData() {
        let loaded = ZikirDataManager.loadZikirEntries()
        if loaded.isEmpty {
            print("No existing data found. Creating sample data...")
            // Create diverse sample data
            var sampleEntries: [ZikirEntry] = []
            let calendar = Calendar.current

            // Today
            sampleEntries.append(ZikirEntry(name: "Sübhanallah", count: 100, date: Date()))
            sampleEntries.append(ZikirEntry(name: "Elhamdülillah", count: 50, date: Date()))
            
            // Last Week
            if let lastWeekDate = calendar.date(byAdding: .weekOfYear, value: -1, to: Date()) {
                sampleEntries.append(ZikirEntry(name: "Allahu Ekber", count: 75, date: lastWeekDate))
                sampleEntries.append(ZikirEntry(name: "Lâ ilâhe illallah", count: 120, date: calendar.date(byAdding: .day, value: -2, to: lastWeekDate)!))
            }

            // Last Month
            if let lastMonthDate = calendar.date(byAdding: .month, value: -1, to: Date()) {
                sampleEntries.append(ZikirEntry(name: "Estağfirullah", count: 200, date: lastMonthDate))
                 sampleEntries.append(ZikirEntry(name: "Salli Ala Muhammed", count: 60, date: calendar.date(byAdding: .day, value: -5, to: lastMonthDate)!))
            }
            
            // Last Year
            if let lastYearDate = calendar.date(byAdding: .year, value: -1, to: Date()) {
                sampleEntries.append(ZikirEntry(name: "Ya Latif", count: 300, date: lastYearDate))
                 sampleEntries.append(ZikirEntry(name: "Ya Hafız", count: 90, date: calendar.date(byAdding: .month, value: -2, to: lastYearDate)!))
            }
            
            self.allEntries = sampleEntries
            ZikirDataManager.saveZikirEntries(self.allEntries)
            print("Sample data created and saved. Total: \(self.allEntries.count)")
        } else {
            self.allEntries = loaded
            print("Existing data loaded. Total: \(self.allEntries.count)")
        }
    }

    enum TimePeriod {
        case week, month, year
    }

    func filterEntries(for period: TimePeriod) -> [ZikirEntry] {
        let calendar = Calendar.current
        let now = Date()
        
        return allEntries.filter { entry in
            switch period {
            case .week:
                return calendar.isDate(entry.date, equalTo: now, toGranularity: .weekOfYear) &&
                       calendar.isDate(entry.date, equalTo: now, toGranularity: .yearForWeekOfYear)
            case .month:
                return calendar.isDate(entry.date, equalTo: now, toGranularity: .month) &&
                       calendar.isDate(entry.date, equalTo: now, toGranularity: .year)
            case .year:
                return calendar.isDate(entry.date, equalTo: now, toGranularity: .year)
            }
        }
    }
}

#Preview {
    NavigationView {
        StatisticsView()
    }
}

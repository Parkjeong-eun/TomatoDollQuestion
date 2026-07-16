//
//  AnswerListView.swift
//  TomatoDollQuestion
//
//  Created by 박정은 on 7/17/26.
//

import SwiftUI
import SwiftData

struct AnswerListView: View {
    @Query(sort: \AnswerEntry.date, order: .reverse)
    private var entries: [AnswerEntry]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            Group {
                if entries.isEmpty {
                    ContentUnavailableView(
                        "아직 기록이 없어요",
                        systemImage: "questionmark.bubble",
                        description: Text("토마토 인형을 비추고 첫 답변을 남겨보세요")
                    )
                } else {
                    List {
                        ForEach(entries) { entry in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(entry.question)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text(entry.answer)
                                    .font(.body)
                                Text(entry.date, format: .dateTime.year().month().day().hour().minute())
                                    .font(.caption)
                                    .foregroundStyle(.tertiary)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("나의 기록")
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(entries[index])
        }
    }
}

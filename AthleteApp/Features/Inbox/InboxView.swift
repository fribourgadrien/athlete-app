import SwiftUI

struct InboxView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        NavigationStack {
            List {
                if !incomingRequests.isEmpty {
                    Section {
                        ForEach(incomingRequests) { request in
                            IncomingRequestRow(request: request)
                        }
                    } header: {
                        Text("Requests")
                            .font(AppFont.ui(11, weight: .semibold))
                            .tracking(1.0)
                            .foregroundStyle(AppTheme.muted)
                            .textCase(nil)
                    }
                }

                Section {
                    if store.threads.isEmpty {
                        Text("No conversations yet.")
                            .font(AppFont.ui(14))
                            .foregroundStyle(AppTheme.muted)
                    } else {
                        ForEach(store.threads) { thread in
                            NavigationLink(value: thread) {
                                ThreadRow(thread: thread)
                            }
                        }
                    }
                } header: {
                    Text("Messages")
                        .font(AppFont.ui(11, weight: .semibold))
                        .tracking(1.0)
                        .foregroundStyle(AppTheme.muted)
                        .textCase(nil)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .listRowSeparatorTint(AppTheme.rule)
            .background(AppTheme.paper.ignoresSafeArea())
            .navigationTitle("Inbox")
            .toolbarBackground(AppTheme.paper, for: .navigationBar)
            .navigationDestination(for: MessageThread.self) { thread in
                ThreadDetailView(threadID: thread.id)
            }
        }
    }

    private var incomingRequests: [ConnectionRequest] {
        store.pendingRequests.filter { $0.status == .pendingIncoming }
    }
}

struct IncomingRequestRow: View {
    @EnvironmentObject private var store: AppStore
    let request: ConnectionRequest

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text(request.fromUserName)
                    .font(AppFont.ui(15, weight: .medium))
                    .foregroundStyle(AppTheme.ink)
                Spacer()
                Text(request.createdAt, style: .relative)
                    .font(AppFont.ui(12))
                    .foregroundStyle(AppTheme.muted)
            }

            Text(request.message)
                .font(AppFont.ui(14))
                .foregroundStyle(AppTheme.muted)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 16) {
                Button("Accept") {
                    store.acceptIncomingRequest(request)
                }
                .font(AppFont.ui(14, weight: .semibold))
                .foregroundStyle(AppTheme.cobalt)

                Button("Later") {}
                    .font(AppFont.ui(14))
                    .foregroundStyle(AppTheme.muted)
            }
            .padding(.top, 2)
        }
        .padding(.vertical, 8)
        .listRowBackground(AppTheme.paper)
        .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

struct ThreadRow: View {
    let thread: MessageThread

    private var initials: String {
        String(thread.participantName.split(separator: " ").compactMap(\.first).prefix(2))
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AvatarView(initials: initials, size: 36)

            VStack(alignment: .leading, spacing: 3) {
                HStack(alignment: .firstTextBaseline) {
                    Text(thread.participantName)
                        .font(AppFont.ui(15, weight: .medium))
                        .foregroundStyle(AppTheme.ink)
                    Spacer()
                    Text(thread.updatedAt, style: .time)
                        .font(AppFont.ui(11))
                        .foregroundStyle(AppTheme.muted)
                }

                HStack(alignment: .firstTextBaseline) {
                    Text(thread.preview)
                        .font(AppFont.ui(13))
                        .foregroundStyle(AppTheme.muted)
                        .lineLimit(1)
                    if thread.unreadCount > 0 {
                        Text("\(thread.unreadCount)")
                            .font(AppFont.ui(11, weight: .semibold))
                            .foregroundStyle(AppTheme.ink)
                    }
                }

                Text(thread.participantRole == .scout ? "Scout" : "Athlete")
                    .font(AppFont.ui(11))
                    .foregroundStyle(AppTheme.muted)
            }
        }
        .padding(.vertical, 4)
        .listRowBackground(AppTheme.paper)
    }
}

struct ThreadDetailView: View {
    @EnvironmentObject private var store: AppStore
    let threadID: UUID
    @State private var draft = ""

    private var thread: MessageThread? {
        store.threads.first { $0.id == threadID }
    }

    var body: some View {
        Group {
            if let thread {
                VStack(spacing: 0) {
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 16) {
                                ForEach(thread.messages) { message in
                                    MessageBubble(message: message)
                                        .id(message.id)
                                }
                            }
                            .padding(20)
                        }
                        .onAppear {
                            if let last = thread.messages.last {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                        .onChange(of: thread.messages.count) { _, _ in
                            if let last = store.threads.first(where: { $0.id == threadID })?.messages.last {
                                withAnimation(.easeOut(duration: 0.25)) {
                                    proxy.scrollTo(last.id, anchor: .bottom)
                                }
                            }
                        }
                    }

                    Hairline()
                    HStack(alignment: .bottom, spacing: 12) {
                        TextField("Message", text: $draft, axis: .vertical)
                            .font(AppFont.ui(15))
                            .lineLimit(1...4)
                            .padding(.vertical, 10)

                        Button("Send") {
                            let body = draft.trimmingCharacters(in: .whitespacesAndNewlines)
                            guard !body.isEmpty else { return }
                            store.appendLocalReply(threadID: threadID, body: body)
                            draft = ""
                        }
                        .font(AppFont.ui(14, weight: .semibold))
                        .foregroundStyle(AppTheme.cobalt)
                        .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .opacity(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.35 : 1)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(AppTheme.paper)
                }
                .background(AppTheme.paper.ignoresSafeArea())
                .navigationTitle(thread.participantName)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(AppTheme.paper, for: .navigationBar)
            } else {
                Text("Thread unavailable")
                    .font(AppFont.ui(14))
                    .foregroundStyle(AppTheme.muted)
            }
        }
    }
}

struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        VStack(alignment: message.isFromCurrentUser ? .trailing : .leading, spacing: 4) {
            Text(message.body)
                .font(AppFont.ui(15))
                .foregroundStyle(AppTheme.ink)
                .multilineTextAlignment(message.isFromCurrentUser ? .trailing : .leading)
                .frame(maxWidth: .infinity, alignment: message.isFromCurrentUser ? .trailing : .leading)

            Text(message.sentAt, style: .time)
                .font(AppFont.ui(11))
                .foregroundStyle(AppTheme.muted)
        }
    }
}

import SwiftUI

struct InboxView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        NavigationStack {
            List {
                if !incomingRequests.isEmpty {
                    Section("Requests") {
                        ForEach(incomingRequests) { request in
                            IncomingRequestRow(request: request)
                        }
                    }
                }

                Section("Messages") {
                    if store.threads.isEmpty {
                        Text("No conversations yet.")
                            .foregroundStyle(AppTheme.slate)
                    } else {
                        ForEach(store.threads) { thread in
                            NavigationLink(value: thread) {
                                ThreadRow(thread: thread)
                            }
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(AppTheme.backgroundGradient.ignoresSafeArea())
            .navigationTitle("Inbox")
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
            HStack {
                Text(request.fromUserName)
                    .font(.headline)
                    .foregroundStyle(AppTheme.charcoal)
                Spacer()
                Text(request.createdAt, style: .relative)
                    .font(.caption)
                    .foregroundStyle(AppTheme.slate)
            }

            Text(request.message)
                .font(.subheadline)
                .foregroundStyle(AppTheme.slate)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 10) {
                Button("Accept") {
                    store.acceptIncomingRequest(request)
                }
                .buttonStyle(PrimaryButtonStyle())

                Button("Later") {}
                    .buttonStyle(SecondaryButtonStyle())
            }
        }
        .padding(.vertical, 6)
        .listRowBackground(Color.white.opacity(0.7))
    }
}

struct ThreadRow: View {
    let thread: MessageThread

    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                AvatarView(
                    initials: String(thread.participantName.split(separator: " ").compactMap(\.first).prefix(2)),
                    size: 44
                )
                Circle()
                    .fill(thread.participantRole == .scout ? AppTheme.amber : AppTheme.turf)
                    .frame(width: 10, height: 10)
                    .overlay(Circle().stroke(.white, lineWidth: 1.5))
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(thread.participantName)
                        .font(.headline)
                        .foregroundStyle(AppTheme.charcoal)
                    Spacer()
                    Text(thread.updatedAt, style: .time)
                        .font(.caption2)
                        .foregroundStyle(AppTheme.slate)
                }

                Text(thread.preview)
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.slate)
                    .lineLimit(1)
            }

            if thread.unreadCount > 0 {
                Text("\(thread.unreadCount)")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.white)
                    .padding(6)
                    .background(AppTheme.pitch)
                    .clipShape(Circle())
            }
        }
        .padding(.vertical, 4)
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
                            LazyVStack(alignment: .leading, spacing: 12) {
                                ForEach(thread.messages) { message in
                                    MessageBubble(message: message)
                                        .id(message.id)
                                }
                            }
                            .padding(16)
                        }
                        .onAppear {
                            if let last = thread.messages.last {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                        .onChange(of: thread.messages.count) { _, _ in
                            if let last = store.threads.first(where: { $0.id == threadID })?.messages.last {
                                withAnimation {
                                    proxy.scrollTo(last.id, anchor: .bottom)
                                }
                            }
                        }
                    }

                    HStack(spacing: 10) {
                        TextField("Write a message…", text: $draft, axis: .vertical)
                            .lineLimit(1...4)
                            .padding(12)
                            .background(Color.white.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                        Button {
                            let body = draft.trimmingCharacters(in: .whitespacesAndNewlines)
                            guard !body.isEmpty else { return }
                            store.appendLocalReply(threadID: threadID, body: body)
                            draft = ""
                        } label: {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 32))
                                .foregroundStyle(AppTheme.pitch)
                        }
                        .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding(12)
                    .background(AppTheme.mist.opacity(0.9))
                }
                .background(AppTheme.backgroundGradient.ignoresSafeArea())
                .navigationTitle(thread.participantName)
                .navigationBarTitleDisplayMode(.inline)
            } else {
                ContentUnavailableView("Thread unavailable", systemImage: "bubble.left.and.bubble.right")
            }
        }
    }
}

struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isFromCurrentUser { Spacer(minLength: 48) }

            VStack(alignment: message.isFromCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.body)
                    .font(.body)
                    .foregroundStyle(message.isFromCurrentUser ? .white : AppTheme.charcoal)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(message.isFromCurrentUser ? AppTheme.pitch : Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Text(message.sentAt, style: .time)
                    .font(.caption2)
                    .foregroundStyle(AppTheme.slate)
            }

            if !message.isFromCurrentUser { Spacer(minLength: 48) }
        }
    }
}

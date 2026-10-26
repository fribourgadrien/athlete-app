import SwiftUI

struct HighlightDetailView: View {
    @EnvironmentObject private var store: AppStore
    let clip: HighlightClip

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ZStack {
                    Rectangle()
                        .fill(AppTheme.ink)
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)
                    VStack(spacing: 10) {
                        Text("▷")
                            .font(AppFont.display(36, weight: .medium))
                            .foregroundStyle(.white)
                        Text(clip.durationLabel)
                            .font(AppFont.ui(13, weight: .medium))
                            .foregroundStyle(.white.opacity(0.75))
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text(clip.title)
                        .font(AppFont.display(26, weight: .medium))
                        .foregroundStyle(AppTheme.ink)
                    Text(clip.caption)
                        .font(AppFont.ui(14))
                        .foregroundStyle(AppTheme.muted)
                    Text("Highlight media is mocked for the MVP — replace with video playback later.")
                        .font(AppFont.ui(13))
                        .foregroundStyle(AppTheme.muted)
                        .padding(.top, 4)
                }
                .padding(.horizontal, 20)

                if let athlete = store.athlete(id: clip.athleteId) {
                    Hairline()
                        .padding(.horizontal, 20)
                    NavigationLink {
                        ProfileDetailView(athlete: athlete)
                    } label: {
                        HStack(spacing: 12) {
                            AvatarView(initials: athlete.initials, size: 40)
                            VStack(alignment: .leading, spacing: 3) {
                                Text(athlete.fullName)
                                    .font(AppFont.ui(15, weight: .medium))
                                    .foregroundStyle(AppTheme.ink)
                                Text("View profile")
                                    .font(AppFont.ui(13))
                                    .foregroundStyle(AppTheme.cobalt)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.bottom, 40)
        }
        .background(AppTheme.paper.ignoresSafeArea())
        .navigationTitle("Highlight")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.paper, for: .navigationBar)
    }
}

//
//  PlayerDetailView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//
import SwiftUI

struct PlayerDetailView: View {
  let player: Player
  @Environment(\.dismiss) private var dismiss
  @State private var showDeletePlayerAlert: Bool = false
  @State private var showColorPicker: Bool = false

  var body: some View {
    VStack(spacing: 0) {
      playerInitialsCircle
      RectangularDivider()
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          PlayerDetailSection(L10n.PlayerDetailView.highscore) {
            "\(player.wrappedHighscore)"
          }
          PlayerDetailSection(L10n.PlayerDetailView.lastScore) {
            "\(player.wrappedLastScore)"
          }
          PlayerDetailSection(L10n.PlayerDetailView.createdOn) {
            "\(player.wrappedCreatedOn.formatted(date: .abbreviated, time: .omitted))"
          }
          PlayerDetailSection(L10n.PlayerDetailView.numberOfSessionsWon) {
            "\(player.sessionsWon)"
          }
          PlayerDetailSection(L10n.PlayerDetailView.numberOfSessionsPlayed) {
            "\(player.sessionsPlayed)"
          }

          Button(L10n.PlayerDetailView.DeleteButton.title, role: .destructive) {
            showDeletePlayerAlert.toggle()
          }
          .buttonStyle(ShadowedStyle(role: .destructive))
          .padding(.horizontal, 50)
          .padding(.top)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
      }
    }
    .blur(radius: showColorPicker ? 5 : 0)
    .overlay {
      if showColorPicker {
        FavoriteColorPicker(player: player, favoriteColor: player.wrappedFavoriteColor, showColorPicker: $showColorPicker)
          .transition(.opacity.combined(with: .scale))
      }
    }
    .padding(.vertical)
    .alert(L10n.PlayerDetailView.DeletePlayer.alertTitle, isPresented: $showDeletePlayerAlert, actions: {
      Button(L10n.PlayerDetailView.DeletePlayer.confirmationButtonTitle, role: .destructive) { deletePlayerAndDismissView() }
    }, message: {
      Text(L10n.PlayerDetailView.DeletePlayer.alertMessage(player.wrappedName))
    })
    .navigationBarTitleDisplayMode(.inline)
    .gradientBackground()
  }

  func deletePlayerAndDismissView() {
    PlayerService.delete(player)
    dismiss()
  }
}

extension PlayerDetailView {
  struct PlayerDetailSection: View {
    let sectionTitle: String
    let sectionContent: String

    init(_ sectionTitle: String, content: () -> String) {
      self.sectionTitle = sectionTitle
      self.sectionContent = content()
    }

    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(sectionTitle.uppercased())
            .font(.caption)
          Spacer()
          Text(sectionContent)
        }
        Spacer()
      }
      .foregroundColor(.primary)
      .multilineTextAlignment(.center)
      .padding()
      .frame(maxWidth: .infinity, maxHeight: 60)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(.ultraThinMaterial)
          .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
      )
      .padding(.top, 5)
    }
  }

  private var playerInitialsCircle: some View {
      VStack {
        Circle()
          .fill(
            LinearGradient(colors: [
              Color(uiColor: player.wrappedFavoriteColor),
              Color(uiColor: player.wrappedFavoriteColor.shade(.dark))
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
          )
          .overlay(
            Text(player.wrappedName.initials)
              .font(.system(.largeTitle, design: .rounded))
              .foregroundColor(player.wrappedFavoriteColor.isDarkColor ? .white : .black)
          )
          .frame(width: 100, height: 100)
          .overlay(
            Circle()
              .strokeBorder(.primary, lineWidth: 2)
          )
          .overlay(alignment: .bottomTrailing) {
            Image(systemSymbol: .pencilCircleFill)
              .symbolRenderingMode(.palette)
              .foregroundStyle(.black, .ultraThickMaterial)
              .font(.title)
          }
        Text(player.wrappedName)
      }
      .padding(.bottom, 10)
      .onTapGesture {
        withAnimation {
          showColorPicker = true
        }
      }
  }
}

extension PlayerDetailView {
  struct FavoriteColorPicker: View {
    let player: Player
    @Binding var showColorPicker: Bool
    @State private var favoriteColor: UIColor
    @State var colorName: String = UIColor.FavoriteColors.colors[0].name
    @Namespace private var namespace

    init(player: Player,
         favoriteColor: UIColor,
         showColorPicker: Binding<Bool>) {
      self.player = player
      self.favoriteColor = favoriteColor
      _showColorPicker = showColorPicker
    }

    var body: some View {
      VStack(spacing: 20) {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(UIColor.FavoriteColors.colors, id: \.name) { favColor in
              Circle()
                .fill(favColor.color.asColor)
                .padding(4)
                .background(
                  favoriteColor == favColor.color
                  ? Circle()
                    .stroke(favColor.color.asColor, lineWidth: 3)
                    .matchedGeometryEffect(id: "background-stroke", in: namespace)
                  : nil
                )
                .shadow(radius: Constants.shadowRadius)
                .frame(width: 40, height: 34.66)
                .rotationEffect(Angle(degrees:
                                        UIColor.FavoriteColors.colors.firstIndex(of: favColor)?.isMultiple(of: 2) ?? true ? 180 : 0
                                     ))
                .frame(width: 32, height: 32)
                .onTapGesture {
                  withAnimation {
                    favoriteColor = favColor.color
                    colorName = favColor.name
                  }
                }
                .padding(.vertical, 7)
            }
          }
          .padding(.leading, 3)
        }

        Text(colorName)
          .font(.system(.headline, design: .rounded))
          .animation(.none, value: colorName)

        HStack {
          Button("Save") {
            PlayerService.updateFavColor(player, with: favoriteColor)
            hideColorPicker()
          }

          Button("Cancel", role: .cancel) {
            hideColorPicker()
          }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.regular)
        .foregroundColor(Color(uiColor: .systemBackground))
      }
      .frame(maxWidth: .infinity)
      .foregroundColor(.primary)
      .padding(10)
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .fill(Color.secondaryBackground)
          .shadow(radius: 3)
      )
      .padding(20)
    }

    private func hideColorPicker() {
      withAnimation {
        showColorPicker = false
      }
    }
  }
}

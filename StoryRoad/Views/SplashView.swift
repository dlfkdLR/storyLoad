import SwiftUI

/// 앱 시작 스플래시 — 로고가 떠오르고 오디오 파형이 일렁이는 부팅 화면
struct SplashView: View {
    @State private var logoVisible = false
    @State private var textVisible = false
    @State private var barsAnimating = false

    /// 로고 배경과 동일한 크림색
    private let background = Color(hex: "FDE9D5")

    var body: some View {
        ZStack {
            background.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 210, height: 210)
                    .clipShape(RoundedRectangle(cornerRadius: 46))
                    .shadow(color: Color.stampDeep.opacity(0.22), radius: 26, y: 14)
                    .padding(.bottom, 28)
                    .scaleEffect(logoVisible ? 1 : 0.7)
                    .opacity(logoVisible ? 1 : 0)

                Text("스토리로드")
                    .font(.system(size: 38, weight: .heavy, design: .rounded))
                    .foregroundStyle(Color.stampDeep)
                    .opacity(textVisible ? 1 : 0)
                    .offset(y: textVisible ? 0 : 14)

                Text("걸어서 모으는 이야기 지도")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.stampMid)
                    .padding(.top, 8)
                    .opacity(textVisible ? 1 : 0)
                    .offset(y: textVisible ? 0 : 10)

                Spacer()

                equalizer
                    .padding(.bottom, 60)
                    .opacity(textVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.spring(duration: 0.45, bounce: 0.3)) {
                logoVisible = true
            }
            withAnimation(.easeOut(duration: 0.35).delay(0.15)) {
                textVisible = true
            }
            barsAnimating = true
        }
    }

    /// 오디오 파형 로딩 인디케이터
    private var equalizer: some View {
        HStack(spacing: 6) {
            ForEach(0..<7, id: \.self) { index in
                Capsule()
                    .fill(barColor(index))
                    .frame(width: 6, height: barsAnimating ? barHeight(index) : 8)
                    .animation(
                        .easeInOut(duration: 0.45)
                        .repeatForever(autoreverses: true)
                        .delay(Double(index) * 0.09),
                        value: barsAnimating
                    )
            }
        }
        .frame(height: 34, alignment: .center)
    }

    private func barColor(_ index: Int) -> Color {
        [Color.stampLight, .stampMid, .stampDeep][index % 3]
    }

    private func barHeight(_ index: Int) -> CGFloat {
        [22, 32, 14, 30, 18, 28, 12][index % 7]
    }
}

#Preview {
    SplashView()
}

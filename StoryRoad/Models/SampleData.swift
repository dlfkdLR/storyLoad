import Foundation

/// 해커톤 데모용 샘플 데이터 — 경상북도 10개 시·군
enum SampleData {

    // 피드에서 참조할 수 있도록 고정 UUID 사용
    static let storyGyeongju1 = UUID(uuidString: "11111111-1111-1111-1111-111111111101")!
    static let storyGyeongju2 = UUID(uuidString: "11111111-1111-1111-1111-111111111102")!
    static let storyPohang1   = UUID(uuidString: "11111111-1111-1111-1111-111111111103")!
    static let storyAndong1   = UUID(uuidString: "11111111-1111-1111-1111-111111111104")!
    static let storyYeongdeok1 = UUID(uuidString: "11111111-1111-1111-1111-111111111105")!
    static let storyUlleung1  = UUID(uuidString: "11111111-1111-1111-1111-111111111106")!
    static let storyMungyeong1 = UUID(uuidString: "11111111-1111-1111-1111-111111111107")!
    static let storyDaegu1    = UUID(uuidString: "11111111-1111-1111-1111-111111111108")!

    static let regions: [Region] = [
        Region(
            id: "gyeongju", name: "경주", subtitle: "지붕 없는 박물관, 천년 고도",
            latitude: 35.8562, longitude: 129.2247, unlockRadiusMeters: 15000,
            teaser: "신라 천년의 수도. 불국사와 석굴암, 첨성대가 있는 역사 도시라는 것 정도만 알려져 있어요. 직접 방문하면 현지인만 아는 골목과 숨은 이야기가 열립니다.",
            fullDescription: "경주는 도시 전체가 유적지입니다. 대릉원 고분 사이로 해가 지는 풍경, 황리단길의 한옥 카페, 동궁과 월지의 야경까지 — 낮과 밤이 완전히 다른 도시예요. 봄에는 보문단지 벚꽃이, 가을에는 첨성대 옆 핑크뮬리가 장관입니다.",
            symbol: "building.columns.fill", colorHex: "C8A24B",
            events: [
                RegionEvent(id: "gj-e1", title: "경주 벚꽃 마라톤", period: "매년 4월 첫째 주",
                            detail: "보문호수 벚꽃길을 달리는 마라톤. 참가하지 않아도 벚꽃 터널 산책만으로 충분히 가치 있어요."),
                RegionEvent(id: "gj-e2", title: "신라문화제", period: "10월 초",
                            detail: "화랑 퍼레이드와 달빛 야행. 동궁과 월지 야간 개장과 함께 즐기면 최고의 코스.")
            ],
            localTips: [
                LocalTip(id: "gj-t1", author: "황남동 30년 토박이",
                         content: "황리단길은 오전 10시 전에 가세요. 사람 없는 한옥 골목을 통째로 전세 낼 수 있어요. 십원빵보다 교동 경주빵 본점이 진짜입니다."),
                LocalTip(id: "gj-t2", author: "경주 대학생",
                         content: "동궁과 월지는 무조건 해 지기 30분 전에 입장하세요. 노을→야경으로 넘어가는 순간이 경주에서 제일 예쁜 장면이에요.")
            ]
        ),
        Region(
            id: "pohang", name: "포항", subtitle: "해와 강철의 도시",
            latitude: 36.0190, longitude: 129.3435, unlockRadiusMeters: 15000,
            teaser: "한반도에서 해가 가장 먼저 뜨는 호미곶과 포스코가 있는 동해안 도시. 과메기가 유명하다는 것 정도만 공개되어 있어요.",
            fullDescription: "포항의 진짜 매력은 바다 그 자체예요. 영일대 해수욕장의 해상누각 야경, 이가리 닻 전망대, 스페이스워크에서 내려다보는 영일만. 죽도시장에서 물회 한 그릇 하고 환호공원으로 넘어가는 코스가 정석입니다.",
            symbol: "water.waves", colorHex: "2E86AB",
            events: [
                RegionEvent(id: "ph-e1", title: "호미곶 한민족 해맞이 축전", period: "12월 31일 ~ 1월 1일",
                            detail: "상생의 손 앞에서 맞는 새해 첫 일출. 전국에서 모이니 새벽 3시 전에 도착해야 해요."),
                RegionEvent(id: "ph-e2", title: "포항 국제 불빛축제", period: "7월 말",
                            detail: "영일대 앞바다에서 펼쳐지는 불꽃쇼. 바다 위에서 터지는 불꽃은 규모가 다릅니다.")
            ],
            localTips: [
                LocalTip(id: "ph-t1", author: "죽도시장 상인",
                         content: "물회는 여름, 과메기는 11월부터가 제철. 죽도시장 회센터 2층으로 올라가면 같은 횟감도 더 싸게 먹을 수 있어요."),
                LocalTip(id: "ph-t2", author: "포항 직장인",
                         content: "스페이스워크는 바람 없는 평일 저녁에 가세요. 야경이 켜진 제철소 방향 뷰가 의외의 명장면입니다.")
            ]
        ),
        Region(
            id: "andong", name: "안동", subtitle: "한국 정신문화의 수도",
            latitude: 36.5684, longitude: 128.7294, unlockRadiusMeters: 15000,
            teaser: "하회마을과 탈춤, 찜닭의 고장. 유네스코 세계유산이 있다는 것 정도만 알려져 있어요.",
            fullDescription: "안동은 시간이 다르게 흐르는 도시예요. 하회마을에서 강 건너 부용대에 오르면 마을 전체가 물돌이 안에 안긴 풍경이 한눈에 들어옵니다. 월영교의 밤, 구시장 찜닭 골목, 헛제삿밥까지 — 느리게 걸어야 보이는 것들이 많아요.",
            symbol: "theatermasks.fill", colorHex: "8E5B3A",
            events: [
                RegionEvent(id: "ad-e1", title: "안동국제탈춤페스티벌", period: "9월 말 ~ 10월 초",
                            detail: "세계의 탈과 탈춤이 모이는 축제. 하회별신굿탈놀이 본공연은 예약 필수.")
            ],
            localTips: [
                LocalTip(id: "ad-t1", author: "하회마을 주민",
                         content: "하회마을은 오후 4시 이후가 진짜예요. 단체 관광객이 빠지면 마을이 원래의 고요함을 되찾습니다. 부용대 일몰은 꼭 보세요."),
                LocalTip(id: "ad-t2", author: "안동 토박이",
                         content: "찜닭은 구시장 골목 안쪽 오래된 집으로 가세요. 월영교 야경은 보름달 뜨는 날이 최고입니다.")
            ]
        ),
        Region(
            id: "yeongdeok", name: "영덕", subtitle: "대게와 블루로드의 고장",
            latitude: 36.4153, longitude: 129.3653, unlockRadiusMeters: 15000,
            teaser: "영덕대게로 유명한 동해안 어촌. 그 외의 이야기는 방문하면 열립니다.",
            fullDescription: "영덕의 보석은 블루로드예요. 강구항에서 고래불해변까지 이어지는 64.6km 해안 트레킹 길. 특히 해맞이공원~축산항 구간은 파도 소리를 바로 옆에 두고 걷는 국내 최고의 바닷길입니다. 대게는 11월~4월이 제철.",
            symbol: "fish.fill", colorHex: "D1495B",
            events: [
                RegionEvent(id: "yd-e1", title: "영덕대게축제", period: "2월 말 ~ 3월 초",
                            detail: "강구항 일대에서 열리는 대게 축제. 경매 체험에서 시세보다 싸게 낙찰받을 수 있어요.")
            ],
            localTips: [
                LocalTip(id: "yd-t1", author: "강구항 어부",
                         content: "대게는 다리가 길고 배가 무거운 놈이 속이 찼어요. 항구 앞 첫 집보다 골목 안 단골집들이 같은 가격에 더 좋은 게를 줍니다.")
            ]
        ),
        Region(
            id: "mungyeong", name: "문경", subtitle: "옛길의 시작, 문경새재",
            latitude: 36.5866, longitude: 128.1995, unlockRadiusMeters: 15000,
            teaser: "조선 시대 과거길이었던 문경새재가 있는 곳. 자세한 이야기는 직접 걸어봐야 열립니다.",
            fullDescription: "문경새재는 맨발로 걷는 길이에요. 1관문에서 3관문까지 6.5km 황톳길을 신발 벗고 걷는 사람들이 진짜 문경을 아는 사람들입니다. 오미자 농장, 단산 모노레일, 폐역을 개조한 카페까지 — 산속에 숨은 콘텐츠가 의외로 많아요.",
            symbol: "figure.hiking", colorHex: "5B8C5A",
            events: [
                RegionEvent(id: "mg-e1", title: "문경 오미자축제", period: "9월 중순",
                            detail: "문경 특산 오미자 수확철 축제. 오미자청 담그기 체험이 인기.")
            ],
            localTips: [
                LocalTip(id: "mg-t1", author: "새재 입구 상인",
                         content: "새재길은 비 온 다음 날 맨발로 걸으세요. 촉촉한 황토가 발바닥에 닿는 느낌은 어디서도 못 느껴요. 입구 보관함에 신발 맡기면 됩니다.")
            ]
        ),
        Region(
            id: "ulleung", name: "울릉도", subtitle: "동해의 신비한 화산섬",
            latitude: 37.4845, longitude: 130.9057, unlockRadiusMeters: 20000,
            teaser: "배로 3시간, 동해 한가운데의 화산섬. 독도의 관문이라는 것 외엔 가본 사람만 압니다.",
            fullDescription: "울릉도는 도착하는 순간부터 비현실적이에요. 깎아지른 해안 절벽을 따라 도는 일주도로, 나리분지의 너와집, 독도전망대 케이블카. 오징어 내장탕과 따개비칼국수, 호박엿까지 — 섬 전체가 다른 나라 같은 곳입니다.",
            symbol: "sailboat.fill", colorHex: "1B6CA8",
            events: [
                RegionEvent(id: "ul-e1", title: "울릉도 오징어축제", period: "8월 중순",
                            detail: "저동항에서 열리는 오징어 맨손잡기 체험이 하이라이트.")
            ],
            localTips: [
                LocalTip(id: "ul-t1", author: "도동항 민박 주인",
                         content: "파도가 잔잔한 날엔 무조건 관음도부터 가세요. 그리고 배 시간은 여유 있게 — 결항되면 하루 더 묵는 게 울릉도의 룰입니다.")
            ]
        ),
        Region(
            id: "yeongju", name: "영주", subtitle: "선비의 고장, 부석사의 노을",
            latitude: 36.8057, longitude: 128.6240, unlockRadiusMeters: 15000,
            teaser: "부석사와 소수서원이 있는 선비의 고장. 무량수전 배흘림기둥 이야기는 가서 들어보세요.",
            fullDescription: "부석사 무량수전 앞에서 보는 소백산맥 일몰은 한국 건축이 만든 최고의 풍경 중 하나예요. 소수서원 솔숲길, 무섬마을 외나무다리까지 — 영주는 '걷는 맛'이 있는 도시입니다. 풍기 인삼과 한우도 빼놓을 수 없죠.",
            symbol: "mountain.2.fill", colorHex: "7D6B91",
            events: [
                RegionEvent(id: "yj-e1", title: "영주 풍기인삼축제", period: "10월 초",
                            detail: "풍기 인삼 수확철 축제. 인삼 캐기 체험과 시세보다 저렴한 직거래 장터.")
            ],
            localTips: [
                LocalTip(id: "yj-t1", author: "부석사 아랫마을 주민",
                         content: "부석사는 해 지기 1시간 전에 올라가세요. 무량수전 기둥에 기대 보는 노을이 영주의 전부라고 해도 과언이 아니에요.")
            ]
        ),
        Region(
            id: "cheongsong", name: "청송", subtitle: "주왕산과 사과의 고장",
            latitude: 36.4359, longitude: 129.0570, unlockRadiusMeters: 15000,
            teaser: "주왕산 국립공원과 청송 사과로 알려진 산골. 주산지의 새벽 풍경은 가본 사람만 압니다.",
            fullDescription: "청송의 새벽 주산지는 사진가들의 성지예요. 물안개 속에 잠긴 왕버들 풍경은 영화 '봄 여름 가을 겨울 그리고 봄'의 그 장면입니다. 주왕산 기암절벽 계곡 트레킹 후 달기약수로 끓인 백숙 한 그릇이 정석 코스.",
            symbol: "tree.fill", colorHex: "C0392B",
            events: [
                RegionEvent(id: "cs-e1", title: "청송사과축제", period: "11월 초",
                            detail: "청송 꿀사과 수확 축제. 사과 따기 체험과 사과 경매가 인기.")
            ],
            localTips: [
                LocalTip(id: "cs-t1", author: "주산지 마을 이장",
                         content: "주산지는 일출 30분 전 도착이 골든타임. 물안개는 일교차 큰 가을 새벽에만 피어요.")
            ]
        ),
        Region(
            id: "gumi", name: "구미", subtitle: "첨단 산업과 금오산의 도시",
            latitude: 36.1195, longitude: 128.3446, unlockRadiusMeters: 15000,
            teaser: "전자 산업 도시로 알려져 있지만, 금오산과 낙동강의 풍경은 가본 사람만 압니다.",
            fullDescription: "구미의 반전은 자연이에요. 금오산 올레길과 채미정의 가을 단풍, 케이블카로 오르는 해운사와 대혜폭포. 낙동강 체육공원의 야경 라이딩 코스는 현지인들의 숨은 휴식처입니다.",
            symbol: "cpu.fill", colorHex: "456990",
            events: [
                RegionEvent(id: "gm-e1", title: "구미 라면축제", period: "11월",
                            detail: "구미역 일대에서 열리는 이색 축제. 전국의 라면이 모이고 즉석 조리 부스가 줄을 섭니다.")
            ],
            localTips: [
                LocalTip(id: "gm-t1", author: "금오산 단골 등산객",
                         content: "금오산은 케이블카로 올라가서 걸어 내려오는 코스가 꿀입니다. 대혜폭포는 비 온 다음 날이 진짜예요.")
            ]
        ),
        Region(
            id: "gimcheon", name: "김천", subtitle: "포도와 직지사의 고장",
            latitude: 36.1398, longitude: 128.1136, unlockRadiusMeters: 15000,
            teaser: "KTX가 지나는 교통의 요지, 직지사가 있는 곳. 그 이상은 방문하면 열립니다.",
            fullDescription: "황악산 자락의 직지사는 천년 고찰의 위엄과 사계절 숲길을 함께 가진 곳이에요. 사명대사공원의 평화의 탑, 부항댐 출렁다리와 짚라인까지. 여름엔 김천 포도, 가을엔 호두과자 대신 지례 흑돼지가 정답입니다.",
            symbol: "leaf.fill", colorHex: "6A4C93",
            events: [
                RegionEvent(id: "gc-e1", title: "김천포도축제", period: "8월 말",
                            detail: "샤인머스캣 산지답게 포도 무제한 시식과 직거래 장터가 열립니다.")
            ],
            localTips: [
                LocalTip(id: "gc-t1", author: "직지사 앞 식당 주인",
                         content: "직지사는 새벽 예불 시간에 맞춰 가면 안개 낀 숲길을 혼자 걸을 수 있어요. 산채정식은 절 입구 말고 두 번째 골목 집으로.")
            ]
        ),
        Region(
            id: "daegu", name: "대구", subtitle: "골목과 미식의 대도시",
            latitude: 35.8714, longitude: 128.6014, unlockRadiusMeters: 18000,
            teaser: "경북의 한가운데 자리한 광역시. 치맥과 막창의 도시라는 것 정도만 알려져 있어요.",
            fullDescription: "대구의 진짜 매력은 골목에 있어요. 김광석다시그리기길의 버스킹, 근대골목의 100년 된 건물들, 서문시장 야시장의 불빛. 앞산 전망대에서 내려다보는 야경과 팔공산 케이블카까지 — 도시와 산이 함께 있는 곳입니다.",
            symbol: "building.2.fill", colorHex: "B03A2E",
            events: [
                RegionEvent(id: "dg-e1", title: "대구 치맥페스티벌", period: "7월 초",
                            detail: "두류공원에서 열리는 한여름 치킨+맥주 축제. 저녁 입장 줄이 길어 오후 4시 전 입장 추천.")
            ],
            localTips: [
                LocalTip(id: "dg-t1", author: "북성로 토박이",
                         content: "막창은 안지랑 곱창골목으로, 야경은 앞산 전망대로. 서문시장 야시장은 평일 저녁이 줄이 절반이에요.")
            ]
        ),
        Region(
            id: "gyeongsan", name: "경산", subtitle: "갓바위와 젊음의 대학 도시",
            latitude: 35.8250, longitude: 128.7411, unlockRadiusMeters: 13000,
            teaser: "대학이 많은 젊은 도시. 소원을 들어주는 갓바위가 있다는 것 정도만 공개되어 있어요.",
            fullDescription: "팔공산 갓바위는 '한 가지 소원은 꼭 들어준다'는 전국 최고의 기도처예요. 수능철 새벽이면 계단이 등불로 가득 찹니다. 반곡지의 봄 복사꽃, 남매지 야경, 대학가의 젊은 골목 상권까지 — 기도와 청춘이 공존하는 도시입니다.",
            symbol: "graduationcap.fill", colorHex: "8E44AD",
            events: [
                RegionEvent(id: "gs-e1", title: "자인단오제", period: "음력 5월 5일",
                            detail: "천 년을 이어온 경산 자인의 단오 축제. 여원무와 호장굿 행렬이 장관입니다.")
            ],
            localTips: [
                LocalTip(id: "gs-t1", author: "갓바위 아랫마을 주민",
                         content: "갓바위는 해 뜨기 전에 올라야 해요. 일출과 운해를 동시에 보는 날이면 소원이 벌써 이뤄진 기분이 듭니다.")
            ]
        ),
        Region(
            id: "yeongcheon", name: "영천", subtitle: "별빛과 한약의 고장",
            latitude: 35.9733, longitude: 128.9386, unlockRadiusMeters: 13000,
            teaser: "보현산 천문대가 있는 별의 도시. 나머지 이야기는 밤하늘 아래서 열립니다.",
            fullDescription: "보현산 천문대는 국내 최대 망원경이 있는 별의 성지예요. 가을밤 정상 주차장에 돗자리를 깔면 은하수가 쏟아집니다. 조선시대부터 이어진 영천한약시장의 약재 냄새, 임고서원의 500년 은행나무까지 — 하늘과 땅의 시간이 함께 흐르는 곳입니다.",
            symbol: "star.fill", colorHex: "34495E",
            events: [
                RegionEvent(id: "yc-e1", title: "보현산 별빛축제", period: "9월 말",
                            detail: "천문대 일대에서 열리는 별 관측 축제. 망원경 관측 프로그램은 조기 마감되니 예약 필수.")
            ],
            localTips: [
                LocalTip(id: "yc-t1", author: "별빛마을 펜션 주인",
                         content: "달 없는 그믐 전후로 오세요. 천문대 가는 길 중턱 전망대가 빛 공해 없이 은하수 보기 제일 좋은 자리예요.")
            ]
        ),
        Region(
            id: "sangju", name: "상주", subtitle: "자전거와 곶감의 도시",
            latitude: 36.4109, longitude: 128.1590, unlockRadiusMeters: 14000,
            teaser: "전국 유일의 자전거박물관이 있는 도시. 곶감이 유명하다는 것 정도만 알려져 있어요.",
            fullDescription: "상주는 '삼백(三白)의 고장' — 쌀, 누에, 곶감이 하얗게 빛나는 땅이에요. 경천대에서 내려다보는 낙동강 물굽이는 강 풍경의 교과서고, 자전거박물관에서 빌린 자전거로 강변길을 달리면 상주의 가을이 통째로 따라옵니다. 겨울 곶감 덕장의 주홍 커튼은 꼭 봐야 할 장면.",
            symbol: "bicycle", colorHex: "E67E22",
            events: [
                RegionEvent(id: "sj-e1", title: "상주곶감축제", period: "12월 말",
                            detail: "곶감 덕장 견학과 곶감 빨리 깎기 대회. 못난이 곶감을 반값에 살 수 있는 직거래 장터가 핵심.")
            ],
            localTips: [
                LocalTip(id: "sj-t1", author: "곶감 덕장 3대째",
                         content: "11월 말 덕장에 주홍색 곶감 커튼이 걸릴 때가 상주에서 제일 예쁜 계절이에요. 경천대 일출도 그때가 최고.")
            ]
        ),
        Region(
            id: "uiseong", name: "의성", subtitle: "마늘과 컬링의 고장",
            latitude: 36.3528, longitude: 128.6970, unlockRadiusMeters: 13000,
            teaser: "의성 마늘로 유명한 조용한 고장. '팀 킴'의 고향이라는 건 아는 사람만 압니다.",
            fullDescription: "\"영미~!\"의 고향이 바로 의성이에요. 평창올림픽 컬링 은메달 팀 킴이 자란 의성컬링센터에서는 일반인 컬링 체험도 할 수 있습니다. 3월의 산수유마을은 노란 안개가 낀 듯하고, 금성산 고분군은 신라 이전 조문국의 미스터리를 품고 있어요.",
            symbol: "circle.circle.fill", colorHex: "B9770E",
            events: [
                RegionEvent(id: "us-e1", title: "의성 산수유꽃 축제", period: "3월 말",
                            detail: "화전리 산수유마을 일대가 노랗게 물드는 봄 축제. 개화 시기에 맞춰 방문하세요.")
            ],
            localTips: [
                LocalTip(id: "us-t1", author: "의성 마늘 농부",
                         content: "컬링센터 체험은 주말 예약이 빨리 차요. 끝나고 마늘불고기 한 상이 의성의 정석 코스입니다.")
            ]
        ),
        Region(
            id: "yeongyang", name: "영양", subtitle: "별이 가장 잘 보이는 땅",
            latitude: 36.6664, longitude: 129.1124, unlockRadiusMeters: 13000,
            teaser: "고추의 고장으로 알려진 산골. 아시아 최초의 국제밤하늘보호공원이 있다는 건 비밀에 가깝습니다.",
            fullDescription: "영양 수비면은 아시아 최초로 국제밤하늘보호공원(IDA)에 지정된 곳이에요. 빛 공해가 없어 맨눈으로 은하수가 보입니다. 여름밤 반딧불이 군무, 조지훈 시인의 주실마을, 서석지의 고요한 연못까지 — 어두워서 더 빛나는 고장입니다.",
            symbol: "moon.stars.fill", colorHex: "21618C",
            events: [
                RegionEvent(id: "yy-e1", title: "영양 별빛 반딧불이 축제", period: "8월 초",
                            detail: "수비면 생태공원에서 반딧불이 탐사와 별 관측을 함께. 손전등 없이 걷는 밤길 체험이 백미.")
            ],
            localTips: [
                LocalTip(id: "yy-t1", author: "수비면 주민",
                         content: "밤하늘공원은 그믐밤에 가야 진짜예요. 차 시동 끄고 10분만 눈을 어둠에 적응시키면 은하수가 떠오릅니다.")
            ]
        ),
        Region(
            id: "cheongdo", name: "청도", subtitle: "소싸움과 감의 고장",
            latitude: 35.6474, longitude: 128.7341, unlockRadiusMeters: 13000,
            teaser: "씨 없는 감 '반시'의 고장. 소싸움 경기장이 있다는 것 정도만 알려져 있어요.",
            fullDescription: "청도는 천하장사 소들의 도시예요. 상설 소싸움 경기장에서 1톤 황소들의 박치기를 볼 수 있습니다. 와인터널에서는 감으로 만든 와인을 100년 된 기차 터널 안에서 마시고, 운문사 솔바람길은 비구니 스님들의 새벽 예불 소리와 함께 걷는 명상길입니다.",
            symbol: "pawprint.fill", colorHex: "935116",
            events: [
                RegionEvent(id: "cd-e1", title: "청도소싸움축제", period: "4월 중순",
                            detail: "전국 최강 싸움소들이 모이는 본대회. 주말 경기는 좌석 경쟁이 치열하니 오전 입장 추천.")
            ],
            localTips: [
                LocalTip(id: "cd-t1", author: "와인터널 직원",
                         content: "와인터널은 한여름에도 15도라 피서지로 최고예요. 감와인은 아이스와인 스타일이 제일 인기입니다.")
            ]
        ),
        Region(
            id: "goryeong", name: "고령", subtitle: "대가야의 옛 수도",
            latitude: 35.7261, longitude: 128.2630, unlockRadiusMeters: 12000,
            teaser: "1500년 전 대가야의 수도였던 땅. 능선 위 고분군의 풍경은 가본 사람만 압니다.",
            fullDescription: "지산동 고분군은 유네스코 세계유산이에요. 능선을 따라 줄지어 선 700여 기의 고분 사이를 걷다 보면 1500년 전 대가야의 시간 속에 들어온 기분이 듭니다. 대가야박물관의 순장 유물, 우륵이 가야금을 연주했다는 정정골까지 — 잊힌 왕국의 흔적이 도시 전체에 남아 있어요.",
            symbol: "crown.fill", colorHex: "B7950B",
            events: [
                RegionEvent(id: "gr-e1", title: "대가야축제", period: "4월 초",
                            detail: "지산동 고분군 일대에서 열리는 역사 축제. 야간 고분 미디어아트가 하이라이트.")
            ],
            localTips: [
                LocalTip(id: "gr-t1", author: "고령 문화해설사",
                         content: "고분군은 해질녘에 오르세요. 노을빛을 받은 능선의 곡선이 대가야가 남긴 가장 아름다운 유산입니다.")
            ]
        ),
        Region(
            id: "seongju", name: "성주", subtitle: "참외의 수도",
            latitude: 35.9192, longitude: 128.2829, unlockRadiusMeters: 12000,
            teaser: "전국 참외의 70%가 나는 고장. 참외 말고도 숨은 보물이 있다는 건 가봐야 압니다.",
            fullDescription: "성주 참외는 비닐하우스의 바다에서 자라요. 5월 참외 철에 농가 직판장에서 먹는 첫물 참외는 과일의 차원이 다릅니다. 성밖숲의 500년 왕버들 59그루 아래 8월이면 보라색 맥문동이 카펫처럼 깔리고, 한개마을의 돌담길은 조선시대 그대로입니다.",
            symbol: "sun.max.fill", colorHex: "D4AC0D",
            events: [
                RegionEvent(id: "sg-e1", title: "성주참외축제", period: "5월 중순",
                            detail: "참외 무제한 시식과 참외 빨리 먹기 대회. 못난이 참외 한 박스 득템 기회.")
            ],
            localTips: [
                LocalTip(id: "sg-t1", author: "참외 농가 2세",
                         content: "성밖숲 맥문동은 8월 둘째 주가 절정이에요. 아침 7시 전, 왕버들 사이로 빛이 들어올 때가 인생샷 타임.")
            ]
        ),
        Region(
            id: "chilgok", name: "칠곡", subtitle: "낙동강 호국의 고장",
            latitude: 35.9955, longitude: 128.4017, unlockRadiusMeters: 13000,
            teaser: "낙동강 방어선의 격전지였던 땅. 강과 함께 흐르는 이야기는 방문하면 열립니다.",
            fullDescription: "칠곡은 6.25 전쟁의 운명을 가른 낙동강 방어선의 중심이에요. 다부동전적기념관과 호국평화기념관에서 55일간의 격전을 만나고, 왜관철교(호국의 다리)를 걸어서 건널 수 있습니다. 가산산성 숲길과 송정자연휴양림은 격전지였다고 믿기지 않을 만큼 평화롭습니다.",
            symbol: "shield.fill", colorHex: "5D6D7E",
            events: [
                RegionEvent(id: "cg-e1", title: "낙동강세계평화문화대축전", period: "10월 초",
                            detail: "호국평화기념관 일대에서 열리는 평화 축제. 야간 미디어파사드와 불꽃쇼가 볼거리.")
            ],
            localTips: [
                LocalTip(id: "cg-t1", author: "왜관 주민",
                         content: "호국의 다리는 해 질 무렵 걸으세요. 낙동강 노을과 철교의 실루엣이 칠곡 최고의 풍경입니다.")
            ]
        ),
        Region(
            id: "yecheon", name: "예천", subtitle: "물돌이 회룡포의 고장",
            latitude: 36.6546, longitude: 128.4517, unlockRadiusMeters: 13000,
            teaser: "활의 고장이자 회룡포 물돌이마을이 있는 곳. 350도 휘감아 도는 강의 풍경은 직접 봐야 합니다.",
            fullDescription: "회룡포는 낙동강 지류 내성천이 마을을 350도 휘감아 도는 기적의 지형이에요. 회룡대에 오르면 모래사장에 안긴 마을이 한눈에 들어옵니다. 출렁이는 뿅뿅다리를 건너 마을로 들어가고, 삼강주막에서 막걸리 한 사발 — 그리고 용궁역 순대골목로 마무리하는 코스가 정석입니다.",
            symbol: "arrow.triangle.2.circlepath", colorHex: "17A589",
            events: [
                RegionEvent(id: "yh-e1", title: "예천세계활축제", period: "9월 초",
                            detail: "활의 고장답게 국궁·양궁 체험이 가득한 축제. 진호국제양궁장에서 올림픽 선수들이 훈련합니다.")
            ],
            localTips: [
                LocalTip(id: "yh-t1", author: "회룡포 마을 주민",
                         content: "회룡대 전망은 비 온 다음 날 오전이 최고예요. 물안개가 걷히면서 모래톱이 드러나는 순간을 노리세요.")
            ]
        ),
        Region(
            id: "bonghwa", name: "봉화", subtitle: "산타마을과 송이의 고장",
            latitude: 36.8930, longitude: 128.7325, unlockRadiusMeters: 14000,
            teaser: "오지 산골로 알려진 곳. 기차로만 갈 수 있는 산타마을이 숨어 있습니다.",
            fullDescription: "분천역 산타마을은 한겨울 동화 속 마을이에요. 백두대간 협곡열차(V-train)를 타고 굽이굽이 들어가면 산타와 루돌프가 기다립니다. 국립백두대간수목원에는 백두산호랑이가 살고, 청량산 하늘다리는 해발 800m 협곡을 가로지릅니다. 가을 송이축제 때는 온 산이 향기롭습니다.",
            symbol: "gift.fill", colorHex: "1E8449",
            events: [
                RegionEvent(id: "bh-e1", title: "봉화송이축제", period: "9월 말 ~ 10월 초",
                            detail: "자연산 송이 채취 체험과 송이돌솥밥. 송이는 축제 첫날 오전 직거래 장터가 가장 신선합니다.")
            ],
            localTips: [
                LocalTip(id: "bh-t1", author: "분천역 앞 가게 주인",
                         content: "산타마을은 눈 오는 12월 평일이 가장 동화 같아요. 협곡열차 창가 자리는 낙동강 협곡 쪽으로 예약하세요.")
            ]
        ),
        Region(
            id: "uljin", name: "울진", subtitle: "금강송과 바다의 고장",
            latitude: 36.9930, longitude: 129.4006, unlockRadiusMeters: 15000,
            teaser: "동해 최북단 경북의 끝. 500년 금강송 숲과 2억 5천만 년 된 동굴이 숨어 있습니다.",
            fullDescription: "울진 금강송 군락지는 조선 왕실이 봉인했던 숲이에요. 하루 80명만 예약으로 들어갈 수 있는 대왕소나무 숲길은 한국에서 가장 깊은 숲 체험입니다. 성류굴의 2억 5천만 년 석회암 종유석, 죽변항 곰치국, 덕구온천 원탕까지 — 산과 바다와 땅속이 모두 비경입니다.",
            symbol: "fossil.shell.fill", colorHex: "2471A3",
            events: [
                RegionEvent(id: "uj-e1", title: "울진대게와 붉은대게 축제", period: "2월 말",
                            detail: "후포항 일대에서 열리는 대게 축제. 영덕보다 한산해서 같은 품질을 더 여유롭게 즐길 수 있어요.")
            ],
            localTips: [
                LocalTip(id: "uj-t1", author: "금강송면 산림해설사",
                         content: "대왕소나무 숲길은 한 달 전 예약이 필수예요. 새벽 안개 낀 금강송 숲은 평생 잊지 못할 겁니다.")
            ]
        )
    ]

    static let audioStories: [AudioStory] = [
        AudioStory(
            id: storyGyeongju1, regionID: "gyeongju", author: "황남동 할머니",
            title: "대릉원 돌담길, 60년 전 이야기",
            transcript: "내가 처음 시집왔을 때는 이 고분들 사이로 소달구지가 다녔어요. 지금 젊은 사람들이 사진 찍는 그 돌담길이, 옛날엔 우리 빨래터 가는 길이었지. 능 사이로 보름달이 뜨면 온 동네가 은빛이 됐는데, 그 풍경은 지금도 그대로예요.",
            durationText: "0:42", fileName: nil, isMine: false
        ),
        AudioStory(
            id: storyGyeongju2, regionID: "gyeongju", author: "여행자 미주",
            title: "첨성대 핑크뮬리 일몰",
            transcript: "10월의 첨성대는 진짜 말도 안 돼요. 핑크뮬리가 노을빛을 받아서 솜사탕처럼 변하는 순간, 카메라를 내려놓고 그냥 바라보게 됐어요. 꼭 해 질 무렵에 가세요.",
            durationText: "0:28", fileName: nil, isMine: false
        ),
        AudioStory(
            id: storyPohang1, regionID: "pohang", author: "호미곶 등대지기",
            title: "상생의 손이 세워진 날",
            transcript: "1999년 12월, 새천년을 앞두고 저 손이 바다에 세워졌어요. 해가 뜨면 손바닥 위에 해를 올려놓은 것처럼 보이는데, 그건 설계가 아니라 우연이었답니다. 갈매기들이 손가락 끝에 한 마리씩 앉는 아침이 제일 예뻐요.",
            durationText: "0:51", fileName: nil, isMine: false
        ),
        AudioStory(
            id: storyAndong1, regionID: "andong", author: "하회마을 뱃사공",
            title: "부용대 아래 나룻배",
            transcript: "하회마을과 부용대 사이엔 다리가 없어요. 그래서 내가 노를 젓지. 강을 건너는 3분 동안 마을이 점점 멀어지면서 한 폭의 그림이 되는데, 그 장면을 보여주는 게 내 일이에요. 안개 낀 아침 첫 배가 제일 좋습니다.",
            durationText: "0:47", fileName: nil, isMine: false
        ),
        AudioStory(
            id: storyYeongdeok1, regionID: "yeongdeok", author: "강구항 경매사",
            title: "새벽 4시, 대게 경매장",
            transcript: "새벽 4시 강구항 위판장은 전쟁터예요. 손가락 신호 하나로 수백만 원이 오가죠. 일반 관광객도 구경할 수 있는데, 경매 끝나고 상인들이 먹는 새벽 국밥집이 진짜 맛집입니다.",
            durationText: "0:38", fileName: nil, isMine: false
        ),
        AudioStory(
            id: storyUlleung1, regionID: "ulleung", author: "도동항 해녀",
            title: "물질 50년, 울릉도 바다",
            transcript: "울릉도 바다는 육지 바다랑 달라요. 10미터 아래가 훤히 보이지. 50년을 들어가도 매번 다른 바다예요. 태풍 지나간 다음 날 바다가 제일 맑은데, 그날 도동 해안산책로를 걸어보세요. 바닥까지 비치는 옥빛 바다를 볼 수 있어요.",
            durationText: "0:55", fileName: nil, isMine: false
        ),
        AudioStory(
            id: storyMungyeong1, regionID: "mungyeong", author: "새재 문화해설사",
            title: "과거길을 걷던 선비들",
            transcript: "조선 시대 영남 선비들은 한양 과거 보러 갈 때 꼭 이 길로 갔어요. 추풍령으로 가면 추풍낙엽처럼 떨어지고, 죽령으로 가면 죽죽 미끄러진다고 믿었거든요. 문경새재는 '경사스러운 소식을 듣는 고개'라서, 지금도 수험생 부모님들이 걷는 길입니다.",
            durationText: "0:49", fileName: nil, isMine: false
        ),
        AudioStory(
            id: storyDaegu1, regionID: "daegu", author: "서문시장 칼국수 골목 상인",
            title: "칼국수 골목 40년",
            transcript: "서문시장 칼국수 골목은 새벽 4시부터 반죽을 시작해요. 40년을 똑같은 자리에서 면을 뽑았는데, 단골 손님 아들이 이제 자기 아들을 데리고 와요. 야시장 불이 켜지면 골목이 제일 예쁜데, 그때 와서 칼국수에 납작만두 하나 곁들여 보세요.",
            durationText: "0:46", fileName: nil, isMine: false
        )
    ]

    static let posts: [FeedPost] = [
        FeedPost(
            id: "p1", author: "바다소년", authorBadge: "포항 현지인", regionID: "pohang",
            text: "오늘 아침 영일대. 해무가 걷히면서 해상누각이 떠오르는 순간을 봤다. 포항 사람도 매일 보는 풍경에 가끔 숨이 멎는다.",
            timeAgo: "2시간 전", likes: 128, comments: 14, audioStoryID: storyPohang1,
            photo: PostPhoto(symbol: "sunrise.fill", caption: "영일대 해상누각",
                             topColorHex: "87CEEB", bottomColorHex: "2E86AB")
        ),
        FeedPost(
            id: "p2", author: "한옥스테이러", authorBadge: "여행자", regionID: "gyeongju",
            text: "경주 3일 차. 황리단길보다 황남동 뒷골목이 좋아졌다. 담장 너머로 능이 보이는 도시는 세계 어디에도 없을 듯.",
            timeAgo: "5시간 전", likes: 256, comments: 31, audioStoryID: storyGyeongju2,
            photo: PostPhoto(symbol: "building.columns.fill", caption: "황남동 한옥 골목",
                             topColorHex: "E0B475", bottomColorHex: "8E5B3A")
        ),
        FeedPost(
            id: "p7", author: "경주밤산책", authorBadge: "경주 현지인", regionID: "gyeongju",
            text: "퇴근하고 동궁과 월지 한 바퀴. 연못에 비친 누각은 천 번을 봐도 천 번 다 다르다. 오늘은 바람이 없어서 수면이 거울이었다.",
            timeAgo: "8시간 전", likes: 312, comments: 27, audioStoryID: storyGyeongju1,
            photo: PostPhoto(symbol: "moon.stars.fill", caption: "동궁과 월지 야경",
                             topColorHex: "2C3E50", bottomColorHex: "4A235A")
        ),
        FeedPost(
            id: "p3", author: "안동토박이", authorBadge: "안동 현지인", regionID: "andong",
            text: "탈춤 축제 준비가 시작됐다. 올해는 하회별신굿 전 마당을 다 올린다고. 9월에 오는 사람들은 운이 좋은 거다.",
            timeAgo: "1일 전", likes: 89, comments: 8, audioStoryID: storyAndong1,
            photo: PostPhoto(symbol: "theatermasks.fill", caption: "부용대에서 본 하회마을",
                             topColorHex: "A3C585", bottomColorHex: "5B8C5A")
        ),
        FeedPost(
            id: "p4", author: "섬사람", authorBadge: "울릉도 현지인", regionID: "ulleung",
            text: "오늘 파도 0.5m. 이런 날 관음도 데크길을 걸으면 바다 위를 걷는 기분이다. 내일 배 타고 들어오는 분들 날씨 운 최고.",
            timeAgo: "1일 전", likes: 167, comments: 19, audioStoryID: storyUlleung1,
            photo: PostPhoto(symbol: "sailboat.fill", caption: "관음도 데크길",
                             topColorHex: "48CAE4", bottomColorHex: "1B6CA8")
        ),
        FeedPost(
            id: "p5", author: "트레킹조아", authorBadge: "여행자", regionID: "mungyeong",
            text: "문경새재 맨발 걷기 완주! 1관문에서 3관문까지 황톳길 6.5km. 발바닥은 얼얼한데 머리는 맑아진다. 이 맛에 걷는구나.",
            timeAgo: "2일 전", likes: 203, comments: 22, audioStoryID: storyMungyeong1,
            photo: PostPhoto(symbol: "figure.hiking", caption: "문경새재 황톳길",
                             topColorHex: "D2B48C", bottomColorHex: "8B5A2B")
        ),
        FeedPost(
            id: "p6", author: "게잡이아들", authorBadge: "영덕 현지인", regionID: "yeongdeok",
            text: "아버지 배가 새벽에 들어왔다. 올해 대게 속이 꽉 찼다. 2월 축제 때까지 이 시세면 다들 배 터지게 먹을 수 있을 듯.",
            timeAgo: "3일 전", likes: 94, comments: 11, audioStoryID: storyYeongdeok1,
            photo: PostPhoto(symbol: "fish.fill", caption: "강구항 새벽 위판장",
                             topColorHex: "5D6D7E", bottomColorHex: "273746")
        ),
        FeedPost(
            id: "p8", author: "물회한그릇", authorBadge: "여행자", regionID: "pohang",
            text: "죽도시장 2층 물회. 살얼음 육수에 고추장 풀어서 한 입 — 여름 포항은 이거 먹으러 오는 거다.",
            timeAgo: "3일 전", likes: 145, comments: 16, audioStoryID: nil,
            photo: PostPhoto(symbol: "fork.knife", caption: "죽도시장 물회",
                             topColorHex: "FF9966", bottomColorHex: "D1495B")
        ),
        FeedPost(
            id: "p9", author: "사찰여행가", authorBadge: "여행자", regionID: "yeongju",
            text: "부석사 무량수전 앞. 배흘림기둥에 기대 소백산맥으로 지는 해를 봤다. 천 년 전 사람들도 이 자리에서 같은 노을을 봤겠지.",
            timeAgo: "4일 전", likes: 278, comments: 25, audioStoryID: nil,
            photo: PostPhoto(symbol: "sun.dust.fill", caption: "부석사 무량수전 노을",
                             topColorHex: "F39C12", bottomColorHex: "7D6B91")
        ),
        FeedPost(
            id: "p10", author: "새벽사진사", authorBadge: "여행자", regionID: "cheongsong",
            text: "새벽 5시 주산지. 물안개가 왕버들을 감싸는 30분을 위해 밤새 달려왔다. 후회 없음.",
            timeAgo: "5일 전", likes: 421, comments: 38, audioStoryID: nil,
            photo: PostPhoto(symbol: "cloud.fog.fill", caption: "주산지 새벽 물안개",
                             topColorHex: "B8C6DB", bottomColorHex: "5D6D7E")
        ),
        FeedPost(
            id: "p11", author: "라이딩맨", authorBadge: "구미 현지인", regionID: "gumi",
            text: "낙동강 야경 라이딩 코스 공유. 동락공원에서 출발해서 강변 따라 10km. 밤바람 맞으면서 달리면 하루 스트레스 리셋.",
            timeAgo: "6일 전", likes: 76, comments: 9, audioStoryID: nil,
            photo: PostPhoto(symbol: "bicycle", caption: "낙동강 야경 라이딩",
                             topColorHex: "34495E", bottomColorHex: "456990")
        ),
        FeedPost(
            id: "p12", author: "산사의아침", authorBadge: "김천 현지인", regionID: "gimcheon",
            text: "직지사 새벽 예불 다녀오는 길. 안개 낀 전나무 숲길을 혼자 걸었다. 이 시간의 직지사는 아는 사람만 안다.",
            timeAgo: "1주 전", likes: 132, comments: 12, audioStoryID: nil,
            photo: PostPhoto(symbol: "tree.fill", caption: "직지사 전나무 숲길",
                             topColorHex: "7DCEA0", bottomColorHex: "145A32")
        ),
        FeedPost(
            id: "p13", author: "대프리카생존자", authorBadge: "대구 현지인", regionID: "daegu",
            text: "서문시장 야시장 개장. 불 켜진 골목에 칼국수 김이 피어오르면 대구의 밤이 시작된다. 납작만두는 필수.",
            timeAgo: "4시간 전", likes: 287, comments: 33, audioStoryID: storyDaegu1,
            photo: PostPhoto(symbol: "flame.fill", caption: "서문시장 야시장",
                             topColorHex: "F39C12", bottomColorHex: "B03A2E")
        ),
        FeedPost(
            id: "p14", author: "소원하나", authorBadge: "여행자", regionID: "gyeongsan",
            text: "새벽 4시 반, 갓바위 계단을 올랐다. 일출과 운해를 동시에 만난 날. 소원은 이미 이뤄진 것 같다.",
            timeAgo: "1일 전", likes: 198, comments: 21, audioStoryID: nil,
            photo: PostPhoto(symbol: "sun.max.fill", caption: "팔공산 갓바위 일출",
                             topColorHex: "FAD7A0", bottomColorHex: "8E44AD")
        ),
        FeedPost(
            id: "p15", author: "산타우체부", authorBadge: "봉화 현지인", regionID: "bonghwa",
            text: "분천역에 첫눈. 산타마을 불이 켜지고 협곡열차가 눈을 달고 들어온다. 겨울 봉화는 동화책 속 페이지다.",
            timeAgo: "2일 전", likes: 356, comments: 41, audioStoryID: nil,
            photo: PostPhoto(symbol: "gift.fill", caption: "분천역 산타마을",
                             topColorHex: "AED6F1", bottomColorHex: "1E8449")
        ),
        FeedPost(
            id: "p16", author: "솔숲걷는사람", authorBadge: "여행자", regionID: "uljin",
            text: "한 달 전에 예약한 금강송 대왕소나무 숲길. 500년 소나무 앞에 서니 말이 안 나온다. 숲의 왕을 알현하고 왔다.",
            timeAgo: "5일 전", likes: 243, comments: 18, audioStoryID: nil,
            photo: PostPhoto(symbol: "tree.fill", caption: "금강송 대왕소나무",
                             topColorHex: "82E0AA", bottomColorHex: "0E6655")
        ),
        FeedPost(
            id: "p17", author: "참외밭막내", authorBadge: "성주 현지인", regionID: "seongju",
            text: "성밖숲 맥문동이 절정이다. 500년 왕버들 아래 보라색 카펫. 아침 7시의 빛이 제일 예쁘다.",
            timeAgo: "6일 전", likes: 312, comments: 29, audioStoryID: nil,
            photo: PostPhoto(symbol: "camera.macro", caption: "성밖숲 맥문동",
                             topColorHex: "D7BDE2", bottomColorHex: "76448A")
        )
    ]
}

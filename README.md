# 🎯 [RIVAL] pixel-hub (Private Version)

![Lua](https://img.shields.io/badge/Language-Lua-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Roblox-red.svg)
![Support](https://img.shields.io/badge/Support-PC%20%2F%20Mobile-green.svg)

**pixel-hub**는 로블록스 게임 'Rivals'를 위해 설계된 고성능 올인원 스크립트 허브입니다. 최적화된 UI와 강력한 모듈화 시스템을 통해 PC와 아이패드(모바일) 환경 모두에서 최고의 성능을 발휘합니다.

---

##  주요 기능 (Features)

###  Combat (전투)
*   **Aimbot:** 가장 가까운 적을 자동으로 조준하는 정밀 로직.
*   **FOV Circle:** 조준 범위를 화면에 표시하고 크기 및 색상(HEX) 커스텀 가능.

###  Movement (이동)
*   **Walk Speed & Jump Height:** 캐릭터의 이동 속도와 점프 높이를 자유롭게 조절.
*   **Fly Hack:** 비행 기능을 통해 맵 전체를 자유롭게 이동 (PC 키보드 최적화).
*   **No-Clip:** 모든 벽과 오브젝트를 통과하는 물리 무력화 기능.

###  Visuals (시각)
*   **ESP (Highlight & Name):** 벽 뒤에 있는 적을 박스 하이라이트와 이름표로 실시간 표시.
*   **Color Customization:** 사용자 취향에 맞는 ESP 색상 설정.

###  Security (보안)
*   **Built-in Bypass:** 안티치트의 실시간 속성 감지를 우회하는 메타테이블 후킹 시스템 탑재.
*   **Authentication:** 전용 액세스 토큰을 통한 비인가 사용 차단.

---

## 🛠️ 실행 방법 (Usage)

로블록스 실행기(Executor)의 에디터 창에 아래 코드를 복사하여 실행하세요.

```lua
loadstring(game:HttpGet("[https://raw.githubusercontent.com/asp1-rin/rivals-pixel-hub/main/src/main.lua](https://raw.githubusercontent.com/asp1-rin/rivals-pixel-hub/main/src/main.lua)"))()

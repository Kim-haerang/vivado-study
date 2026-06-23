# TFT display 실습

TFT display 출력을 위해 horizontal/vertical timing, RGB 출력, BRAM image data 흐름을 연결한 Verilog 실습입니다.

## 구성 파일

| 파일 | 설명 |
| --- | --- |
| `top.v` | TFT display 상위 연결 모듈 |
| `horizontal.v` | 수평 timing과 Hsync 생성 |
| `vertical.v` | 수직 timing과 Vsync 생성 |
| `rgb.v` | 화면 영역에 따른 RGB 출력 생성 |
| `BRAMCtrl.v` | BRAM 주소와 image data 흐름 제어 |
| `clkdiv.v` | clock division 예제 |

## 핵심 개념

- TFT-LCD sync timing
- Hsync / Vsync / Data Enable
- RGB 신호 생성
- BRAM 기반 이미지 출력 구조
- Vivado IP 또는 board 설정과의 연결

## 참고

원본 Vivado 프로젝트에는 `.coe`, IP, generated file이 함께 있었지만, 이 저장소에는 직접 확인하기 쉬운 Verilog 소스만 선별했습니다.

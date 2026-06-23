# 초음파 센서 + LCD 실습

초음파 센서의 echo pulse를 측정해 거리 값을 계산하고, 계산한 값을 LCD 표시 흐름으로 연결하는 Verilog 실습입니다.

## 구성 파일

| 파일 | 설명 |
| --- | --- |
| `us_range.v` | 초음파 센서 trigger/echo 제어와 cm 단위 거리 계산 |
| `counter1mh.v` | 1us tick 생성을 위한 counter |
| `counter_clcd.v` | character LCD 제어용 counter |
| `decoder.v` | LCD 출력 데이터 변환 |
| `top.v` | 센서, counter, LCD 관련 모듈 연결 |

## 핵심 개념

- 초음파 센서 trigger pulse 생성
- echo pulse width 측정
- `echo_pulse / 58`을 이용한 cm 단위 거리 계산
- ASCII digit 변환
- LCD 출력 모듈 연결

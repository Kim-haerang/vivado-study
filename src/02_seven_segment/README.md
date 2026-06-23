# Seven-segment display 실습

4자리 seven-segment display에 16-bit 데이터를 표시하는 Verilog 실습입니다.

## 구성 파일

| 파일 | 설명 |
| --- | --- |
| `hex2seg.v` | 4-bit hex 값을 seven-segment 출력 패턴으로 변환 |
| `seven_seg.v` | 자리 선택과 segment 출력을 시간 분할 방식으로 제어 |
| `top.v` | 상위 모듈 연결 |

## 핵심 개념

- Hex-to-seven-segment decoder
- 자리 선택을 위한 multiplexing
- clock counter 기반 display refresh
- top module에서 하위 모듈 연결

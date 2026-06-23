# Verilog / Vivado 학습 기록

Verilog와 Xilinx Vivado를 사용해 디지털 회로, FPGA 주변장치, 간단한 SoC/IP 흐름을 학습한 기록입니다. 원본 Vivado 작업 폴더에는 자동 생성 파일이 많기 때문에, GitHub에는 직접 작성한 Verilog 소스와 제약 파일, 실습 설명 중심으로 정리하는 것을 목표로 합니다.

## 프로젝트 개요

원본 학습 폴더: `D:\vivado_code`

확인된 실습 주제는 다음과 같습니다.

- Counter와 clock divider
- Seven-segment display 제어
- Text LCD
- 초음파 센서 거리 측정
- TFT/VGA 방식 display 제어
- AXI custom IP 실습
- Zynq/SoC block design 기반 프로젝트

## 권장 폴더 구조

```text
verilog-vivado-study/
  README.md
  docs/
    images/
    notes/
  src/
    01_counter/
    02_seven_segment/
    03_text_lcd/
    04_ultrasonic_sensor/
    05_tft_display/
    06_axi_custom_ip/
    07_soc_projects/
  constraints/
  reports/
```

## 실습 목록

| 주제 | 원본 폴더 예시 | 주요 개념 |
| --- | --- | --- |
| Vivado tutorial | `ch1_vivado_tutorial` | 기본 프로젝트 흐름, counter |
| Seven-segment | `project_10_seg_fpga`, `project_10_soc` | decoder, display control, top module |
| Text LCD | `project_11_soc`, `project_0515_1` | LCD interface, AXI IP practice |
| 초음파 센서 | `project_0522_ARM`, `final_project/sonic_lcd` | sensor timing, distance calculation, display output |
| TFT display | `lab13_tft_fpga`, `final_project/tft` | RGB signal, horizontal/vertical timing, BRAM control |
| AXI/IP | `ip_repo`, `project_13_soc` | register set, dual RAM, AXI peripheral structure |

## 대표 소스 파일

원본 작업 폴더에서 확인한 예시 파일입니다.

- `counter15.v`
- `counter.v`
- `decoder.v`
- `hex2seg.v`
- `seven_seg.v`
- `top.v`
- `counter1mh.v`
- `counter_clcd.v`
- `us_range.v`
- `BRAMCtrl.v`
- `clkdiv.v`
- `horizontal.v`
- `vertical.v`
- `rgb.v`
- `axi_dualram_v1_0.v`
- `register_set_v1_0.v`
- `textlcd_v1_0.v`

## 실습별 정리 방법

각 실습 폴더는 아래처럼 정리하는 것을 권장합니다.

```text
topic_name/
  README.md
  src/
    module.v
    top.v
  constraints/
    board.xdc
  docs/
    waveform_or_board_photo.png
```

각 실습 README에는 아래 내용을 짧게 적습니다.

- 무엇을 구현했는가?
- 사용한 보드 또는 Vivado 버전은 무엇인가?
- 주요 모듈은 무엇인가?
- 어떤 입력/출력 핀 또는 주변장치를 사용했는가?
- 이 실습에서 무엇을 배웠는가?

## GitHub 업로드 기준

올릴 파일:

- 직접 작성한 `.v`, `.sv`, `.vhd`, `.xdc`
- 짧은 노트와 구조도
- waveform, 보드 동작 사진, block design 스크린샷
- 실습별 README

올리지 않을 파일:

- `.cache`, `.hw`, `.runs`, `.sim`, `.gen`, `.Xil`
- Vivado 전체 빌드 산출물
- `.bit`, `.dcp`, `.wdb`, `.xsa`, `.elf`, `.o`, `.jou`, `.log`

## 배운 점

- Verilog module 구조와 top module 연결 방식
- 조합논리와 순차논리의 차이
- clock division, counter, display timing 구현 방법
- FPGA pin constraints와 하드웨어 I/O 매핑
- AXI custom IP와 SoC 프로젝트의 기본 구조
- Vivado 자동 생성물과 직접 작성한 소스 코드를 분리해야 하는 이유

# Verilog / Vivado 학습 기록

Verilog HDL을 사용해 디지털 회로, FPGA 주변장치, AXI IP 개발을 실습한 기록입니다. 보드: Xilinx Ultra96-V2 (Vivado). Vivado 작업 폴더에는 자동 생성 파일이 많기 때문에 직접 작성한 Verilog 소스와 제약 파일 중심으로 정리했습니다.

원본 학습 폴더: D:\vivado_code

## 폴더 구조

```text
verilog-vivado-study/
  src/
    02_seven_segment/   4자리 seven-segment 제어
    03_text_lcd/        Text LCD AXI IP (SoC)
    04_ultrasonic_sensor_lcd/  초음파 센서 + LCD 출력
    05_tft_display/     TFT display timing + BRAM
    06_axi_ip/          AXI Peripheral IP 개발
  constraints/
  docs/notes/
  reports/
```n
## 실습 목록

| 번호 | 주제 | 주요 내용 |
| --- | --- | --- |
| 01 | Vivado tutorial | 기본 프로젝트 흐름, counter 구조 파악 |
| 02 | Seven-segment | decoder, top module, 4자리 표시 |
| 03 | Text LCD (SoC) | AXI IP wrapper, 8레지스터 AXI-Lite slave |
| 04 | 초음파 센서 LCD | sensor timing, 1MHz counter, LCD 출력 |
| 05 | TFT display | RGB 신호, horizontal/vertical timing, BRAM 제어 |
| 06 | AXI IP 개발 | register_set, axi_dualram - custom peripheral 구현 |

## 소스 파일 목록

| 폴더 | 파일 | 설명 |
| --- | --- | --- |
| 02_seven_segment | hex2seg.v, seven_seg.v, top.v | 4자리 FND 제어 |
| 03_text_lcd | textlcd_v1_0.v | AXI IP top (8개 레지스터 출력) |
| 03_text_lcd | textlcd_v1_0_S00_AXI.v | AXI-Lite slave, 8x32bit 레지스터 구현 |
| 04_ultrasonic_sensor_lcd | counter1mh.v, counter_clcd.v, decoder.v, top.v, us_range.v | 초음파 + LCD |
| 05_tft_display | BRAMCtrl.v, clkdiv.v, horizontal.v, rgb.v, top.v, vertical.v | TFT 타이밍 |
| 06_axi_ip | register_set_v1_0.v | source_sel, vsel 제어 레지스터 IP |
| 06_axi_ip | register_set_v1_0_S00_AXI.v | 4레지스터 AXI-Lite slave 구현 |
| 06_axi_ip | axi_dualram_v1_0.v | BRAM 접근용 AXI IP (addra, dina, ena, wea) |
| 06_axi_ip | axi_dualram_v1_0_S00_AXI.v | 4레지스터 AXI-Lite slave 구현 |

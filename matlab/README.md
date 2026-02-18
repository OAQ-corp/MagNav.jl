# MATLAB Port

MagNav.jl를 MATLAB로 옮기기 위한 폴더입니다.

## 구성

### 1) 수동 검증 포트 (`+magnav`)

아래 함수는 사람이 직접 옮겨서 바로 사용 가능한 상태입니다.

- `+magnav/euler2dcm.m`
- `+magnav/dcm2euler.m`
- `+magnav/correct_Cnb.m`

실행 예시:

```matlab
addpath(genpath('matlab'));

dcm = magnav.euler2dcm(0.01, -0.02, 1.0);
[roll, pitch, yaw] = magnav.dcm2euler(dcm);
```

### 2) 전체 함수 포트 드래프트 (`+magnav_fullport`)

- `src/*.jl`의 모든 top-level function을 자동 변환해 `+magnav_fullport/*.m`로 생성합니다.
- 현재 생성 함수 수/수동 디버깅 필요 라인 수는 `PORT_STATUS.md`에 기록됩니다.

재생성:

```bash
python matlab/port_julia_to_matlab.py
```

## 실제 실행/디버깅 방법

1. MATLAB에서:

```matlab
addpath(genpath('matlab'));
results = run_fullport_debug_check;
```

2. `checkcode` 결과(파서/린트)를 통해 파일별 이슈를 확인합니다.
3. `PORT_STATUS.md`에서 TODO가 많은 함수부터 우선 정리합니다.
4. 정리 완료된 함수는 `+magnav`로 승격해서 정식 함수로 관리합니다.

## 권장 이관 순서

1. DCM/INS 수학 함수
2. 맵 입출력 및 보간
3. 보상/모델 함수
4. EKF/NEKF/MPF
5. 시각화/리포팅

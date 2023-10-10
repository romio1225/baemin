# Hyperdata OnPrem 설치 가이드

## version

- ubuntu 20.04 LTS
- kubernetes 1.19.10

## Install Order

1. [ingress-nginx](./ingress-nginx-uptodate)
2. [tibero](./tibero)
3. [be_common](./hyperdata-be-common)
4. [ozone](./ozone)
5. [hive](./hive)
6. [mysql(in mlplatform)](./mlplatform)
7. [hyperdata_fe](./hyperdata-fe)
8. [system_management](./system_management)
9. [virtualization](./virtualization)
10. [flow](./flow)
11. [visual_analytics](./visualanalytics)
12. [mlplatform](./mlplatform)

<br>

- 모든 `--set`은 `values.yaml`에 적어놨음.
- 단, ingress-nginx, istio, knative, kserve, argo 등 오픈소스 프로젝트는 `values.yaml`이 길기때문에 기존처럼 `--set`으로 셋팅해줄 값 적어놓음.

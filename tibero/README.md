# Tibero 배달공제 버전 설치

0. 배달공제는 tibero를 클라우드팀에서 설치해준 통합DB tibero를 사용함. 따라서, pvc만 활용을 위해 tibero helm으로 설치 후, 제대로 설치 확인하고 helm delete로 삭제해주면 됨. pvc는 남아있기때문.

1. install tibero

   ```
   helm install -n maads-stg-bi tibero tibero
   ```

2. delete tibero(제대로 설치된지 확인후)
   ```
   helm delete -n maads-stg-bi tibero tibero
   ```

#

#

# tibero

1. install tibero

   1.1 LoadBalancer 사용시

   ```
   helm install -n hyperdata tibero tibero \
    --set image=${HARBOR_URL}/${HARBOR_REPO}/${IMAGE_NAME}:${TAG} \
    --set loadbalancer.ip=${LOADBALANCER_IP}
   ```

   1.2 NodePort 사용시

   ```
   helm install -n hyperdata tibero tibero \
   --set image=${HARBOR_URL}/${HARBOR_REPO}/${IMAGE_NAME}:${TAG} \
   --set loadbalancer.enabled=false
   ```

2. Uninstall tibero

```
helm uninstall -n hyperdata tibero tibero
```

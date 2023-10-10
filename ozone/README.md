# Ozone 배달공제 버전 설치

1.  create namespace for hyperdata if not exist

    ```
    helm install -n maads-stg-bi ozone ozone
    ```

2.  ozone 파드 재기동 시, 파이프라인 바로 안잡히는 이유:  
    ozone을 쿠버네티스로 띄워서 파드ip가 변동되기때문. 따라서 파드ip를 고정시켜주면 됨.

    ```
      template:
        metadata:
          labels:
            app: ozone
            component: datanode
          annotations:
            prometheus.io/scrape: "true"
            prometheus.io/port: "9882"
            prometheus.io/path: /prom
            "cni.projectcalico.org/ipAddrs": '["10.244.67.72"]'
    ```

    - 각 statefulset에 빈 파드ip를  
      위 내용 annotations 가장 아랫줄처럼 작성해주면 됨.

#

#

# Ozone

1. install ozone

```
helm install -n hyperdata ozone ozone \
--set image=${HARBOR_URL}/${HARBOR_REPO}/${IMAGE_NAME}:${TAG} \
--set datanode.storage.size=100Gi
```

2. Uninstall ozone

```
helm uninstall -n hyperdata ozone ozone
```

## ref

- https://github.com/apache/ozone

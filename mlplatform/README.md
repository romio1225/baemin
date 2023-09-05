# 사전 설치 항목들
## istio, cert-manger, knative-serving, kserve 를 한번에 설치

1. quick_install.sh 를 통해 설치
   ```
   bash quick_install.sh
   ```
   cf) 만약 kserve까지 웃음마크가 안떠도 다시 계속 위 명령어를 입력하여 설치 완료한다.
   ```
   ...
   ...
   clusterservingruntime.serving.kserve.io/kserve-tritonserver unchanged
   clusterservingruntime.serving.kserve.io/kserve-xgbserver unchanged
   😀 Successfully installed KServe
   ```

## argo는 바로 상위 폴더에서 argo 폴더에서 기존 설치가이드대로 설치하면 됨.

#
#

# mlplatform

1. 이미지에는 희망하는 이미지를 사용하시면 됩니다.

   1) mysql 
   ```
   helm install -n hyperdata ml-mysql ml-mysql \
   --set mysql.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/mysql:20230623_v1
   ```

   2-1) enable registriesSkippingTagResolving (구 버전)
   ```
   kubectl get cm -n knative-serving config-deployment -o yaml | \
   sed -z "s/\ndata:\n/\ndata:\n  registriesSkippingTagResolving: \"${REGISTRY_IP}:${REGISTRY_PORT}\"\n/g" | \
   kubectl apply -f -
   ```

   2-2) enable registriesSkippingTagResolving (신 버전)
   ```
   kubectl get cm -n knative-serving config-deployment -o yaml | \
   sed -z "s/\ndata:\n/\ndata:\n  registries-skipping-tag-resolving: \"biqa.tmax.com\"\n/g" | \
   kubectl apply -f -
   ```
      cf) # List of repositories for which tag to digest resolving should be skipped
            registries-skipping-tag-resolving: "kind.local,ko.local,dev.local"
   

   3-1) mlplatform - NodePort 사용시
   ```
   helm install -n hyperdata mlplatform mlplatform \
   --set backend.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/backend:20230623_v1 \
   --set solution.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/agent:20230623_v1 \
   --set downloader.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/downloader:20230623_v1 \
   --set serving.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/kserve:20230704_v1 \
   --set kubernetes.istio.ingressgateway.ip=192.168.179.31 \
   --set kubernetes.istio.ingressgateway.port=31380 \
   ```
   
   3-2) mlplatform - LoadBalancer 사용시
   ```
   helm install -n hyperdata mlplatform mlplatform \
   --set backend.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/backend:20230623_v1 \
   --set solution.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/agent:20230623_v1 \
   --set downloader.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/downloader:20230623_v1 \
   --set serving.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/kserve:20230704_v1 \
   --set kubernetes.istio.ingressgateway.ip=192.168.220.239 \
   --set kubernetes.istio.ingressgateway.port=80 \
   --set loadBalancer.enabled=true \
   --set loadBalancer.ip=192.168.220.238 \ 
   ```
   cf) 제대로 된 설치가 안 될시 helm 차트를 아래에 명령어에 따라서 삭제한 후 재가동한다.
   mysql 파드가 정상적으로 실행 되기 전까지는 mlplatform 파드에서 에러 발생할 수 있지만 알아서 restart하니까 몇분 기다려야 함 

1.  Uninstall mlplatform
```
helm uninstall -n hyperdata ml-mysql
helm uninstall -n hyperdata mlplatform
kubectl delete pvc -n hyperdata mlplatform-backend-pvc mlplatform-mysql-pvc
```

# MLplatform 배달공제 버전 설치

0. 모델 훈련 및 배포를 위한 사전 설치 모듈들

   - qa가작성해준 기존 guide대로 설치해도 되지만,  
     더 간단히 설치방법
     ```
     bash quick_install_not_cert.sh
     ```
     - cert-manager빼고,  
       istio, knative-serving, kserve 가 한번에 설치됨.  
       (간혹 최초 설치 시 중간에 저 스크립트가 그냥 끝날수있는데, 그건 각 모듈에서 validatewebhook이 뜨는데 올래걸려서임. 그냥 저 위에 명령어를 계속 재실행해주면 됨.)
     - argo는 argo 폴더에서 guide 참조

1. ml-mysql 설치

   ```
   helm install -n maads-stg-bi ml-mysql ml-mysql
   ```

2. mlplatform 설치

   ```
   helm install -n maads-stg-bi mlplatform mlplatform
   ```

#

#

# mlplatform

1. 이미지에는 희망하는 이미지를 사용하시면 됩니다.

   1. mysql

   ```
   helm install -n hyperdata ml-mysql ml-mysql \
   --set mysql.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/mysql:20230623_v1
   ```

   2. enable registriesSkippingTagResolving

   ```
   kubectl get cm -n knative-serving config-deployment -o yaml | \
   sed -z "s/\ndata:\n/\ndata:\n  registriesSkippingTagResolving: \"${REGISTRY_IP}:${REGISTRY_PORT}\"\n/g" | \
   kubectl apply -f -
   ```

   3.1 mlplatform - NodePort 사용시

   ```
   helm install -n hyperdata mlplatform mlplatform \
   --set backend.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/backend:20230623_v1 \
   --set solution.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/agent:20230623_v1 \
   --set downloader.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/downloader:20230623_v1 \
   --set serving.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/kserve:20230704_v1 \
   --set kubernetes.istio.ingressgateway.ip=192.168.179.31 \
   --set kubernetes.istio.ingressgateway.port=31380 \
   ```

   3.2 mlplatform - LoadBalancer 사용시

   ```
   helm install -n hyperdata mlplatform mlplatform \
   --set loadBalancer.enabled=true \
   --set loadBalancer.ip=192.1.1.99 \
   --set backend.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/backend:20230623_v1 \
   --set solution.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/agent:20230623_v1 \
   --set downloader.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/downloader:20230623_v1 \
   --set serving.image=biqa.tmax.com/hyperdata20.5_rel/hyperdata20.5_mlplatform/kserve:20230704_v1 \
   --set kubernetes.istio.ingressgateway.ip=192.168.179.31 \
   --set kubernetes.istio.ingressgateway.port=31380 \
   ```

   cf) 제대로 된 설치가 안 될시 helm 차트를 아래에 명령어에 따라서 삭제한 후 재가동한다.
   mysql 파드가 정상적으로 실행 되기 전까지는 mlplatform 파드에서 에러 발생할 수 있지만 알아서 restart하니까 몇분 기다려야 함

2. Uninstall mlplatform

```
helm uninstall -n hyperdata ml-mysql
helm uninstall -n hyperdata mlplatform
kubectl delete pvc -n hyperdata mlplatform-backend-pvc mlplatform-mysql-pvc
```

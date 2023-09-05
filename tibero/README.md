# k8s-1.24는 kind: PodSecurityPolicy 가 없어졌기 때문에, templates 메니페스트에서 삭제함. 해당 내용은 db.yaml 에 securityContext로 들어감.


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

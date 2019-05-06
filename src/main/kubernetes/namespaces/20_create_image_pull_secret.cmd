kubectl create secret generic fwp-pull-secret --from-file=.dockerconfigjson=%USERPROFILE%\.docker\config.json --type=kubernetes.io/dockerconfigjson -n fwp-int
kubectl create secret generic fwp-pull-secret --from-file=.dockerconfigjson=%USERPROFILE%\.docker\config.json --type=kubernetes.io/dockerconfigjson -n fwp-uat
kubectl create secret generic fwp-pull-secret --from-file=.dockerconfigjson=%USERPROFILE%\.docker\config.json --type=kubernetes.io/dockerconfigjson -n fwp-prod

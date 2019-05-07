kubectl create secret generic pull-secret --from-file=.dockerconfigjson=%USERPROFILE%\.docker\config.json --type=kubernetes.io/dockerconfigjson -n int
kubectl create secret generic pull-secret --from-file=.dockerconfigjson=%USERPROFILE%\.docker\config.json --type=kubernetes.io/dockerconfigjson -n uat
kubectl create secret generic pull-secret --from-file=.dockerconfigjson=%USERPROFILE%\.docker\config.json --type=kubernetes.io/dockerconfigjson -n prod

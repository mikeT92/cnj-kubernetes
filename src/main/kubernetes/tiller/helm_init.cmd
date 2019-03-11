rem helm_init.cmd
rem --------------------------------------------------------------------------
rem Initializes Helm including installation of Tiller on current K8S.
rem PREREQUISITES: Expects to be started in FWP IDE Dev Console
rem --------------------------------------------------------------------------
@echo off
set TLS_TILLER_SUBJECT="/C=DE/ST=BY/L=Munich/O=University of Applied Sciences Munich/CN=tiller.cluster.local"
set TLS_HELM_SUBJECT="/C=DE/ST=BY/L=Munich/O=University of Applied Sciences Munich/CN=helm.cluster.local"
echo "generating CA"
openssl genrsa -out ./ca.key.pem 4096
openssl req -key ca.key.pem -new -x509 -days 365 -sha256 -out ca.cert.pem -extensions v3_ca -batch -subj %TLS_TILLER_SUBJECT%
echo "generating Tiller server-side certificates"
openssl genrsa -out ./tiller.key.pem 4096
openssl req -key tiller.key.pem -new -sha256 -out tiller.csr.pem -batch -subj %TLS_TILLER_SUBJECT%
openssl x509 -req -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial -in tiller.csr.pem -out tiller.cert.pem -days 365
echo "generating Helm client-side certificates"
openssl genrsa -out ./helm.key.pem 4096
openssl req -key helm.key.pem -new -sha256 -out helm.csr.pem -batch -subj %TLS_HELM_SUBJECT%
openssl x509 -req -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial -in helm.csr.pem -out helm.cert.pem -days 365
echo "initializing Helm and installing Tiller"
helm init --dry-run --debug --service-account tiller --tiller-namespace fwp-system --override 'spec.template.spec.containers[0].command'='{/tiller,--storage=secret}' --tiller-tls --tiller-tls-cert ./tiller.cert.pem --tiller-tls-key ./tiller.key.pem --tiller-tls-verify --tls-ca-cert ca.cert.pem
echo "copying TLS client certificates plus CA to local Helm home at %HELM_HOME"
copy ca.cert.pem %HELM_HOME%\ca.pem
copy helm.cert.pem %HELM_HOME%\cert.pem
copy helm.key.pem %HELM_HOME%\key.pem
copy ca.key.pem %HELM_HOME%
copy tiller.key.pem %HELM_HOME%

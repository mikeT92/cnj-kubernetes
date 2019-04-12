rem helm_init.cmd
rem --------------------------------------------------------------------------
rem Initializes Helm including installation of Tiller on current K8S.
rem PREREQUISITES: Expects to be started in FWP IDE Dev Console
rem --------------------------------------------------------------------------
@echo off
set TLS_TILLER_SUBJECT="/C=DE/ST=BY/L=Munich/O=University of Applied Sciences Munich/CN=tiller.cluster.local"
set TLS_HELM_SUBJECT="/C=DE/ST=BY/L=Munich/O=University of Applied Sciences Munich/CN=helm.cluster.local"
echo "checking for CA"
set CA_CERT_FILENAME=ca.cert.pem
if not exist %CA_CERT_FILENAME% (
    echo "missing required CA certificate file %CA_CERT_FILENAME%"
    exit -1
)
set TILLER_KEY_FILENAME=tiller.key.pem
if not exist %TILLER_KEY_FILENAME% (
    echo "missing required Tiller key file %TILLER_KEY_FILENAME%"
    exit -1
)
set TILLER_CERT_FILENAME=tiller.cert.pem
if not exist %TILLER_CERT_FILENAME% (
    echo "missing required Tiller key file %TILLER_CERT_FILENAME%"
    exit -1
)
echo "initializing Helm and installing Tiller"
helm init --upgrade --service-account tiller --tiller-namespace fwp-sys-tiller --override "spec.template.spec.containers[0].command"="{/tiller,--storage=secret}" --tiller-tls --tiller-tls-cert %TILLER_CERT_FILENAME% --tiller-tls-key %TILLER_KEY_FILENAME% --tiller-tls-verify --tls-ca-cert %CA_CERT_FILENAME% --history-max 3

rem 03_generate_certs_helm.cmd
rem --------------------------------------------------------------------------
rem Generates Helm certificates.
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
set CA_KEY_FILENAME=ca.key.pem
if not exist %CA_KEY_FILENAME% (
    echo "missing required CA key file %CA_KEY_FILENAME%"
    exit -1
)
echo "generating Helm client-side certificates"
openssl genrsa -out ./helm.key.pem 4096
openssl req -key helm.key.pem -new -sha256 -out helm.csr.pem -batch -subj %TLS_HELM_SUBJECT%
openssl x509 -req -CA %CA_CERT_FILENAME% -CAkey %CA_KEY_FILENAME% -CAcreateserial -in helm.csr.pem -out helm.cert.pem -days 365

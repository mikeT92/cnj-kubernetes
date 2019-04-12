rem 02_generate_certs_tiller.cmd
rem --------------------------------------------------------------------------
rem Generates Tiller server side certificates.
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
echo "generating Tiller server-side certificates"
openssl genrsa -out ./tiller.key.pem 4096
openssl req -key tiller.key.pem -new -sha256 -out tiller.csr.pem -batch -subj %TLS_TILLER_SUBJECT%
openssl x509 -req -CA %CA_CERT_FILENAME% -CAkey %CA_KEY_FILENAME% -CAcreateserial -in tiller.csr.pem -out tiller.cert.pem -days 365

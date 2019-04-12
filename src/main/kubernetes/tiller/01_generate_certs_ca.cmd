rem 01_generate_certs_ca.cmd
rem --------------------------------------------------------------------------
rem Generates a CA root certificate to sign Helm and Tiller certificates.
rem PREREQUISITES: Expects to be started in FWP IDE Dev Console
rem --------------------------------------------------------------------------
@echo off
set TLS_TILLER_SUBJECT="/C=DE/ST=BY/L=Munich/O=University of Applied Sciences Munich/CN=tiller.cluster.local"
set TLS_HELM_SUBJECT="/C=DE/ST=BY/L=Munich/O=University of Applied Sciences Munich/CN=helm.cluster.local"
echo "generating CA"
openssl genrsa -out ./ca.key.pem 4096
openssl req -key ca.key.pem -new -x509 -days 365 -sha256 -out ca.cert.pem -extensions v3_ca -batch -subj %TLS_TILLER_SUBJECT%

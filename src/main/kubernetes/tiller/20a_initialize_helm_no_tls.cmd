rem 20a_initialize_helm_no_tls.cmd
rem --------------------------------------------------------------------------
rem Initializes Helm including installation of Tiller on current K8S without
rem TLS connection security.
rem PREREQUISITES: Expects to be started in FWP IDE Dev Console
rem --------------------------------------------------------------------------
@echo off
echo "initializing Helm and installing Tiller"
helm init --upgrade --service-account tiller --tiller-namespace sys-tiller --override "spec.template.spec.containers[0].command"="{/tiller,--storage=secret}" --history-max 3

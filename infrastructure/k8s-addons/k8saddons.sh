#!/bin/bash

CLUSTER_ID=cat0o037g6vgnsshu5t9
CLUSTER_NAME=k8s-zonal
TEMP_KUBECFG=k8sconf
STAT_KUBECFG=config
yc managed-kubernetes cluster get-credentials $CLUSTER_ID --external --kubeconfig $TEMP_KUBECFG
yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | jq -r .master.master_auth.cluster_ca_certificate | awk '{gsub(/\\n/,"\n")}1' > ca.pem
kubectl --kubeconfig=$TEMP_KUBECFG create -f sa.yaml
SA_TOKEN=$(kubectl --kubeconfig=$TEMP_KUBECFG -n kube-system get secret $(kubectl --kubeconfig=$TEMP_KUBECFG -n kube-system get secret | grep admin-user | awk '{print $1}') -o json | jq -r .data.token | base64 --d)
MASTER_ENDPOINT=$(yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | jq -r .master.endpoints.external_v4_endpoint)
kubectl --kubeconfig=$TEMP_KUBECFG config set-cluster $CLUSTER_NAME --certificate-authority=ca.pem --server=$MASTER_ENDPOINT --kubeconfig=$STAT_KUBECFG
kubectl --kubeconfig=$TEMP_KUBECFG config set-credentials admin-user --token=$SA_TOKEN --kubeconfig=$STAT_KUBECFG
kubectl --kubeconfig=$TEMP_KUBECFG config set-context default --cluster=$CLUSTER_NAME --user=admin-user --kubeconfig=$STAT_KUBECFG
kubectl --kubeconfig=$TEMP_KUBECFG config use-context default --kubeconfig=$STAT_KUBECFG
cp -rf $STAT_KUBECFG ~/.kube/config
cp -rf ca.pem ~/.kube/ca.pem
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
helm repo add cowboysysop https://cowboysysop.github.io/charts/
helm repo update
helm install my-release cowboysysop/vertical-pod-autoscaler
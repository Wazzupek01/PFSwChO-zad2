#!/bin/bash
kubectl delete -f manifests/10-php-service.yaml;
kubectl delete -f manifests/09-lamp-ingres.yaml;
kubectl delete -f manifests/08-php-deployment.yaml;
kubectl delete -f manifests/07-mysql-service.yaml;
kubectl delete -f manifests/06-mysql-statefulset.yaml;
kubectl delete -f manifests/05-php-configmap.yaml;
kubectl delete -f manifests/04-mysql-configmap.yaml;
kubectl delete -f manifests/03-secret.yaml;
kubectl delete -f manifests/02-lamp-pvc.yaml;
kubectl delete -f manifests/01-lamp-namespace.yaml;
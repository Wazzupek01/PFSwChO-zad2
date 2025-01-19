#!/bin/bash
kubectl apply -f manifests/01-lamp-namespace.yaml;
kubectl apply -f manifests/02-lamp-pvc.yaml;
kubectl apply -f manifests/03-secret.yaml;
kubectl apply -f manifests/04-mysql-configmap.yaml;
kubectl apply -f manifests/05-php-configmap.yaml;
kubectl apply -f manifests/06-mysql-statefulset.yaml;
kubectl apply -f manifests/07-mysql-service.yaml;
kubectl apply -f manifests/08-php-deployment.yaml;
kubectl apply -f manifests/09-lamp-ingres.yaml;
kubectl apply -f manifests/10-php-service.yaml;
#!/bin/bash

set -e

echo "Deleting any existing KIND cluster..."
kind delete cluster

echo "Creating a new KIND cluster..."
kind create cluster --config kind-cluster-config.yaml

echo "Installing ArgoCD..."
kubectl create namespace argocd || true
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for ArgoCD server to be ready..."
kubectl wait --for=condition=available --timeout=180s deployment/argocd-server -n argocd

echo "Setting up port-forwarding to ArgoCD on localhost:8081..."
kubectl port-forward svc/argocd-server -n argocd 8081:443 &
sleep 5

echo "Installing NGINX Ingress Controller..."
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml

echo "Waiting for ingress controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

echo "Deploying K8s metrics server..."
kubectl apply -f k8s-metric-server/components.yaml


echo "Deploying ArgoCD Application (metrics-app)..."
kubectl apply -f argocd/metrics-argo-app.yaml

echo "Bootstrap complete!"

echo "For Setting up port-forwarding to ArgoCD on localhost:8081"
echo "kubectl port-forward svc/argocd-server -n argocd 8081:443"
echo "Access ArgoCD UI at: http://localhost:8081"
echo "Login with username 'admin' and get the password with:"
echo "kubectl get -n argocd secrets/argocd-initial-admin-secret -o=jsonpath='{.data.password}' | base64 -d;echo"
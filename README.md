# SRE Metrics App on KIND with ArgoCD

This repository automates the setup of a local Kubernetes cluster using [KIND](https://kind.sigs.k8s.io/), installs [ArgoCD](https://argo-cd.readthedocs.io/en/stable/), sets up NGINX Ingress Controller, the Kubernetes Metrics Server, and deploys a metrics application via ArgoCD.

## 🔧 Prerequisites

- kubectl
- kind
- curl
- Access to GitHub (for ArgoCD to fetch the app)

## 🚀 What Gets Deployed

- KIND Cluster
- ArgoCD in `argocd` namespace
- ArgoCD Application for `metrics-app`
- NGINX Ingress Controller
- Kubernetes Metrics Server

## 📝 Setup Instructions

Clone the repo:

```bash
git clone https://github.com/Surajwaghmare35/sre-metrics-app.git
cd sre-metrics-app
chmod +x bootstrap.sh && ./bootstrap.sh

## 🎥 Demo Video
https://github.com/user-attachments/assets/f9dc013f-58c4-413b-bdfa-b13b8e8ad373
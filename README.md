# Infrastructure Cloud Automatisée et Reproductible avec IaC

Projet de stage d'été - **INPT (Institut National des Postes et Télécommunications)**  
Filière : **Systèmes Ubiquitaires et Distribués (Cloud & IoT)**  
Réalisé par : **ElMehdi ElChanoufi** & **Mohamed ElQadi**  
Encadrant : **M. Abdeslam En-Nouaary**

---

## 📌 Présentation du Projet

Ce projet met en place une infrastructure cloud automatisée, modulaire et reproductible gérée via **Terraform** et **Ansible**, déployée sur trois environnements distincts (**dev**, **staging**, **prod**). L'infrastructure héberge une application REST API Python (FastAPI) conteneurisée avec **Docker**, intégrée dans un pipeline **CI/CD GitHub Actions** et supervisée par la stack de monitoring **Prometheus + Grafana**.

```
[GitHub Actions CI/CD] 
       │
       ├──> [Terraform] ──> Provisioning Réseau, VMs & Firewall (Dev / Staging / Prod)
       │
       └──> [Ansible]   ──> Installation Docker + App FastAPI + Stack Prometheus / Grafana
```

---

## 🛠️ Stack Technologique

- **Infrastructure as Code** : Terraform v1.15+ (Modules réutilisables, paramétrés par `.tfvars`)
- **Gestion de Configuration** : Ansible (Playbooks idempotents & rôles)
- **Conteneurisation** : Docker & Docker Compose
- **Application Démo** : Python 3.11 / FastAPI avec métriques Prometheus intégrées
- **Observabilité** : Prometheus (collecte) + Grafana (dashboards) + Node Exporter (métriques système)
- **CI/CD** : GitHub Actions (Terraform fmt/validate/plan & Build/Push Docker)

---

## 📁 Structure du Dépôt

```
IaC/
├── .github/workflows/      # Pipelines CI/CD GitHub Actions
│   ├── iac-ci.yml          # Validation & Plan Terraform
│   └── app-cd.yml          # Build Docker & Déploiement
├── app/                    # Code source de l'API de démo FastAPI
│   ├── main.py             # Endpoints /health, /status, /metrics
│   ├── requirements.txt    # Dépendances Python
│   └── Dockerfile          # Image Docker optimisée
├── terraform/              # Code Infrastructure as Code
│   ├── modules/            # Modules réutilisables (network, compute)
│   └── environments/       # Environnements (dev, staging, prod)
├── ansible/                # Automation & Configuration Management
│   ├── inventory/          # Fichiers d'inventaire par environnement
│   ├── roles/              # Rôles Ansible (docker, app, monitoring)
│   └── site.yml            # Playbook principal
├── cahier_des_charges.tex  # Document LaTeX du cahier des charges
└── README.md               # Documentation générale
```

---

## 🚀 Guide de Démarrage Rapide

### 1. Prérequis
- Windows avec **WSL2 (Ubuntu)**
- **Terraform** (v1.15+) installé
- **Ansible** (`pip install ansible`)
- **Docker** & **Git**

### 2. Tester l'application FastAPI en local avec Docker
```bash
cd app
docker build -t iac-demo-app .
docker run -d -p 8000:8000 --name demo-app iac-demo-app
curl http://localhost:8000/health
```

### 3. Valider l'Infrastructure Terraform
```bash
cd terraform/environments/dev
terraform init
terraform validate
terraform plan
```

### 4. Exécuter la Configuration Ansible
```bash
cd ansible
ansible-playbook -i inventory/dev site.yml --syntax-check
```

---

## 📊 Endpoints & Dashboards

- **API FastAPI** : `http://<VM_IP>:8000` (Swagger UI: `/docs`, Health: `/health`)
- **Prometheus** : `http://<VM_IP>:9090`
- **Grafana** : `http://<VM_IP>:3000` (Login: `admin` / `admin`)

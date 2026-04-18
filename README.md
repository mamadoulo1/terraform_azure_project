# Terraform — Data Lake Azure

Mini projet d'apprentissage Terraform pour provisionner un Data Lake Azure Gen2 avec gestion multi-environnements.

## Architecture

```
project_terraform/
├── main.tf                          # Provider, backend, ressources principales
├── variables.tf                     # Variables paramétrables
├── outputs.tf                       # Valeurs exposées après apply
├── modules/
│   └── datalake/                    # Module réutilisable
│       ├── main.tf                  # Storage Account + Containers raw/processed
│       ├── variables.tf
│       └── outputs.tf
└── .github/
    └── workflows/
        └── terraform.yml            # Pipeline CI/CD GitHub Actions
```

## Ressources créées

Par environnement (dev / prod) :

| Ressource | Nom |
|---|---|
| Resource Group | `rg-datalake-{env}` |
| Storage Account (Data Lake Gen2) | `stdatalakemamad{env}` |
| Container | `raw` |
| Container | `processed` |

## Prérequis

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.6
- [Azure CLI](https://learn.microsoft.com/fr-fr/cli/azure/install-azure-cli) >= 2.x
- Un compte Azure avec une subscription active

## Installation

**1. Cloner le repo**
```bash
git clone <url-du-repo>
cd project_terraform
```

**2. Se connecter à Azure**
```bash
az login
```

**3. Initialiser Terraform**
```bash
terraform init
```

## Utilisation

### Déployer l'environnement dev

```bash
terraform workspace select dev || terraform workspace new dev
terraform plan
terraform apply
```

### Déployer l'environnement prod

```bash
terraform workspace select prod || terraform workspace new prod
terraform plan
terraform apply
```

### Supprimer les ressources

```bash
terraform destroy
```

## Remote State

Le state Terraform est stocké dans Azure Blob Storage :

| Paramètre | Valeur |
|---|---|
| Resource Group | `rg-tfstate` |
| Storage Account | `stterraformstate2026ml` |
| Container | `tfstate` |
| Clé par workspace | `env:/{workspace}/project_terraform.tfstate` |

## CI/CD GitHub Actions

Le pipeline s'exécute automatiquement sur `main` :

| Déclencheur | Action |
|---|---|
| Pull Request | `terraform plan` (prévisualisation) |
| Push sur main | `terraform plan` + `terraform apply` |

### Secrets GitHub requis

| Secret | Description |
|---|---|
| `ARM_CLIENT_ID` | ID du Service Principal |
| `ARM_CLIENT_SECRET` | Secret du Service Principal |
| `ARM_SUBSCRIPTION_ID` | ID de la subscription Azure |
| `ARM_TENANT_ID` | ID du tenant Azure |

## Concepts appris

- **Provider** — connexion à Azure via le plugin `azurerm`
- **Resources** — déclaration de ressources cloud
- **Variables & Outputs** — paramétrage et exposition des valeurs
- **Remote State** — state partagé stocké dans Azure
- **Modules** — code réutilisable pour chaque environnement
- **Workspaces** — isolation des états dev / prod
- **CI/CD** — automatisation via GitHub Actions

# terraform-gcp-template

## Workflow features
- Authenticating via [Workload Identity Federation](https://cloud.google.com/iam/docs/configuring-workload-identity-federation#github-actions)
- [plan.yml](.github/workflows/plan.yml)
    - Run `terraform plan`
        - Automatically run when a pull request is issued to the main branch
    - Comment the results of the `terraform plan` in the pull request
    - Run `terraform plan`, `terraform fmt` and [tflint](https://github.com/terraform-linters/tflint)
- [apply.yml](.github/workflows/apply.yml)
    - Run `terraform apply`

## Requirements
* GitHub Actions
* Terraform v1.0+

## Usage
### 1. Install tools
* [gcloud](https://cloud.google.com/sdk/docs/install)

### 2. Use This template

### 3. Setup gcloud
```bash
gcloud auth application-default login
gcloud config set project ${GCP_PROJECT_ID}
```
### 4. Prepare for Terraform
* Create Serviceaccounts attached role `roles/editor`
```bash
gcloud iam service-accounts create terraform --project=${GCP_PROJECT_ID}
gcloud iam service-accounts add-iam-policy-binding terraform@${GCP_PROJECT_ID}.iam.gserviceaccount.com --member=serviceAccount:terraform@${GCP_PROJECT_ID}.iam.gserviceaccount.com --role=roles/editor --project=${GCP_PROJECT_ID}
```
* Create Bucket

### 5. Edit file for Terraform
#### [terraform.tfvars](terraform.tfvars)
Please check [variable.tf](variable.tf) discription

#### [version.tf](version.tf)
Upgrade to the latest version
- `terraform.required_version`

#### [backend.tf](backend.tf)
backet is Same to [4. Prepare for Terraform](#4-prepare-for-terraform) on created bucket name

### 6. Run Terraform from local
```bash
terraform init -upgrade
terraform plan
terraform apply
```

### 7. Edit file for GitHub Actions
#### [.github/workflows/plan.yml](.github/workflows/plan.yml)
#### [.github/workflows/apply.yml](.github/workflows/apply.yml)
Edit followings

* `TERRAFORM_VERSION`
  * Same to [.terraform-version](.terraform-version)
* `WORKLOAD_IDENTITY_PROVIDER`
  * This is created by Terraform
  * See. https://console.cloud.google.com/iam-admin/workload-identity-pools
* `SERVICE_ACCOUNT_EMAIL`
  * This is created by bash
  * See. https://console.cloud.google.com/iam-admin/serviceaccounts

### 8. Check git push repository
`git push` and check your repository
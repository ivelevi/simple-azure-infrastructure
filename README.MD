# Azure Infrastructure Deployment with Terraform

This repository contains Terraform scripts for deploying a simple three-tier architecture on Azure. The architecture includes:

- A Virtual Network (VNet) with subnets for web, application, and database tiers.
- Two Virtual Machines (VMs) in the web tier with a Load Balancer.
- A VM in the application tier.
- An Azure SQL Database in the database tier.
- A Network Security Group (NSG) with open rules for each tier. (best practice to use more restrictive rules)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- An Azure account with appropriate permissions to create resources.
- An Azure Service Principal for Terraform authentication.

## Directory Structure

For convenience, all Terraform scripts are placed in the same directory. However, for better organization and maintainability, it is recommended to separate them into folders and separate files for `main`, `variables`, and `outputs`.

## Getting Started

### 1. Install Terraform

Follow the instructions on the [Terraform website](https://www.terraform.io/downloads.html) to download and install Terraform for your operating system.

### 2. Clone the Repository

```sh
git clone <repository-url>
cd <repository-directory>
```

### 3. Configure Azure Authentication

Ensure you have an Azure Service Principal and set the following environment variables:

```sh
export ARM_CLIENT_ID=<your-service-principal-client-id>
export ARM_CLIENT_SECRET=<your-service-principal-client-secret>
export ARM_SUBSCRIPTION_ID=<your-azure-subscription-id>
export ARM_TENANT_ID=<your-azure-tenant-id>ion-id>
export ARM_TENANT_ID=<your-azure-tenant-id>
```

4. Start variables
Start by assigning your values to variables that are empty or have placeholder names.


5. Initialize Terraform
Run the following command to initialize the Terraform configuration. This will download the necessary provider plugins.

```sh
terraform init
```

6. Review and Apply Configuration
Before applying the configuration, review the scripts to ensure they meet your requirements. You can also customize the variables in variables.tf as needed.

Run the following command to create an execution plan:

```sh
terraform plan
```

If the plan looks good, apply the configuration:


```sh
terraform apply
```

Type yes when prompted to confirm the operation.

7. Verify the Deployment
Once the deployment is complete, you can verify the created resources in the Azure portal.

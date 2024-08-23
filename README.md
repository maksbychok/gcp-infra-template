# gcp-infra-template

## Installing Terraform
1. Download Terraform:
— Visit the Terraform download page.
— Download the appropriate package for your operating system.
2. Install Terraform:
— Windows:
— Unzip the downloaded package.
— Move the `terraform.exe` file to a directory included in your system’s `PATH`.
— macOS and Linux:
— Unzip the downloaded package.
— Move the `terraform` binary to `/usr/local/bin` or another directory included in your `PATH`.
3. Verify Installation:
— Open a terminal or command prompt.
— Run `terraform — version` to verify that Terraform is installed correctly.

## Configuring GCP Credentials
1. Install Google Cloud SDK:
— Follow the instructions for your operating system from the Google Cloud SDK installation page.
2. Initialize Google Cloud SDK:
— Open a terminal.
— Run `gcloud init` and follow the prompts to authenticate with your Google account and set up your project.
3. Set Up Application Default Credentials:
— Run `gcloud auth application-default login` to authenticate and configure the application default credentials.
4. Create a Service Account:
— In the GCP Console, navigate to `IAM & Admin > Service Accounts`.
— Click `+ CREATE SERVICE ACCOUNT`.
— Provide a name and description for the service account.
— Assign the required roles (e.g., `Viewer`, `Editor`, or more specific roles depending on your needs).
— Click `Done` to create the service account.
5. Generate a Service Account Key:
— Select the newly created service account.
— Click `Add Key > Create New Key`.
— Choose `JSON` and click `Create`. The key file will be downloaded to your machine.
6. Set the Service Account Key as an Environment Variable:
— Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to the path of the downloaded key file.

## Get started
1. Upload Service Account Key to /keys folder (have to be secret)
2. Create `/terraform/terraform.tfvars` file
```
    gcp_key = "<path_to_service_key>"
    gcp_project_id = "<id>"
    gcp_region = "us-east1"
    sql_user = "sql_admin"
    sql_passpord = "<password>"
```
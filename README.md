# Overview
A sample on how to use advanced GCP IAM configurations. Specifically looks at:
- Service Account Impersonation 
- IAM Conditions

The demo will create the following resources:
1. Create Service Account in target GCP project
2. Apply Compute Admin permissions to the Service Account
3. Add user account as an authorised user of the service account

# Pre-requisites
1. Terraform 1.1.4
2. GCP Service Account and Key with sufficient permissions to create all objects within a pre-existing project. Use the env variable to specify the key:
```
export GOOGLE_APPLICATION_CREDENTIALS=b99940cc502d.json
```

# Entry Point
## Terraform Actions
The following actions will plan and apply the terraform state:
```
make tf.plan
make tf.apply
```

## Gcloud actions
The following actions will query the list of compute instances with and without the impersonate flag
```
make test.impersonate_no
make test.impersonate_yes
```
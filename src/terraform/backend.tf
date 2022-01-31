terraform {
  backend "gcs" {
    bucket = "contini-e5f8f57f8509c5d5-tfstate" 
    prefix = "terraform/iam-conditions"
  }
}

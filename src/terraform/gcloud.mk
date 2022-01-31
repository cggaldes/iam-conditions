SA_EMAIL?="compute-creator-sa@contini-e5f8f57f8509c5d5.iam.gserviceaccount.com"

test.impersonate_no:
	gcloud compute instances list

test.impersonate_yes:
	gcloud compute instances list --impersonate-service-account ${SA_EMAIL}
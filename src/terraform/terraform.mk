tf.init:
	@cd src/terraform && terraform init

tf.plan: tf.init
	@cd src/terraform && terraform plan -out=tf_plan.out

tf.apply:
	@cd src/terraform && terraform apply tf_plan.out
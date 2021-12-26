setup: init

init:
	terraform init

plan:
	terraform plan \
  -var "do_token=${DO_PAT}" \
  -var "pvt_key=${HOME}/.ssh/id_rsa"

apply:
	terraform apply \
  -var "do_token=${DO_PAT}" \
  -var "pvt_key=${HOME}/.ssh/id_rsa"

show:
	terraform show terraform.tfstate

destroy:
	terraform destroy \
  -var "do_token=${DO_PAT}"

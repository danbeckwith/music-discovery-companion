TERRAFORM_DIRECTORY="./terraform"

cd $TERRAFORM_DIRECTORY

terraform init

terraform apply -input=true
# Terraform Run Module
# Make here is used to help CI/CD Automation tools, instead of running terraform commands you can run prepopulated Make commands to run terraforms builds / destroy
# You can also create a life cyclehook from a shell script which can fill variables in these commands 

windows_vm_plan:
	terraform workspace select windows
	terraform plan -target module.windows -var-file="windows.tfvars" -out=.<Enter any name for your out file>
.PHONY: windows_vm_plan

windows_vm_apply:
	terraform apply .<Enter any name for your out file>
.PHONY: windows_vm_apply

#Decided to use workspace function in terraform to segregate the windows / linux VM creations
windows_destroy:
	terraform workspace select windows 
	terraform destroy -var-file="windows.tfvars" -auto-approve
.PHONY: windows_destroy

linux_vm_plan:
	terraform workspace select linux
	terraform plan -target module.linux -var-file="linux.tfvars" -out=.<Enter any name for your out file>
.PHONY: linux_vm_plan

linux_vm_apply:
	terraform apply .<Enter any name for your out file>
.PHONY: linux_vm_apply

linux_destroy:
	terraform workspace select linux
	terraform destroy -var-file="linux.tfvars" -auto-approve

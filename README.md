# Introduction 
This Repository is dedicated to a VMware-Terraform Module I'm creating to help Automate the flow of VM deployments instead of deploying from templates via the GUI.
Contained within is code that will deploy the following;
 - Linux or Windows Machine (Based on Template)
 - In specified vCentre
 
## NOTE, You must have Terraform / Make installed on the machine you're using
## There is another way using docker-compose, please contact me for details

### Description
A short brief on this code, is that it will provision either a Windows Machine or Linux Machine based on the template it pointing to.
vCentre, Storage, Cluster, vNIC, Resources will all be allocated on respected tfvars file.
There is also a method to create a count loop within the module to create as much machines as desired, but you'll need to sure that there is enough IP leases within the subnet, resources, storage,
Or else the deployment will fail.

To run the code, navigate to either the ```linux.tfvars``` file or ```windows.tfvars``` file.

```
vsphere_vcenter = ""
vsphere_user = "-"
vsphere_password = "-"
vsphere_unverified_ssl = 
vsphere_datacenter =
vsphere_cluster ="
vm_name = 
vm_datastore =
vm_network = 
vm_netmask = 
vm_gateway = 
vm_dns = 
vm_domain = 
vm_template = 
vm_linked_clone =
vm_cpu =
vm_ram =
vm_ip = 

```

After you've filled out the tfvars file, it will be time to deploy.
Deployment will use Make as a main source in input, the file looks as followed;

```
windows_vm_plan:
	terraform workspace select windows
	terraform plan -target module.windows -var-file="windows.tfvars" -out=.<Enter any name for your out file>
.PHONY: windows_vm_plan

windows_vm_apply:
	terraform apply .<Enter any name for your out file>
.PHONY: windows_vm_apply

windows_destroy:
	terraform workspace select windows 
	terraform destroy -var-file="windows.tfvars" -auto-approve
.PHONY: windows_destroy

linux_vm_plan:
	terraform workspace select linux
	terraform plan -target module.linux -var-file="linux.tfvars" -out=.<Enter any name for your out file>
.PHONY: linux_vm_plan

linux_vm_apply:
	terraform apply <Enter any name for your out file>
.PHONY: linux_vm_apply

linux_destroy:
	terraform workspace select linux
	terraform destroy -var-file="linux.tfvars" -auto-approve

```

As you can already tell, to run Windows machine you'll run the windows Make commands and Linux for Linux.
Begin with ```terraform init``` in your main directory where the Make file is located.
After, I recommend you create a workspace for each Windows / Linux machines.
```terraform workspace new  <Enter Name>```

Open the Make file and sure you make adjustments to line **7, 11,22, 26** and change the name of the outfile to anything you like such as ."<vm-name>-buildnumber"
and ensure that the apply command is point to the name you specified.

Then begin with your plan, in this example we will use windows

```make windows_vm_plan```

Terraform will then begin the plan phase, ensure everything is as expected.
If you're having issues, please ensure you in the righ dir where the Make file is located, also the error should give you an accurate description, if there is sill issues, please contact me.

After this is done, you will run

```make windows_vm_apply```


After this you should have a machine ready, 
If you're having any issues, re-read the steps provided and if all else fails please contact me

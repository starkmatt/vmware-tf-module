module "windows" {
 source = "./modules/windows"
#count =  You can use this count as a foor loop and set to create more than one machine in one run, provided you have an array of names / ip's configured in the logic 
 vsphere_vcenter = "${var.vsphere_vcenter}"
 vsphere_user = "${var.vsphere_user}"
 vsphere_password = "${var.vsphere_password}"
 vsphere_unverified_ssl = "${var.vsphere_unverified_ssl}"
 vsphere_datacenter = "${var.vsphere_datacenter}"
 vsphere_cluster = "${var.vsphere_cluster}"
 vm_datastore = "${var.vm_datastore}" 
 vm_network = "${var.vm_network}"
 vm_template = "${var.vm_template}"
 vm_linked_clone = "${var.vm_linked_clone}"
 vm_ip  = "${var.vm_ip}"
 vm_netmask = "${var.vm_netmask}"
 vm_gateway = "${var.vm_gateway}"
 vm_dns = "${var.vm_dns}"
 vm_domain = "${var.vm_domain}"
 vm_cpu = "${var.vm_cpu}"
 vm_ram = "${var.vm_ram}"
 vm_name = var.vm_name
}

module "linux" {
 source = "./modules/linux"
#count =  You can use this count as a foor loop and set to create more than one machine in one run, provided you have an array of names / ip's configured in the logic 
 vsphere_vcenter = "${var.vsphere_vcenter}"
 vsphere_user = "${var.vsphere_user}"
 vsphere_password = "${var.vsphere_password}"
 vsphere_unverified_ssl = "${var.vsphere_unverified_ssl}"
 vsphere_datacenter = "${var.vsphere_datacenter}"
 vsphere_cluster = "${var.vsphere_cluster}"
 vm_datastore = "${var.vm_datastore}" 
 vm_network = "${var.vm_network}"
 vm_template = "${var.vm_template}"
 vm_linked_clone = "${var.vm_linked_clone}"
 vm_ip  = "${var.vm_ip}"
 vm_netmask = "${var.vm_netmask}"
 vm_gateway = "${var.vm_gateway}"
 vm_dns = "${var.vm_dns}"
 vm_domain = "${var.vm_domain}"
 vm_cpu = "${var.vm_cpu}"
 vm_ram = "${var.vm_ram}"
 vm_name = var.vm_name
}

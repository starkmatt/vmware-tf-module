data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vm_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vm_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vm_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "standalone" {
  name             = "${var.vm_name}"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "/02NonProd/Sysadmin/POC"
  scsi_type        = "${data.vsphere_virtual_machine.template.scsi_type}"
  wait_for_guest_ip_timeout = -1
  wait_for_guest_net_timeout = -1
  #skip_customization = true

  num_cpus = "${var.vm_cpu}"
  memory   = "${var.vm_ram}"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "${var.vm_name}.vmdk"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
# You can add additional disk by creating another disk loop
#See https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_disk for Information
  disk { 
    attach = true
    path = "${var.vm_name}/${var.vm_name}_2.vmdk"
    label = "diskshared"
    unit_number = 2
    datastore_id = "${data.vsphere_datastore.datastore.id}"
}

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    linked_clone  = "${var.vm_linked_clone}"

    customize {
      timeout = "0"
#This session here has to do with windows Guest Custominization, you'll need to ensure the credentials you use for you vCentre also had credentials to join machines to domain.
#If this is not the case, you'll need to create another input in the main.tf section and add a credentials to the windows module specifcally for windows join.
#The run_once_command_list is useful to create life cycle hooks to trigger installs of applications / or scripts on the template.
      windows_options {
        computer_name = "${var.vm_name}"
        join_domain = var.vm_domain
        domain_admin_user = var.vsphere_user
        domain_admin_password = var.vsphere_password
        run_once_command_list   = [
          "powershell.exe New-Item C:\\ProgramData\\terraform.txt -ItemType File -Value 'text has been processed'" 
          ]
      }
    
      network_interface {
        ipv4_address = "${var.vm_ip}"
        ipv4_netmask = "${var.vm_netmask}"
      }

      ipv4_gateway    = "${var.vm_gateway}"
      dns_server_list = ["${var.vm_dns}"]
    }
  }
}
#An example of adding additional disks
# resource "vsphere_virtual_disk" "disk_2" {
# vmdk_path  = "${var.vm_name}/${var.vm_name}_2.vmdk"
# size       =   112
# datacenter = "${var.vsphere_datacenter}"
# datastore  = "${var.vm_datastore}"
# type       = "thin"

# }

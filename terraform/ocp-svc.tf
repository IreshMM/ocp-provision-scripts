resource "vcd_vapp_vm" "ocp_svc" {
  vapp_name     = var.vapp
  name          = "ocp-svc"
  computer_name = "ocp-svc"
  catalog_name  = "Public Catalog"
  template_name = "CentOS-8-Template-Official"
  memory        = 1024 * 6
  cpus          = 4
  cpu_cores     = 4

  override_template_disk {
    bus_type         = "paravirtual"
    size_in_mb       = 1024 * 150
    bus_number       = 0
    unit_number      = 0
    iops             = 0
    storage_profile  = "Standard"
  }

  customization {
    initscript = <<-EOF
                    #!/bin/bash
                    mkdir -p /root/.ssh
                    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCu4bcm6NNupeqvYgQ4ZSf8hixom8vuHI8Rga5zbabBRI59y0Rg+29oJyVb39qq7DDCF4JLzO0adC+stdrKpCK7dHOc1wjRMnQUaQwVoD+YQ+yVSEMaTHyBJ7nozQqQVi8h/OUH22jDsSXsyWedST441pIPF4rlV/xABH6oBL25woGuUUMgTQ6cCIxz1iwYmRwRNtCsf28sLlM1Q1bBKc8Cj19Nzkokbbg5G1Z3V3bkbcYiH+UH9Z/JPfhTFyfe0abd6hvLC9JIFzC0oZrk2YmRba8UR6reRQHUBKf6BxRr8KOfhkjFbxra36bSuUM/3dbG5t992xGfO+d+2W8iqzxcYin8A9u5/OjnwSVU5mxFJLHh1hf/MnowS7LSE6r17pTOVoA/FIDPvcfJphK+t0aMqxz7eHY3zusHAtghTe+4PJxoFKmTcqbhnJq1jIOlOwv4/SrSwgkihOmSBbY9TIOUdlk9Yhfv5DWjMJyOAcWv32yyFiqrN+j6rCjTHaP+Th8= iresh@workstation" >> /root/.ssh/authorized_keys
                    EOF
  }
}

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
                    cd
                    echo hellofriend > b
                    EOF
    auto_generate_password = false
    admin_password = "admin"
  }
}

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
                    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIM8MyI1qPSv7FwLi5ZsLlnpx8lrLlwi9DE9oKh2Zd1bET5Lj3b35IwnEs6exZsiHvCIvpr8SeXNjbdRWDH6CTnXeJYCvaMCjbZJDuPq7R+iMN6SAiMn4m1jwfUg1RyvSZ3wo34G9dGRWP5edQ0EbzUZL1xqXNA7tLe7IT5XNIQ1OkoSk8KG7Nz/33PrU24S2WU6WDySfVJbslZvpOhKYogbwh8wBOUC9I9LLCgtnaeLO4LqhzYJuddxr6r7E9FAmnNRsJfKBbYplgpRADShSt/fN7zgbUMRo1GOr4GOCgbjx49zU/rX0EmRGEa26bvP6Jgc0qE4K9syWxmjeWVWGoxFaSrMG9NegVv39lQlUL8PPhD6JTVKH057FDVTnUCJKTv+MtLVAoyL7fV/oREmvp+mvM7AijcfAP7EWTyG2c9neyDMFBrVB004Fs4FEKP7BHN9yUQwgNYA/jU3nGoN8XkBBqkE2r3hPKwUx9av9IvNAY8EsD69TroTRVPieIjRk= iresh@jump-host" >> /root/.ssh/authorized_keys
                    EOF
  }
}

variable "vcd_user" {
  description = "User ID to authenticate to VCD"
  type = string
}

variable "vcd_pass" {
  description = "Password to authenticate to VCD"
  type = string
}

variable "vcd_org" {
    description = "Organization ID to connect to"
    type = string
}

variable "vcd_vdc" {
    description = "Virtual Data Center ID"
    type = string
}

variable "vcd_url" {
    description = "URL to the site"
    type = string
}

variable "vcd_allow_unverified_ssl" {
    description = "Whether to allow unverified SSL"
    type = bool
    default =  false
}

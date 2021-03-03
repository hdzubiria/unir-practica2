variable "location" {
  type = string
  description = "(US) South Central US"
  default = "South Central US"
}

variable "vm_size" {
  type = string
  description = "Tamaño de la máquina virtual"
  default = "Standard_D2_v2" # 7 GB, 2 CPU 
}


variable "vm_size_master" {
  type = string
  description = "Tamaño de la máquina virtual"
  default = "Standard_D2s_v3" # 8 GB, 2 CPU 
}
/***************************************************************************************************

            Creamos la maquina  kubernates (k8) - worker 2

****************************************************************************************************/


# Create NIC de la k8s_worker2
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "nic_k8s_worker2" {
  name                = "nic_k8s_worker2"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "k8s_worker2_ipconfiguration"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.30"
    public_ip_address_id           = azurerm_public_ip.k8s_worker2__ipp.id
  }

    tags = {
        environment = "CP2"
    }

}


# IP pública de k8 Worker 2
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "k8s_worker2__ipp" {
  name                = "k8s_worker2__ipp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}



# Maquina Virtual - K8 Worker 2
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "k8s_worker2_vm" {
    name                = "k8sworker2"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size
    admin_username      = "ec2-user"
    
    network_interface_ids = [ azurerm_network_interface.nic_k8s_worker2.id ]
 
    disable_password_authentication = true
    
    admin_ssh_key {
        username   = "ec2-user"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}
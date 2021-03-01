# Security group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "hdz_k8s_SecGroup" {
    name                = "sshtraffic"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

# Vinculamos el security group al interface de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "k8s_mater_SecGroupAssociation" {
    network_interface_id      = azurerm_network_interface.nic_k8s_mater.id
    network_security_group_id = azurerm_network_security_group.hdz_k8s_SecGroup.id

}

resource "azurerm_network_interface_security_group_association" "k8s_worker1_SecGroupAssociation" {
    network_interface_id      = azurerm_network_interface.nic_k8s_worker1.id
    network_security_group_id = azurerm_network_security_group.hdz_k8s_SecGroup.id

}

resource "azurerm_network_interface_security_group_association" "k8s_worker2_SecGroupAssociation" {
    network_interface_id      = azurerm_network_interface.nic_k8s_worker2.id
    network_security_group_id = azurerm_network_security_group.hdz_k8s_SecGroup.id

}

resource "azurerm_network_interface_security_group_association" "k8s_nfs_SecGroupAssociation" {
    network_interface_id      = azurerm_network_interface.nic_k8s_nfs.id
    network_security_group_id = azurerm_network_security_group.hdz_k8s_SecGroup.id

}



        #!/bin/bash
        mkdir -p $HOME/clouddrive/DevOps-Sol-hdz/.TFTesting

        echo -e "variable \"location\" {
        default = \"westus\"
    }

variable \"storage_account_key\" { }

resource \"azurerm_resource_group\" \"TFTest\" {
    name     = \"tfTestResourceGroup\"
    location = \"westus\"
}
resource \"azurerm_container_group\" \"TFTest\" {
    depends_on = [\"azurerm_resource_group.TFTest\"]
    name = \"tfTestContainerGroup\"
    location = \"westus\"
    resource_group_name = \"tfTestResourceGroup\"
    ip_address_type = \"public\"
    os_type = \"linux\"
    restart_policy = \"Never\"

    container {
        name = \"tf-test-aci\"
        image = \"microsoft/terraform-test\"
        cpu = \"1\"
        memory = \"2\"
        port = \"80\"

        environment_variables {
            \"ARM_TEST_LOCATION\"=\"westus\"
            \"ARM_TEST_LOCATION_ALT\"=\"westus\"
        }

        command = \"/bin/bash -c '/module/DevOps-Sol-hdz/.TFTesting/containercmd.sh'\"

        volume {
            name = \"module\"
            mount_path = \"/module\"
            read_only = false
            share_name = \"cs-haroldo-dezubiria411-comunidadunir-net-10032000f0687839\"
            storage_account_name = \"cs710032000f0687839\"
            storage_account_key = \"\${var.storage_account_key}\"
        }
    }
}" > $HOME/clouddrive/DevOps-Sol-hdz/.TFTesting/testfile.tf

        export TF_VAR_storage_account_key=$(az storage account keys list -g cloud-shell-storage-southcentralus -n cs710032000f0687839 | jq '.[0].value')

        mkdir -p $HOME/clouddrive/DevOps-Sol-hdz/.TFTesting/.azure

        az account list --refresh &> /dev/null

        cp $HOME/.azure/*.json $HOME/clouddrive/DevOps-Sol-hdz/.TFTesting/.azure

    
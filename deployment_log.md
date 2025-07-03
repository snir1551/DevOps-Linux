## terraform init
Initializing Terraform...

[0m[1mInitializing the backend...[0m
[0m[32m
Successfully configured the backend "azurerm"! Terraform will automatically
use this backend unless the backend configuration changes.[0m
[0m[1mInitializing modules...[0m
- network in modules/network
- resource_group in modules/resource_group
- vm in modules/vm

[0m[1mInitializing provider plugins...[0m
- Finding hashicorp/azurerm versions matching "~> 3.0"...
- Installing hashicorp/azurerm v3.117.1...
- Installed hashicorp/azurerm v3.117.1 (signed by HashiCorp)

Terraform has created a lock file [1m.terraform.lock.hcl[0m to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.[0m

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
## terraform apply
Applying Terraform configuration...
Acquiring state lock. This may take a few moments...
[0m[1mmodule.resource_group.azurerm_resource_group.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources][0m
[0m[1mmodule.network.azurerm_network_security_group.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/networkSecurityGroups/mtc-nsg][0m
[0m[1mmodule.network.azurerm_virtual_network.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/virtualNetworks/mtc-network][0m
[0m[1mmodule.network.azurerm_public_ip.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/publicIPAddresses/mtc-ip][0m
[0m[1mmodule.network.azurerm_subnet.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/virtualNetworks/mtc-network/subnets/mtc-subnet][0m
[0m[1mmodule.network.azurerm_network_security_rule.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/networkSecurityGroups/mtc-nsg/securityRules/ssh-rule][0m
[0m[1mmodule.network.azurerm_subnet_network_security_group_association.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/virtualNetworks/mtc-network/subnets/mtc-subnet][0m
[0m[1mmodule.network.azurerm_network_interface.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/networkInterfaces/mtc-nic][0m
[0m[1mmodule.vm.azurerm_linux_virtual_machine.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Compute/virtualMachines/mtc-vm][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [33m~[0m update in-place[0m

Terraform will perform the following actions:

[1m  # module.vm.azurerm_linux_virtual_machine.this[0m will be updated in-place
[0m  [33m~[0m[0m resource "azurerm_linux_virtual_machine" "this" {
        id                                                     = "/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Compute/virtualMachines/mtc-vm"
        name                                                   = "mtc-vm"
        tags                                                   = {
            "environment" = "dev"
        }
        [90m# (27 unchanged attributes hidden)[0m[0m

      [31m-[0m[0m identity {
          [31m-[0m[0m identity_ids = [] [90m-> null[0m[0m
          [31m-[0m[0m principal_id = "24b72eeb-2c65-4acb-946f-be0e6ee7c4ca" [90m-> null[0m[0m
          [31m-[0m[0m tenant_id    = "485d9998-0bfe-4500-89f1-6d8e49183499" [90m-> null[0m[0m
          [31m-[0m[0m type         = "SystemAssigned" [90m-> null[0m[0m
        }

        [90m# (3 unchanged blocks hidden)[0m[0m
    }

[1mPlan:[0m 0 to add, 1 to change, 0 to destroy.
[0m[0m[1mmodule.vm.azurerm_linux_virtual_machine.this: Modifying... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Compute/virtualMachines/mtc-vm][0m[0m
[0m[1mmodule.vm.azurerm_linux_virtual_machine.this: Still modifying... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-...crosoft.Compute/virtualMachines/mtc-vm, 10s elapsed][0m[0m
[0m[1mmodule.vm.azurerm_linux_virtual_machine.this: Still modifying... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-...crosoft.Compute/virtualMachines/mtc-vm, 20s elapsed][0m[0m
[0m[1mmodule.vm.azurerm_linux_virtual_machine.this: Modifications complete after 23s [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Compute/virtualMachines/mtc-vm][0m
Releasing state lock. This may take a few moments...
[0m[1m[32m
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mpublic_ip_address = "51.4.113.244"
resource_group_name = "mtc-resources"
ssh_connection_command = "ssh azureuser@51.4.113.244"
virtual_machine_id = "/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Compute/virtualMachines/mtc-vm"
virtual_machine_name = "mtc-vm"
## terraform output
Public IP from Terraform: 51.4.113.244

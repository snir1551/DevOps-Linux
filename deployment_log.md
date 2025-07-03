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
[0m[1mmodule.network.azurerm_virtual_network.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/virtualNetworks/mtc-network][0m
[0m[1mmodule.network.azurerm_public_ip.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/publicIPAddresses/mtc-ip][0m
[0m[1mmodule.network.azurerm_network_security_group.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/networkSecurityGroups/mtc-nsg][0m
[0m[1mmodule.network.azurerm_network_security_rule.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/networkSecurityGroups/mtc-nsg/securityRules/ssh-rule][0m
[0m[1mmodule.network.azurerm_subnet.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/virtualNetworks/mtc-network/subnets/mtc-subnet][0m
[0m[1mmodule.network.azurerm_subnet_network_security_group_association.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/virtualNetworks/mtc-network/subnets/mtc-subnet][0m
[0m[1mmodule.network.azurerm_network_interface.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Network/networkInterfaces/mtc-nic][0m
[0m[1mmodule.vm.azurerm_linux_virtual_machine.this: Refreshing state... [id=/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Compute/virtualMachines/mtc-vm][0m

[0m[1m[32mNo changes.[0m[1m Your infrastructure matches the configuration.[0m

[0mTerraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
Releasing state lock. This may take a few moments...
[0m[1m[32m
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mpublic_ip_address = "51.4.113.244"
resource_group_name = "mtc-resources"
ssh_connection_command = "ssh azureuser@51.4.113.244"
virtual_machine_id = "/subscriptions/f9f71262-67c6-48a1-ad2f-75ed5b29135b/resourceGroups/mtc-resources/providers/Microsoft.Compute/virtualMachines/mtc-vm"
virtual_machine_name = "mtc-vm"
## terraform output
Public IP from Terraform: 51.4.113.244

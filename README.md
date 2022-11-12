# AzurePowerShellScript
This script will spin up 3 linux vms with different names and 3 3 different public IPs


#PowerShell with Azure from your local terminal

First you need to have the latest powershell version installed.
Next is to install the AZ module: Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
To connect your local AZ powershell installation to your Azure subscription: Connect-AzAccount
If you wish to see all subscriptions tied to your local azure powershell installation: Get-AzSubscription
To get the active subscription (one sub can be active at a time): Get-AzContext
To change the active subscription to a specific one: Set-AzContext -Subscription '00000000-0000-0000-0000-000000000000'
To get the list of all resource groups within the subscription: Get-AzResourceGroup or Get-AzResourceGroup | Format-Table
To create a resource group: New-AzResourceGroup -Name <name> -Location <location>
To verify that resources were created: Get-AzResource or Get-AzResource | Format-table
To search for a specific resource: Get-AzResource -ResourceGroupName ExerciseResources

#Creating a VM from local powerShell install

New-AzVm
       -ResourceGroupName <resource group name>
       -Name <machine name>
       -Credential <credentials object>
       -Location <location>
       -Image <image name>

OR

New-AzVm -ResourceGroupName [sandbox resource group name] -Name "testvm-eus-01" -Credential (Get-Credential) -Location "East US" -Image UbuntuLTS -OpenPorts 22 -PublicIpAddressName "testvm-01"

Note: if you change the public Ip address name then make sure to remember it when making commands. But if you only name the VM, then that name applies to the rest of the resources under the resource group.
 
To list the VMs in your subscription: Get-AzVM -Status

Once the virtual machine is created, you can assign the name of the machine and it’s resource group to a preferred variable. This way when you call that variable, it displays the properties saved to it.

Example: 

$NorthEUVm = (Get-AzVM -Name "testvm-northEU" -ResourceGroupName powerShellTest)

When you call the variable, it should show something like this:

ResourceGroupName : [sandbox resource group name]
Id  : /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/[sandbox resource group name]/providers/Microsoft.Compute/virtualMachines/testvm-eus-01
VmId              : 00000000-0000-0000-0000-000000000000
Name              : testvm-eus-01
Type              : Microsoft.Compute/virtualMachines
Location          : eastus
Tags              : {}
HardwareProfile   : {VmSize}
NetworkProfile    : {NetworkInterfaces}
OSProfile         : {ComputerName, AdminUsername, LinuxConfiguration, Secrets}
ProvisioningState : Succeeded
StorageProfile    : {ImageReference, OsDisk, DataDisks}

#You can then use the dot notation to access other properties like:

$NorthEUVm.Location

This should output: eastus.

$NorthEUVm.OSProfile.ComputerName

This should output: testvm-northEU (if this was the name used).

#SSH into the VM
First you need to get the public IP address: Get-AzPublicIpAddress -ResourceGroupName < resource group name> -Name <PublicIpAddressName>

Next: ssh <usernameUsedWhenCreatingTheVM>@<PublicIpAddress>
The VM will ask you for the password used when creating the VM, enter it then you should be logged into the VM.

#To delete a VM
First you shutdown the VM: Stop-AzVM -Name <nameOfTheVm> -ResourceGroupName <ResourceGroupName>
Now, we can delete the VM: Remove-AzVM -Name <NameOfVm> -ResourceGroupName <ResourceGroupName>
To view all the remaining resources in the group: Get-AzResource -ResourceGroupName <ResourceGroupName> | Format-Table
To delete the rest of the resources all at once, we do this: Remove-AzResourceGroup -Name <nameOfResourceGroup>

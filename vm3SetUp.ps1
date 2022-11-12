param([string]$resourceGroup)

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

For ($i = 1; $i -le 3; $i++)
{
  $vmName = "Instance" + $i
  $PubIpAdd = "PubIP" + $i
  Write-Host "Creating VM: " $vmName
  New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Location SwedenCentral -Image UbuntuLTS -OpenPorts 22 -PublicIpAddressName $PubIpAdd
}

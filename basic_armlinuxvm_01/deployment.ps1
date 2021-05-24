$projectName = "website001"
$resourceGroupName = "rsgr${projectName}"
$location = "eastus"
New-AzResourceGroup -Name "$resourceGroupName" -Location "$location" 


New-AzResourceGroupDeployment -ResourceGroupName "$resourceGroupName" -TemplateFile "./azuredeploy.json" -TemplateParameterFile "./azuredeploy.parameters.json" -Verbose

# Remove-AzResourceGroup -Name $resourceGroupName 
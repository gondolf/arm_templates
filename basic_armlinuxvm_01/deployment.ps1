$subscriptionid = '8bacf08c-ed66-4a7f-9c82-af1ce9a68cce'
$projectName = "website001"
$resourceGroupName = "rsgr${projectName}"

Select-AzSubscription $subscriptionid

# $location = "eastus"
# New-AzResourceGroup -Name "$resourceGroupName" -Location "$location" 
# Remove-AzResourceGroup -Name $resourceGroupName 


New-AzResourceGroupDeployment -ResourceGroupName "$resourceGroupName" -TemplateFile "./azuredeploy.json" -TemplateParameterFile "./azuredeploy.parameters.json" -Verbose


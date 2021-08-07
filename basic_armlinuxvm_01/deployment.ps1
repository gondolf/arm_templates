$subscriptionid = '8bacf08c-ed66-4a7f-9c82-af1ce9a68cce'
$projectName = "website001"
$resourceGroupName = "rsgr${projectName}"

Select-AzSubscription $subscriptionid

# $location = "eastus"
# New-AzResourceGroup -Name "$resourceGroupName" -Location "$location" 
# Remove-AzResourceGroup -Name $resourceGroupName 


New-AzResourceGroupDeployment -ResourceGroupName "$resourceGroupName" -TemplateFile "./azuredeploy.json" -TemplateParameterFile "./azuredeploy.parameters.json" -Verbose

<#
$url = "https://fappgee01.azurewebsites.net/api/GitHubPrivateRepoFileFetcher?githuburi=https://raw.githubusercontent.com/gondolf/arm_templates/master/basic_armlinuxvm_01/azuredeploy.json&githubaccesstoken=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"
[uri]::EscapeDataString($url)

https%3A%2F%2Ffappgee01.azurewebsites.net%2Fapi%2FGitHubPrivateRepoFileFetcher%3Fgithuburi%3Dhttps%3A%2F%2Fraw.githubusercontent.com%2Fgondolf%2Farm_templates%2Fmaster%2Fbasic_armlinuxvm_01%2Fazuredeploy.json%26githubaccesstoken%3D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
#>
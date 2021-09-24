param (
    [Parameter(Mandatory = $false)] [String]  $TenantId = "78153f1a-b836-436b-b9bb-281f4fe2d1d0",
    [Parameter(Mandatory = $false)] [String]  $Subscriptionid = "8bacf08c-ed66-4a7f-9c82-af1ce9a68cce",
    [Parameter(Mandatory = $false)] [String]  $ResourceGroupName = 'arsgrj6eu1p01',
    [Parameter(Mandatory = $false)] [string]  $TemplateFile = "./azuredeployNewVM-WinAvSet.json",
    [Parameter(Mandatory = $false)] [String]  $TemplateParameterFile = "./azuredeploy.parameters.json",
    [Parameter(Mandatory = $false)] [switch]  $WhatIf 
)

$DebugPreference = 'Continue'
function Login($SubscriptionId, $TenantId) {
    $context = Get-AzContext

    if (!$context -or ($context.Subscription.Id -ne $SubscriptionId)) {
        Connect-AzAccount -TenantId $TenantId
        Select-AzSubscription   -subscriptionid    $SubscriptionId
        Write-Output " Authenticated in tenant: $($context.Tenant.Id)"
    } 
    else {
        Write-Output "SubscriptionId '$SubscriptionId' already connected"
    }
}


if ($WhatIf.IsPresent) {
    Write-Output "Whatif $($true)"
    New-AzResourceGroupDeployment -Name "OnDemandDeployment" -ResourceGroupName $ResourceGroupName -Location "EastUs" -TemplateFile $TemplateFile -TemplateParameterFile $TemplateParameterFile  -DeploymentDebugLogLevel All -WhatIf

}
else {
    Write-Output "whatIf $($false)"
    New-AzResourceGroupDeployment -Name "OnDemandDeployment" -ResourceGroupName $ResourceGroupName  -Location "EastUs" -TemplateFile $TemplateFile -TemplateParameterFile $TemplateParameterFile  -DeploymentDebugLogLevel All
}
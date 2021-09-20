param (
    [Parameter(Mandatory = $false)] [String]  $TenantId = '00193bc8-dddd-41dd-8c93-264763bc0348',
    [Parameter(Mandatory = $false)] [String]  $Rubscriptionid = 'd9bc6363-1579-4256-8ac0-7686697ffdb4',
    [Parameter(Mandatory = $false)] [String]  $ResourceGroupName = 'arsgraddeu1p01',
    [Parameter(Mandatory = $false)] [string]  $TemplateFile = "./azuredeploysinglevm.json",
    [Parameter(Mandatory = $false)] [String]  $TemplateParameterFile = "./azuredeploy.parameters.json",
    [Parameter(Mandatory = $false)] [switch]  $WhatIf 
)

$DebugPreference = 'Continue'
function Login($SubscriptionId) {
    $context = Get-AzContext

    if (!$context -or ($context.Subscription.Id -ne $SubscriptionId)) {
        Connect-AzAccount -TenantId $context.Tenant.Id
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
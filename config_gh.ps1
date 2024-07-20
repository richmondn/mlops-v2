$project_name = 'mlops-project1'
$spn_name = 'mlops-project1-sp'

$spn_json = az ad sp create-for-rbac --name $spn_name --role Contributor --scopes /subscriptions/$subscription_id --json-auth
$spn = $spn_json | ConvertFrom-Json -AsHashtable

Set-Location ../$project_name

gh secret set AZURE_CREDENTIALS -b "$spn_json"
gh secret set ARM_CLIENT_ID -b "$($spn.clientId)"
gh secret set ARM_CLIENT_SECRET -b "$($spn.clientSecret)"
gh secret set ARM_SUBSCRIPTION_ID -b "$($spn.subscriptionId)"
gh secret set ARM_TENANT_ID -b "$($spn.tenantId)"

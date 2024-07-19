$project_name = 'mlops-project1'
$github_org_name = 'richmondn'
$spn_name = 'mlops-project1-sp'
$subscription_id = (az account show --query id -o tsv)

$spn_json = az ad sp create-for-rbac --name $spn_name --role Contributor --scopes /subscriptions/$subscription_id
$spn = $spn_json | ConvertFrom-Json -AsHashtable

Set-Location ../$project_name

gh secret set AZURE_CREDENTIALS -b "$spn_json"
gh secret set ARM_CLIENT_ID -b "$($spn.appId)"
gh secret set ARM_CLIENT_SECRET -b "$($spn.password)"
gh secret set ARM_SUBSCRIPTION_ID -b "$subscription_id"
gh secret set ARM_TENANT_ID -b "$($spn.tenant)"


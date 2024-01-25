param(
    [string] $Organisation = "lsc-sde",
    [string] $Repo
)

function Set-GitHubEnvironment {
    param (
        [string] $Organisation,
        [string] $Repo,
        [string] $EnvironmentName,
        [int] $TeamId = 0
    )
    
    $URL = "repos/${Organisation}/${Repo}/environments/${EnvironmentName}"
    if($TeamId -eq 0){
        gh api --method PUT -H "Accept: application/vnd.github+json" $URL | ConvertFrom-Json
    }
    else {
        $content = "{ ""reviewers"" : [ { ""type"" : ""Team"", ""id"" : ${TeamId} } ]}"
        $content | gh api --method PUT -H "Accept: application/vnd.github+json" --input - $URL | ConvertFrom-Json

    }
}

function Get-GitHubTeams {
    param (
        [string] $Organisation
    )
    $URL = "orgs/${Organisation}/teams"
    gh api --method GET -H "Accept: application/vnd.github+json" $URL | ConvertFrom-Json
}

function Set-GitHubTeamsRepo {
    param (
        [string] $Organisation,
        [string] $Team,
        [string] $Repo
    )
    $URL = "orgs/${Organisation}/teams/${Team}/repos/${Organisation}/${Repo}"
    gh api --method PUT -H "Accept: application/vnd.github+json" $URL | ConvertFrom-Json
}

$Teams = Get-GitHubTeams -Organisation $Organisation
$developmentTeam = ($Teams |? { $_.name -eq "dev" })
$productionTeam = ($Teams |? { $_.name -eq "production" })

write-host "Dev = $($developmentTeam.id)"
write-host "Production = $($productionTeam.id)"

Set-GitHubTeamsRepo -Organisation $Organisation -Repo $Repo -Team $developmentTeam.name
Set-GitHubTeamsRepo -Organisation $Organisation -Repo $Repo -Team $productionTeam.name
Set-GitHubEnvironment -Organisation $Organisation -Repo $Repo -EnvironmentName "sandbox"
Set-GitHubEnvironment -Organisation $Organisation -Repo $Repo -EnvironmentName "dev" -TeamId $developmentTeam.id
Set-GitHubEnvironment -Organisation $Organisation -Repo $Repo -EnvironmentName "production" -TeamId $productionTeam.id

#gh api --method PUT -H "Accept: application/vnd.github+json" "${RepoUrl}/environments/dev" -d "{""type"" : ""Team"", ""id"" : ""${devTeamId}""}"
#gh api --method PUT -H "Accept: application/vnd.github+json" "${RepoUrl}/environments/production" -d "{""type"" : ""Team"", ""id"" : ""${productionTeamId}""}"
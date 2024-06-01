#projcet一覧read
$projects = Import-Csv .\test.csv

#事前project一覧出力
#☆コマンド $before_projects
#$before_projects | Export-Csv -Path "before_projects.csv" -Encoding UTF8 -NoTypeInformation
$projects | Export-Csv -Path "all_project.csv" -Encoding UTF8 -NoTypeInformation

# 確認処理
$title = "confirm"
$objYes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","yes"
$objNo = New-Object System.Management.Automation.Host.ChoiceDescription "&No","no"
$objend = New-Object System.Management.Automation.Host.ChoiceDescription "&End","end"
$objOptions = [System.Management.Automation.Host.ChoiceDescription[]]($objYes, $objNo, $objend)

foreach ($project in $projects){
    Write-Host "delete target"
    Write-Host "ID:$($project.ID)"
    Write-Host "Name:$($project.Name)"
    # 削除処理
    $resultVal = $host.ui.PromptForChoice($title, $message, $objOptions, 1)
    switch ($resultVal){
        0 {
            Write-Host "delete project"
            #☆コマンド $after_projects_all
            #$after_projects | Export-Csv -Path "after_projects.csv" -Encoding UTF8 -NoTypeInformation
            #diff (cat ".\before_projects.csv") (cat ".\after_projects.csv") > DIFF.txt
            $after_projects = Import-Csv .\after_projects.csv
            diff (cat ".\before_projects.csv") (cat ".\after_projects.csv") > DIFF.txt
            #$after_projects | Export-Csv -Path "after_project.csv" -Encoding UTF8 -NoTypeInformation            
          }
        1 {
            Write-Host "not delete"
        }
        2 {
            Write-Host "end script"
        }
    }

}
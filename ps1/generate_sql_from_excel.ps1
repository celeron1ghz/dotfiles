param($file)

if (!$file) {
    echo "no file in args"
    exit;
}

$filename =  (Convert-Path .) + $file;
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false

[void]$excel.Workbooks.Open($file)
$sheet = $excel.Worksheets.Item(1)

## 1行目で、空行を含まない列までを出力対象とする（メモ書きやURL等を記載するため、まるごと出力できない）
## なので空白列手前までを取得する
[array]$columns = @();

for ($i = 1; $i -lt $sheet.UsedRange.Columns.Count + 1; $i++){
    $v = $sheet.UsedRange.Cells(1, $i).Value()

    if (!$v) {
        break;
    }

    $columns += $v;
}

## 行に対しても列と同様に、空白行手前までを取得とする
[array] $rows = @()

for ($i = 2; $i -lt $sheet.UsedRange.Rows.Count; $i++){
    $v = $sheet.UsedRange.Cells($i, 1).Value()

    if (!$v) {
        break;
    }

    $rows += $v;
}

#echo ("col = " + $columns.Count)
#echo ("row = " + $rows.Count)

[array] $result = @();

2 .. ($rows.Count + 2) | %{
    [int] $row = $_;
    [array] $values = 1 .. ($columns.Count) `
        | %{ $sheet.UsedRange.Cells($row, $_).Value() } `

    [array] $emptys = $values | ?{ $_ -eq $null -or $_ -eq '' }

    if ($emptys.Length -eq $columns.Length) {
        return
    }

    [array] $filtered = $values `
        | %{ $_ -replace "`r?`n", "<br>" } `
        | %{ $_ -replace "'", "''" } `
        | %{ "'$_'" }

    $result += ($filtered -join ", ")
}

$result = ($result | %{ "($_)" })

echo "INSERT INTO table ($($columns -join ', ')) VALUES " | Set-Content "master_data.sql" -Encoding utf8
echo (" " + ($result -join "`n,"))                             | Add-Content "master_data.sql" -Encoding utf8
echo ";"                                                       | Add-Content "master_data.sql" -Encoding utf8

[void]$excel.Quit()

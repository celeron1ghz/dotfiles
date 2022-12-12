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

## where句に指定するのは1列目とし、取り除く
$whereCol = $columns[0];
$columns = $columns[1 .. ($columns.Length)];

[array] $result = @();

2 .. ($rows.Count + 2) | %{
    [int] $row = $_;
    [array] $values = 1 .. ($columns.Count + 1) `
        | %{ $sheet.UsedRange.Cells($row, $_).Value() } `

    [array] $emptys = $values | ?{ $_ -eq $null -or $_ -eq '' }

    if ($emptys.Length -eq $columns.Length) {
        return
    }

    $whereVal = $values[0];
    $values = $values[1 .. ($values.Length)];

    $cval = 0 .. ($values.Length - 1) | %{
	$v1 = $columns[$_];
	$v2 = $values[$_];

        $v2 = $v2 -replace "`r?`n", "<br>"
        $v2 = $v2 -replace "'", "''"

	return "$v1 = '$v2'";
    }

    $setClause = ($cval -join ", ");
    $result += "UPDATE __table__ SET $setClause WHERE $whereCol = $whereVal;"
}

echo "" | Set-Content "update_data.sql" -Encoding utf8
echo ($result -join "`n") | Add-Content "update_data.sql" -Encoding utf8

[void]$excel.Quit()

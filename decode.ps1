# 电子情书配置代码解码器
# 用法: .\decode.ps1 "ELC:v1:eyJ..."

param([string]$Code)

if (-not $Code) {
    Write-Host "请输入配置代码 (ELC:v1:...)"
    $Code = Read-Host "> "
}

# 去掉前缀
if ($Code.StartsWith("ELC:v1:")) {
    $Code = $Code.Substring(7)
}

# Base64解码
$json = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Code))
$config = $json | ConvertFrom-Json

# 输出
Write-Host "`n=== 配置内容 ===" -ForegroundColor Cyan
$config.PSObject.Properties | ForEach-Object {
    $key = $_.Name
    $val = $_.Value
    if ($val -is [Array]) {
        $val = $val -join ", "
    }
    Write-Host "$key : $val"
}
Write-Host "================`n"

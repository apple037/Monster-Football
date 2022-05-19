### MFEToken.sol
## 給予權限
- function: approve
- 給予指定地址NFT Token的操作權限
- transaction
```
{
    "to": 0x48dDB5C06084fCD4eB6838671254bd0AE7b08A9B,
    "tokenId": 1
}
```
# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|to|接收人地址|address|
|tokenId|token id|uint|

## 轉移
- function: transferFrom
- 轉移NFT所有權，操作人須有token的操作權限(approve)
- transaction
```
{
    "from": 0x48dDB5C06084fCD4eB6838671254bd0AE7b08A9B,
    "to": 0x5ba58D44c481149eB8FBE4dfeABdff9f15f515c5,
    "tokenId": 1
}
```
# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|from|發送人地址|address|
|to|接收人地址|address|
|tokenId|token id|uint|

## 設定NFT URI前綴
- function: setURIPrefix
- 設定NFT URI前綴
- transaction
```
{
    "prefix": "test"
}
```
# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|prefix|前綴|string|

## 查詢NFT狀態
- function: states
- 查詢NFT狀態
- view only
```
{
    "id": 1
}
```
# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|id|token id|uint|

- Response
```
{
    0
}
```
# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|state|0: normal,1: partTime, 2: dead, 3: selling|uint|

## 修改NFT狀態
- function: stateChangeUser
- 修改NFT狀態


# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|id|token id|uint|
|state|token state|uint|
|nonce|亂數|uint|
|signature|簽章|string|


## 查詢NFT總數
- function: totalSupply
- 查詢NFT總數
- view only

# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
||total supply|uint|

- Response
```
{
    10
}
```




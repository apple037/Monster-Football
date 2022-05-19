### MFEToken.sol
## 給予權限
- function: approve
- 給予指定地址MFB Token的操作權限
- transaction
```
{
    "spender": 0x48dDB5C06084fCD4eB6838671254bd0AE7b08A9B,
    "amount": 1
}
```
# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|to|接收人地址|address|
|tokenId|token id|uint|

## 轉移
- function: transferFrom
- 轉移MFB，操作人須有token的操作權限(approve)
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

## 轉移
- function: transfer
- 從自身轉移MFB
- transaction
```
{
    "to": 0x5ba58D44c481149eB8FBE4dfeABdff9f15f515c5,
    "tokenId": 1
}
```
# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|to|接收人地址|address|
|tokenId|token id|uint|


## 查詢NFT總數
- function: totalSupply
- 查詢MFB總數
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




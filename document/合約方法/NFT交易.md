## Market.sol
# 購買NFT
- function: BuyNFT
```
{
    "id": "NFT id"
}
```

# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|id|NFT id|uint|

# 結束拍賣NFT
- function: endSale
```
{
    "id": "NFT id"
}
```

# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|id|NFT id|uint|

# 拍賣NFT
- function: sellNFT
```
{
    "id": "NFT id",
    "price": "5000000000000000000"
}
```

# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|id|NFT id|uint|
|price|價錢(MFB)|uint|

# 查詢NFT價格
- function: prices
```
{
    "id": "NFT id",
}
```

# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|id|NFT id|uint|

# 查詢NFT販售狀態
- function: prices
```
{
    "id": "NFT id",
}
```

# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|id|NFT id|uint|
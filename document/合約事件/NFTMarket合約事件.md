## NFT交易
### 買賣NFT
- 事件名稱: buyOrSell

| 參數名稱 | 參數說明 | 參數類型 |
|--------|--------|--------|
|isSell|是否為販售|boolean|
|seller|caller地址|address|
|id|tokenId|uint|
|price|價格|uint|

### 購買NFT
- 事件名稱: close

| 參數名稱 | 參數說明 | 參數類型 |
|--------|--------|--------|
|id|tokenId|uint|

### MFB傳送
- 事件名稱: toAddress

| 參數名稱 | 參數說明 | 參數類型 |
|--------|--------|--------|
|buyer|購買者地址|address|
|amount|傳送數量|uint|
|t_type|傳送類型|string|
> t_type : "pool","rebate"
>> pool: 轉至獎勵池
>> purchase: 轉至販賣者地址
>> operator: 官方錢包


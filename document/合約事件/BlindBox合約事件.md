## 盲盒合約
### 新增盲盒廣告
- 事件名稱: addAd

| 參數名稱 | 參數說明 | 參數類型 |
|--------|--------|--------|
|id|盲盒id|uint|
|name|盲盒名稱|string|
|startTime|開始時間|uint|
|endTime|結束時間|uint|
|price|價格|uint|
|state|狀態|boolean|
|amount|數量|uint|

### 購買盲盒
- 事件名稱: buyBox

| 參數名稱 | 參數說明 | 參數類型 |
|--------|--------|--------|
|adId|盲盒id|uint|
|buyer|購買者地址|address|
|price|價格|uint|
|amount|數量|uint|

### 關閉盲盒
- 事件名稱: changeBoxState

| 參數名稱 | 參數說明 | 參數類型 |
|--------|--------|--------|
|adId|盲盒id|uint|
|state|盲盒|boolean|

### MFB傳送
- 事件名稱: toAddress

| 參數名稱 | 參數說明 | 參數類型 |
|--------|--------|--------|
|buyer|購買者地址|address|
|amount|傳送數量|uint|
|t_type|傳送類型|string|
> t_type : "pool","rebate"
>> pool: 轉至獎勵池
>> rebate: 轉至代理池


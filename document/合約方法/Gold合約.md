## GoldPool.sol
# 開始打工
- function: startPartTime
- cost: 0.00075348BNB
- 鎖定NFT為不可交易狀態並記錄當下區塊編號
```
{
    "id": 1
}
```
# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|id|Token id|int|

# 結束打工
- function: endPartTime
- cost: 0.00075348BNB
- 解除NFT為不可交易狀態並記錄當下區塊編號減去開始區塊編號作為獎勵區塊數
```
{
    "id": 1
}
```
# 參數說明
|參數名稱(英文)|參數名稱(中文)&參數說明|參數型態|
|:--|:--|:--|
|id|Token id|int|

# 領取獎勵
- function: claimGold
- cost: 0.00075348BNB
- 領取獎勵

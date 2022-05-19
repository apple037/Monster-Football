## Monster Football Smart Contract
### Usage
1. 設定truffle.config中的network config, 若使用metamask等第三方提供者，請將助憶詞先存下來
2. 編譯合約
    ```truffle compile```
3. 部屬合約至指定provider
    - compile first
    - command
    ```truffle migrate --network (testnet|ganache_gui|ganache_docker)```
    - deploy without compiling
    - command
    ```truffle deploy --network testnet --reset --compile-none```
4. 撰寫測試script測試合約互動
5. 測試環境合約地址
6. 使用json2csv.js將address.json轉成csv並匯入db
	```node json2csv.js (testnet|ganache_gui|ganache_docker)```
7. 如果只要執行步驟三 3_add_mapping.js
    ```truffle migrate -f 3 --to 3```
### ganache-cli
#### docker
```docker run --name local-ganache --detach --publish 8545:8545 trufflesuite/ganache:latest```
#### local
```npm install ganache-cli```
```ganache-cli```
### ganache-gui
[Download link](https://trufflesuite.com/ganache/)
- 設定rpc server port
- 如需測試監聽，關閉 automining 並設定自動產塊 
## Contracts
| 合約           | 地址 | 測試鏈部署費 | Mapping |
|--------------| ----------- | ----------- |---------|
| Pancake Pair |[0xe58f2a731e003e035c39AfA05DCC78DA48091a24](https://testnet.bscscan.com/address/0xe58f2a731e003e035c39AfA05DCC78DA48091a24)|0.00BNB| pancake |
| 測試錢包         |[0xe798505BF9158Ba14D687877F96e99890e7580D3](https://testnet.bscscan.com/address/0xe798505BF9158Ba14D687877F96e99890e7580D3)|0.00BNB| wallet  |
| BUSD         |[0x3557e99D09E05853d7BF6BD6Df1D50Bf70a6A374](https://testnet.bscscan.com/address/0x3557e99D09E05853d7BF6BD6Df1D50Bf70a6A374)|0.00BNB| busd    |

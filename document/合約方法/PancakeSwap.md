# 在Pancake Swap上查詢價格
1. 先建立MFB-BUSD質押池
2. 在 [PancakeFactory](https://testnet.bscscan.com/address/0xb7926c0430afb07aa7defde6da862ae0bde767bc#readContract) 中使用getPair查詢質押池合約地址
3. 在質押池合約中找getReserves()方法得到兩種幣之間的比例去推估價格
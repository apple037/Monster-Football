const adrCenter = artifacts.require("AddressCenter.sol");

contract("Address Center", accounts => {
    it("should be owned by the first account in the ganache", () =>
    adrCenter.deployed()
        .then(instance => instance.owner().call())
        .then(balance =>
            )

    )
})
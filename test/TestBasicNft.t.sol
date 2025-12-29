// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {BasicNft} from "src/BasicNft.sol";

contract TestBasicNft is Test {
    DeployBasicNft public deployBasicNft;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }
    function test_basicNft_name() public view {
        string memory name = "PixelPads";
        string memory nftName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(name)) ==
                keccak256(abi.encodePacked(nftName))
        );
    }

    function test_mint_canMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(
            "ipfs://QmRyDzTnZdZzEcuruayRUs1Ap35crYhpj6kAnhKDVgYQeA"
        );
        assert(basicNft.balanceOf(USER) == 1);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {BasicNft} from "src/BasicNft.sol";

contract TestBasicNft is Test {
    DeployBasicNft public deployBasicNft;
    BasicNft public basicNft;
    // 因使用 user 创建地址使用fork 测试会报错，因为该地址在sepolia上面有合约，但是没有继承ERC721就会导致错误
    address public USER = makeAddr("xiatianuser");

    string constant PUG =
        "ipfs://QmRyDzTnZdZzEcuruayRUs1Ap35crYhpj6kAnhKDVgYQeA";

    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
        vm.deal(USER, 10 ether);
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
        basicNft.mintNft(PUG);
        assert(basicNft.balanceOf(USER) == 1);
    }
}

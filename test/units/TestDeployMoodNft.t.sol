// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
contract TestDeployMoodNft is Test {
    DeployMoodNft public deployMoodNft;
    function setUp() public {
        deployMoodNft = new DeployMoodNft();
    }

    function test_SvgToImageURI() public {
        string
            memory baseUri = "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/PjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+PHN2ZyB0PSIxNzY3NjE4MzA3ODc1IiBjbGFzcz0iaWNvbiIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHAtaWQ9IjEwMzUiIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+PHBhdGggZD0iTTIwNC42IDY2LjRoMjU4LjFjMTgxLjQgMCAzMDQuNCA2My4zIDMwNC40IDIxNy45IDAgODguOS00Ny41IDE2NS41LTEzMi43IDE5My41djQuOWMxMDkuNiAyMC43IDE4NSA5Mi41IDE4NSAyMTQuMyAwIDE3NC4xLTEzNy41IDI2MC41LTMzNy4yIDI2MC41SDIwNC42VjY2LjR6TTQ0MiA0NDguN2MxNjAuNyAwIDIyNS4yLTU4LjQgMjI1LjItMTUyLjEgMC0xMDkuNi03NC4zLTE0OS43LTIxOS4xLTE0OS43SDMwNS43djMwMS45SDQ0MnogbTI0LjQgNDI4LjVjMTU4LjIgMCAyNTQuNC01Ny4yIDI1NC40LTE4My44IDAtMTE0LjQtOTIuNS0xNjYuOC0yNTQuNC0xNjYuOEgzMDUuN3YzNTAuNmgxNjAuN3oiIHAtaWQ9IjEwMzYiPjwvcGF0aD48L3N2Zz4=";
        string
            memory svg = '<?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"><svg t="1767618307875" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1035" xmlns:xlink="http://www.w3.org/1999/xlink" width="200" height="200"><path d="M204.6 66.4h258.1c181.4 0 304.4 63.3 304.4 217.9 0 88.9-47.5 165.5-132.7 193.5v4.9c109.6 20.7 185 92.5 185 214.3 0 174.1-137.5 260.5-337.2 260.5H204.6V66.4zM442 448.7c160.7 0 225.2-58.4 225.2-152.1 0-109.6-74.3-149.7-219.1-149.7H305.7v301.9H442z m24.4 428.5c158.2 0 254.4-57.2 254.4-183.8 0-114.4-92.5-166.8-254.4-166.8H305.7v350.6h160.7z" p-id="1036"></path></svg>';

        string memory svgUri = deployMoodNft.svgToImageURI(svg);
        assert(
            keccak256(abi.encodePacked(svgUri)) ==
                keccak256(abi.encodePacked(baseUri))
        );
    }
}

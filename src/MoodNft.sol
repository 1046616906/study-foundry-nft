// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
contract MoodNft is ERC721 {
    error MoodNft__NotAuthorized();

    uint256 private tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;
    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood) private s_tokenIdToMood;
    constructor(
        string memory happySvgImageUri,
        string memory sadSvgImageUri
    ) ERC721("Mood NFT", "MN") {
        tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function mintNft() public {
        s_tokenIdToMood[tokenCounter] = Mood.HAPPY;
        _safeMint(msg.sender, tokenCounter);
        tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        address owner = _ownerOf(tokenId);
        if (!_isAuthorized(owner, msg.sender, tokenId)) {
            revert MoodNft__NotAuthorized();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64;,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI = s_tokenIdToMood[tokenId] == Mood.HAPPY
            ? s_happySvgImageUri
            : s_sadSvgImageUri;
        // abi.encodePacked return type is bytes
        bytes memory dataURI = abi.encodePacked(
            '{"name":"',
            name(),
            '","description": "An adorable PUG pup!","image": "',
            imageURI,
            '","attributes": [{"trait_type": "cuteness","value": 100}]}'
        );
        // Base64.encode return type is string
        return string.concat(_baseURI(), Base64.encode(dataURI));
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {MoodNft} from "src/MoodNft.sol";

contract TestDeployMoodNftIntegrations is Test {
    DeployMoodNft deployMoodNft;
    MoodNft moodNft;
    string private constant HAPPY_NFT_URI =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDUiIGZpbGw9IiNGRkQ3MDAiIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIyIi8+CiAgPGNpcmNsZSBjeD0iMzUiIGN5PSI0MCIgcj0iNSIgZmlsbD0iIzAwMCIvPgogIDxjaXJjbGUgY3g9IjY1IiBjeT0iNDAiIHI9IjUiIGZpbGw9IiMwMDAiLz4KICA8cGF0aCBkPSJNIDMwIDY1IFEgNTAgODUgNzAgNjUiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIzIiBzdHJva2UtbGluZWNhcD0icm91bmQiLz4KPC9zdmc+";
    string private constant SAD_NFT_IMAGE_URI =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDUiIGZpbGw9IiNBREQ4RTYiIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIyIi8+CiAgPGNpcmNsZSBjeD0iMzUiIGN5PSI0MCIgcj0iNSIgZmlsbD0iIzAwMCIvPgogIDxjaXJjbGUgY3g9IjY1IiBjeT0iNDAiIHI9IjUiIGZpbGw9IiMwMDAiLz4KICA8cGF0aCBkPSJNIDM1IDc1IFEgNTAgNjAgNjUgNzUiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIzIiBzdHJva2UtbGluZWNhcD0icm91bmQiLz4KICA8cGF0aCBkPSJNIDM1IDQ4IEwgMzUgNTgiIHN0cm9rZT0iIzAwN0JGRiIgc3Ryb2tlLXdpZHRoPSIzIiBzdHJva2UtbGluZWNhcD0icm91bmQiLz4KICA8cGF0aCBkPSJNIDY1IDQ4IEwgNjUgNTgiIHN0cm9rZT0iIzAwN0JGRiIgc3Ryb2tlLXdpZHRoPSIzIiBzdHJva2UtbGluZWNhcD0icm91bmQiLz4KPC9zdmc+";
    string constant SAD_NFT_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZCBORlQiLCJkZXNjcmlwdGlvbiI6ICJBbiBhZG9yYWJsZSBQVUcgcHVwISIsImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjNhV1IwYUQwaU1UQXdJaUJvWldsbmFIUTlJakV3TUNJZ2RtbGxkMEp2ZUQwaU1DQXdJREV3TUNBeE1EQWlJSGh0Ykc1elBTSm9kSFJ3T2k4dmQzZDNMbmN6TG05eVp5OHlNREF3TDNOMlp5SStDaUFnUEdOcGNtTnNaU0JqZUQwaU5UQWlJR041UFNJMU1DSWdjajBpTkRVaUlHWnBiR3c5SWlOQlJFUTRSVFlpSUhOMGNtOXJaVDBpSXpBd01DSWdjM1J5YjJ0bExYZHBaSFJvUFNJeUlpOCtDaUFnUEdOcGNtTnNaU0JqZUQwaU16VWlJR041UFNJME1DSWdjajBpTlNJZ1ptbHNiRDBpSXpBd01DSXZQZ29nSUR4amFYSmpiR1VnWTNnOUlqWTFJaUJqZVQwaU5EQWlJSEk5SWpVaUlHWnBiR3c5SWlNd01EQWlMejRLSUNBOGNHRjBhQ0JrUFNKTklETTFJRGMxSUZFZ05UQWdOakFnTmpVZ056VWlJR1pwYkd3OUltNXZibVVpSUhOMGNtOXJaVDBpSXpBd01DSWdjM1J5YjJ0bExYZHBaSFJvUFNJeklpQnpkSEp2YTJVdGJHbHVaV05oY0QwaWNtOTFibVFpTHo0S0lDQThjR0YwYUNCa1BTSk5JRE0xSURRNElFd2dNelVnTlRnaUlITjBjbTlyWlQwaUl6QXdOMEpHUmlJZ2MzUnliMnRsTFhkcFpIUm9QU0l6SWlCemRISnZhMlV0YkdsdVpXTmhjRDBpY205MWJtUWlMejRLSUNBOGNHRjBhQ0JrUFNKTklEWTFJRFE0SUV3Z05qVWdOVGdpSUhOMGNtOXJaVDBpSXpBd04wSkdSaUlnYzNSeWIydGxMWGRwWkhSb1BTSXpJaUJ6ZEhKdmEyVXRiR2x1WldOaGNEMGljbTkxYm1RaUx6NEtQQzl6ZG1jKyIsImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogImN1dGVuZXNzIiwidmFsdWUiOiAxMDB9XX0=";
    address USER = makeAddr("user");

    function setUp() public {
        deployMoodNft = new DeployMoodNft();
        moodNft = deployMoodNft.run();
    }

    function test_View_TokenUriIntegations() public {
        vm.prank(USER);
        moodNft.mintNft();
    }

    function test_FlipMoodToSad() public {
        vm.prank(USER);
        moodNft.mintNft();

        vm.prank(USER);
        moodNft.flipMood(0);
        assertEq(
            keccak256(abi.encodePacked(moodNft.tokenURI(0))),
            keccak256(abi.encodePacked(SAD_NFT_URI))
        );
    }
}

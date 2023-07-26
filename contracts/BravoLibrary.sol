// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
//...............................................................................................................
//..ZZZZZZZZZ...EEEEEEEEE...RRRRR..........OOOOOO..............AAA.......RRRRR........MMM.....MMM...YY......YY...
//.ZZZZZZZZZZZ.EEEEEEEEEEE.RRRRRRRRRR.....OOOOOOOOO...........AAAAA.....RRRRRRRRRR...MMMMM...MMMMM.YYYYY...YYYY..
//.ZZZZZZZZZZZ.EEEEEEEEEEE.RRRRRRRRRRR...OOOOOOOOOO...........AAAAA.....RRRRRRRRRRR..MMMMM...MMMMM.YYYYY..YYYYY..
//.ZZZZZZZZZZZ.EEEEEEEEEEE.RRRRRRRRRRR..OOOOOOOOOOOO.........AAAAAAA....RRRRRRRRRRR..MMMMMM..MMMMM..YYYY..YYYY...
//......ZZZZZZ.EEEE........RRRR...RRRRR.OOOO....OOOO.........AAAAAAA....RRRR...RRRRR.MMMMMM.MMMMMM..YYYYYYYYYY...
//.....ZZZZZZ..EEEEEEEEEE..RRRR...RRRRR.OOOO....OOOOO........AAAAAAA....RRRR...RRRRR.MMMMMM.MMMMMM...YYYYYYYY....
//.....ZZZZZ...EEEEEEEEEE..RRRRRRRRRRR.OOOO......OOOO.......AAAAAAAAA...RRRRRRRRRRR..MMMMMM.MMMMMM...YYYYYYYY....
//....ZZZZZ....EEEEEEEEEE..RRRRRRRRRRR.OOOO......OOOO.......AAAA.AAAA...RRRRRRRRRRR..MMMMMM.MMMMMM....YYYYYY.....
//...ZZZZZ.....EEEEEEEEEE..RRRRRRRRRRR.OOOO......OOOO.......AAAAAAAAAA..RRRRRRRRRRR..MMMMMMMMMMMMM.....YYYYY.....
//..ZZZZZ......EEEE........RRRR..RRRRR..OOOO....OOOOO......AAAAAAAAAAA..RRRR..RRRRR..MMM.MMMMMMMMM.....YYYY......
//.ZZZZZZ......EEEE........RRRR...RRRR..OOOO....OOOO.......AAAAAAAAAAA..RRRR...RRRR..MMM.MMMMM.MMM.....YYYY......
//.ZZZZZZZZZZZ.EEEEEEEEEEE.RRRR...RRRR..OOOOOOOOOOOO.......AAAAAAAAAAAA.RRRR...RRRR..MMM.MMMMM.MMM.....YYYY......
//.ZZZZZZZZZZZ.EEEEEEEEEEE.RRRR...RRRR...OOOOOOOOOO....... AAAA....AAAA.RRRR...RRRR..MMM.MMMMM.MMM.....YYYY......
//.ZZZZZZZZZZZ.EEEEEEEEEEE.RRRR...RRRRR...OOOOOOOOO....... AAA.....AAAA.RRRR...RRRRR.MMM.MMMMM.MMM.....YYYY......
//.........................................OOOOOO................................................................
//...............................................................................................................
/// @author Simon G.Ionashku - find me on github: simon-masterclass
/// @title Bravo Library
/// @dev This library is used to render the Bravo Company NFTs and their metadata

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

library BravoLibrary {
    using Strings for uint256;

    //struct for cramming all the variables together to avoid stack too deep error
    struct Stack2deep {
        uint256 tokenId;
        uint256 color1;
        string comp2Color1;
        string rank;
        string bravoBoost;
        string codeName;
        string returnBalance;
        string unitName;
    }

    function calculateUnits(
        uint balance
    )
        public
        pure
        returns (string memory returnBalance, string memory unitName)
    {
        //calculate units
        if (uint256(balance / (10 ** 18)) > 0) {
            returnBalance = (balance / (10 ** 18)).toString();
            unitName = "";
        } else if (uint256(balance / (10 ** 16)) > 0) {
            returnBalance = (balance / (10 ** 16)).toString();
            unitName = "CENTI-";
        } else if (uint256(balance / (10 ** 12)) > 0) {
            returnBalance = (balance / (10 ** 12)).toString();
            unitName = "MICRO-";
        } else if (uint256(balance / (10 ** 9)) > 0) {
            returnBalance = (balance / (10 ** 9)).toString();
            unitName = "NANO-";
        } else if (uint256(balance / (10 ** 6)) > 0) {
            returnBalance = (balance / (10 ** 6)).toString();
            unitName = "PICO-";
        } else if (uint256(balance / (10 ** 3)) > 0) {
            returnBalance = (balance / (10 ** 3)).toString();
            unitName = "FEMTO-";
        } else {
            returnBalance = balance.toString();
            unitName = "ATTO-";
        }

        return (returnBalance, unitName);
    }

    function randomNum(
        uint256 _modulus,
        uint256 _seed,
        uint256 _salt
    ) public view returns (uint256) {
        uint256 randomNumber = uint256(
            keccak256(
                abi.encodePacked(block.timestamp, msg.sender, _salt, _seed)
            )
        );
        return randomNumber % _modulus;
    }

    function calcComplimentColor(
        uint256 compNum
    ) internal pure returns (uint256) {
        uint256 comp = compNum + 180;
        if (comp > 360) {
            comp = comp - 360;
        }
        return comp;
    }

    function renderHelper0(
        Stack2deep memory stack2deep
    ) internal pure returns (bytes memory) {
        if(stack2deep.tokenId == 0) {
        return
            abi.encodePacked(
                '<rect stroke="#000000" stroke-dasharray="2,2,',
                (stack2deep.color1 % 13).toString(),
                ',7" stroke-width="17" x="34" y="34" width="711" height="280" opacity="88%" fill="#000000" rx="50" ry="50" />',
                '<text fill="#ffffff" x="50%" y="125" font-size="111" font-family="futura" text-anchor="middle" dominant-baseline="middle">ZERO ARMY</text>',
                '<text fill="hsl(',
                stack2deep.comp2Color1,
                ', 69%, 55%)" stroke="hsl(',
                stack2deep.color1.toString(),
                ', 69%, 50%)" x="50%" y="209" stroke-width="3" font-size="69" font-family="futura" text-anchor="middle" dominant-baseline="middle">BRAVO COMPANY</text>',
                '<text stroke-width="2" stroke="#ffffff" fill="#000000" x="50%" y="265" font-size="49" font-family="courier" text-anchor="middle" dominant-baseline="middle">',
                stack2deep.codeName,
                "</text>"
            );
        } else {
        return
            abi.encodePacked(
                '<rect transform="rotate(-45 388.5 42)" stroke-width="22" fill="#000" x="0" y="-346.5" width="777" height="777" />',
                '<text fill="#ffffff" x="50%" y="117" font-size="122" font-family="futura" text-anchor="middle" dominant-baseline="middle">ZERO ARMY</text>',
                '<text fill="#000000" stroke="hsl(',
                stack2deep.comp2Color1,
                ', 69%, 50%)" x="50%" y="222" stroke-width="4" font-size="69" font-family="futura" text-anchor="middle" dominant-baseline="middle">BRAVO COMPANY</text>'
                '<text fill="hsl(',
                stack2deep.color1.toString(),
                ', 69%, 69%)" x="50%" y="288" font-size="42" font-family="futura" text-anchor="middle" dominant-baseline="middle">',
                stack2deep.codeName,
                "</text>"
            );
        }
    }

    function renderHelper1(
        uint256 color1,
        string memory comp2Color1
    ) internal view returns (bytes memory) {
        return
            abi.encodePacked(
                '<circle stroke="hsl(',
                comp2Color1,
                ', 77%, 34%)" stroke-dasharray="5,',
                (color1 % 34).toString(),
                ",",
                randomNum(69, 2, 7).toString(),
                '" stroke-width="24" cx="388.5" cy="488" r="134" fill="#000000" opacity="69%" />'
            );
    }

    function renderHelper2(
        uint256 tokenId,
        string memory color1,
        string memory comp2Color1
    ) internal pure returns (bytes memory) {
        if (tokenId == 0) {
            return "";
        } else {
            return
                abi.encodePacked(
                    '<circle stroke="hsl(',
                    comp2Color1,
                    ', 69%, 55%)" stroke-dasharray="2,2" stroke-width="7" cx="100" cy="495" r="69" fill="hsl(',
                    color1,
                    ', 69%, 55%)" opacity="69%" />',
                    '<text text-anchor="start" font-family="futura" font-size="18" y="490" x="74">RANK</text>',
                    '<circle stroke="hsl(',
                    comp2Color1,
                    ', 69%, 55%)" stroke-dasharray="2,2" stroke-width="7" cx="677" cy="495" r="69" fill="hsl(',
                    color1,
                    ', 69%, 55%)" opacity="69%" />',
                    '<text text-anchor="end" font-family="futura" font-size="18" y="490" x="709">BOOST</text>'
                );
        }
    }

    function renderHelper3(
        Stack2deep memory stack2deep
    ) internal pure returns (bytes memory) {
        string memory tokenId = stack2deep.tokenId.toString();

        if (stack2deep.tokenId == 0) {
            stack2deep.bravoBoost = stack2deep.rank = "";
            tokenId = "O";
        }

        return
            abi.encodePacked(
                '<text font-family="futura" font-size="111" text-anchor="middle" dominant-baseline="middle" y="500" x="50%" stroke-width="4" stroke="#ffffff" fill="#000000">',
                tokenId,
                "</text>",
                '<text font-weight="bold" text-anchor="middle" font-family="futura" font-size="22" y="517" x="100" fill="hsl(',
                stack2deep.comp2Color1,
                ', 69%, 69%)">',
                stack2deep.rank,
                "</text>",
                '<text font-weight="bold" text-anchor="middle" font-family="futura" font-size="22" y="517" x="678" fill="hsl(',
                stack2deep.comp2Color1,
                ', 69%, 69%)">',
                stack2deep.bravoBoost
            );
    }

    function renderHelper4(
        Stack2deep memory stack2deep
    ) internal pure returns (bytes memory) {
        return
            abi.encodePacked(
                "</text>",
                '<rect stroke="#000000" stroke-dasharray="2,2,',
                (stack2deep.color1 % 21).toString(),
                ',7" stroke-width="17" x="34" y="662" width="711" height="100" opacity="88%" fill="#000000" rx="50" ry="50" />',
                '<text stroke-width="2" stroke="#ffffff" fill="#000000" x="50%" y="713" font-size="49" font-family="courier" text-anchor="middle" dominant-baseline="middle">$AIM0: ',
                stack2deep.returnBalance,
                " ",
                stack2deep.unitName,
                "ROUNDS</text>"
            );
    }

    function renderSVG(
        Stack2deep memory stack2deep
    ) public view returns (string memory) {
        return
            Base64.encode(
                bytes(
                    abi.encodePacked(
                        '<svg width="777" height="777" xmlns="http://www.w3.org/2000/svg">',
                        '<circle stroke="hsl(',
                        stack2deep.comp2Color1,
                        ', 69%, 55%)" stroke-dasharray="5,2,2,2,2,2" stroke-width="48" cx="388.5" cy="488" r="134" fill="#000000" />',
                        renderHelper0(stack2deep),
                        renderHelper1(
                            stack2deep.color1,
                            stack2deep.comp2Color1
                        ),
                        renderHelper2(
                            stack2deep.tokenId,
                            stack2deep.color1.toString(),
                            stack2deep.comp2Color1
                        ),
                        renderHelper3(stack2deep),
                        renderHelper4(stack2deep),
                        "</svg>"
                    )
                )
            );
    }

    function returnAttributes(
        uint256 tokenId,
        string memory rank,
        string memory bravoBoost,
        uint256 missionCoinsEarned
    ) internal pure returns (bytes memory) {
        (string memory missionCoinBalance, string memory coinUnits) = calculateUnits(missionCoinsEarned);
        if (tokenId == 0)
        {
            return "";
        } else {
            return
                abi.encodePacked(
                    '"attributes":[{"trait_type":"Rank","value":',
                                rank,
                                "},",
                                '{"trait_type":"Mission Coins Earned | Units: ', 
                                coinUnits,
                                'Z3R0s","value":',
                                missionCoinBalance,
                                "},",
                                '{"display_type": "boost_number","trait_type":"Bravo Boost","value":',
                                bravoBoost,
                                "}], "
            );
        }
    }

    function returnMetadata(
        uint256 tokenId,
        string memory rank,
        string memory bravoBoost,
        string memory codeName,
        string memory returnBalance,
        string memory unitName,
        uint256 missionCoinsEarned
    ) public view returns (string memory) {
        uint256 color1 = randomNum(361, 3, 4);
        string memory comp2Color1 = calcComplimentColor(color1).toString();
        string memory bravoTitle = "BRAVO #";

        if (tokenId == 0) {
            bravoTitle = "[burnable] $AIM";
        }

        Stack2deep memory stack2deep = Stack2deep(
            tokenId,
            color1,
            comp2Color1,
            rank,
            bravoBoost,
            codeName,
            returnBalance,
            unitName
        );

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                bravoTitle,
                                tokenId.toString(),
                                '", "description": "Bravo Company collection - 200 Zero Army founders series NFTs [semi-fungible] with soulbound burnable $AIM0 - burn and earn Mission Coins in the Zero Army MetaSERVE!',
                                '", "external_url":"https://zeroarmy.org/bravo", ',
                                returnAttributes(tokenId ,rank, bravoBoost, missionCoinsEarned),
                                '"image": "data:image/svg+xml;base64,',
                                renderSVG(stack2deep),
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}

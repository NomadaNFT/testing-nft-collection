// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import { Base64 } from "./libraries/Base64.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract MyEpicNFT is ERC721URIStorage {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  uint public limit = 50; // Supply collection limit.

  event NewEpicNFTMinted(address sender, uint256 tokenId);

  // We need to pass the name of our NFTs token and its symbol.
  constructor() ERC721 ("NomadaNFT", "NOMFT") {
    console.log("This is my NFT contract. Woah!");
  }

  function getTotalNFTsMintedSoFar() public view returns (uint256) {
    // console.log('Total NFTs minted so far:', _tokenIds.current() );
    return _tokenIds.current();  
  }

  // A function our user will hit to get their NFT.
  function makeAnEpicNFT() public {
    // We ensure that the contract has enough tokens to mint a new one.
    require (limit >= getTotalNFTsMintedSoFar(), "We're out of NFTs!");

    uint256 newItemId = _tokenIds.current();

    _safeMint(msg.sender, newItemId);

    _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiVGVzdCBORlQiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSBoaWdobHkgYWNjbGFpbWVkIHNxdWFyZSBjb2xsZWN0aW9uIiwKICAgICJpbWFnZSI6ICJodHRwczovL2Nsb3VkZmxhcmUtaXBmcy5jb20vaXBmcy9RbWFRSGZjUzRqOFJwaDI3TXBGYTNCVjZXWjgyWUFIeVprd0pSeWFHVW9GZkdKIgp9");


    _tokenIds.increment();
    
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    emit NewEpicNFTMinted(msg.sender, newItemId);
  }
}

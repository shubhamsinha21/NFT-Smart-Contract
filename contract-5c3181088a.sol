// SPDX-License-Identifier: MIT
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";
//If we want that user must be able to create the NFT on their own -> we remove the ownable library and onlyowner modifier 


contract Dragonite is ERC721, ERC721Enumerable, ERC721URIStorage
// , ownable
 {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY = 10000;

    constructor() ERC721("Dragonite", "DRG") {}

    function safeMint(address to, string memory uri) public
    // onlyowner
     {
        uint256 tokenId = _tokenIdCounter.current();
        //tokenId counter keeps track of tokensId uint256 and .current() - is the function that gives current number of token Id
        require(tokenId <= MAX_SUPPLY, "I'm sorry all NFT's have been minted");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        // orange method are the methods that are actually writing on a blockChain
        // that are reading on the blockChain
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}

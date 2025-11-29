
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract PermanentSocialMediaIdentityRegistry {


struct Identity {
string username;
string platform;
string metadataURI;
bool exists;
}


mapping(address => Identity) private identities;


event IdentityRegistered(address indexed user, string username, string platform);
event IdentityUpdated(address indexed user, string metadataURI);


// Register new social identity (one-time permanent)
function registerIdentity(string memory _username, string memory _platform, string memory _metadataURI) public {
require(!identities[msg.sender].exists, "Identity already registered.");


identities[msg.sender] = Identity({
username: _username,
platform: _platform,
metadataURI: _metadataURI,
exists: true
});


emit IdentityRegistered(msg.sender, _username, _platform);
}


// Update metadata only (username & platform remain permanent)
function updateMetadata(string memory _metadataURI) public {
require(identities[msg.sender].exists, "Identity not registered.");


identities[msg.sender].metadataURI = _metadataURI;
emit IdentityUpdated(msg.sender, _metadataURI);
}


// Fetch identity data
function getIdentity(address _user) public view returns (string memory, string memory, string memory, bool) {
Identity memory identity = identities[_user];
return (
identity.username,
identity.platform,
identity.metadataURI,
identity.exists
);
}

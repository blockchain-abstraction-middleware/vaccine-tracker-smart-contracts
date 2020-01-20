pragma solidity ^0.5.4;

interface IVirus {

function initializeVirus(address admin)
    external
    payable;

  function addVaccine(
    address vaccine,
    string calldata vaccineName,
    string calldata ipfsHash
  )
    external;

}

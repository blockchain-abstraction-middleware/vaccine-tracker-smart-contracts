pragma solidity ^0.5.4;

import "./AuthenticatedTracker.sol";

contract Virus is AuthenticatedTracker {

  // Struct containing a vaccines information. Could also be made into a contract
  struct VaccineData{
    string ipfsHash;
    string vaccineName;
  }

  mapping(address => VaccineData) public knownVaccines;

  event VaccineAdded(address vaccine);
  
  //TODO: Add RBAC to restrict who can add a Vaccine
  function addVaccine(
    address vaccine,
    string calldata vaccineName,
    string calldata ipfsHash
  )
    external
    onlyAuthenticatedAccount
  {
    // Construct a new VaccineData struct with provided params and overwrite any previous entry for knownVaccines[vaccine]
    knownVaccines[vaccine] = VaccineData(ipfsHash, vaccineName);

    //Alternatively we could try to assign each struct value one by one
    // knownVaccines[vaccine].vaccineName = vaccineName;
    // knownVaccines[vaccine].ipfsHash = ipfsHash;
    emit VaccineAdded(vaccine);
  }
}

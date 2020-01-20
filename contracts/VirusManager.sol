pragma solidity ^0.5.4;

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "./VirusProxy.sol";
import "./interfaces/IVirus.sol";
import "./interfaces/IRegistry.sol";


contract VirusManager {
  using Roles for Roles.Role;

  // Define a ContractRegistry to be setup in the Constructor
  IRegistry registry;

  //  virus list so the Tron network can return a list of addresses
  address[] private virus;

  // Define a mapping to track virus using their name with their address
  mapping (bytes32 => address) public virusList;

  // Define RBAC List, Modifiers and Checks
  Roles.Role private _virusManager;

  event VirusManagerAdded(address indexed account);
  event VirusAdded(address indexed virusAddress);

  modifier onlyVirusManager() {
    require(isVirusManager(msg.sender), "virusManager role required: caller does not have the virusManager role");
    _;
  }

  // Function to check that the address is a valid Manager
  function isVirusManager(
    address account
  )
    public
    view
    returns (bool)
  {
    return _virusManager.has(account);
  }

  // Return all virus addresses
  function getAllVirusAddresses()
    public
    view
    returns (address[] memory)
  {
    return virus;
  }

  // Function to add a new manager
  function _addVirusManager(address account)
   internal
  {
    _virusManager.add(account);
    emit VirusManagerAdded(account);
  }

  constructor(
    address _registryAddress
  )
    public
  {
    require(_registryAddress != address(0));

    registry = IRegistry(_registryAddress);
    _addVirusManager(msg.sender);
  }

  // createvirus creates a new virus contract
  function createVirusProxy()
    private
    returns (address _virusProxyAddress)
  {
    address virusAddress = registry.getContractAddress("virus");
    address virusProxyAddress = address((new VirusProxy).value(msg.value)(address(registry), virusAddress));
    return virusProxyAddress;
  }

  // creates a new virus contract and addNewvirus contract to two lists
  function addNewVirus(
    bytes32 _name,
    address admin
  )
    external
    payable
    onlyVirusManager
    returns (bytes32)
  {
    address payable _virusProxyAddress = address(uint(createVirusProxy()));

    IVirus(_virusProxyAddress).initializeVirus(
      admin
    );

    virusList[_name] = _virusProxyAddress;
    virus.push(_virusProxyAddress);

    emit VirusAdded(_virusProxyAddress);
    return _name;
  }
}
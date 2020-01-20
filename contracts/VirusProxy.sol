pragma solidity ^0.5.4;

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "./interfaces/IRegistry.sol";
import "./Virus.sol";


contract VirusProxy is AuthenticatedTracker {
  // Define a ContractRegistry to be setup in the Constructor
  IRegistry registry;

  // Define address the Proxied contract
  address public virusContractAddress;

  constructor(
    address _registry,
    address _virusContractAddress
  )
    public
    payable
  {
    require(_registry != address(0));

    virusContractAddress = _virusContractAddress;
    registry = IRegistry(_registry);
  }

  function()
    external
    payable
  {
    assembly {
      // Load Virus address from first storage pointer
      let _virus := sload(virusContractAddress_slot)

      // calldatacopy(t, f, s)
      calldatacopy(
        0x0, // t = mem position to
        0x0, // f = mem position from
        calldatasize // s = size bytes
      )

      // delegatecall(g, a, in, insize, out, outsize) => returns "0" on error, or "1" on success
      let result := delegatecall(
        gas, // g = gas
        _virus, // a = address
        0x0, // in = mem in  mem[in..(in+insize)
        calldatasize, // insize = mem insize  mem[in..(in+insize)
        0x0, // out = mem out  mem[out..(out+outsize)
        0 // outsize = mem outsize  mem[out..(out+outsize)
      )

      if iszero(result) {
        revert(0, 0)
      }

      // returndatacopy(t, f, s)
      returndatacopy(
        0x0, // t = mem position to
        0x0,  // f = mem position from
        returndatasize // s = size bytes
      )

      return(
        0x0,
        returndatasize
      )
    }
  }
}
pragma solidity 0.5.4;


import "./libraries/openzeppelin-solidity/contracts/access/Roles.sol";


contract AuthenticatedTracker {
  using Roles for Roles.Role;

  // Define the roles
  Roles.Role internal authenticatedAccounts;

  event AuthenticatedAccountAdded(address account);

  // On Deploy, the sender of the transaction will be added as an admin
  modifier onlyAuthenticatedAccount()
  {
    require(isAuthenticatedAccount(msg.sender), "AuthenticatedAccount role required: caller must be authenticated to perform this operation");
    _;
  }

  // Function to check that the address is a valid admin
  function isAuthenticatedAccount(address account)
    public
    view
    returns (bool)
  {
    return authenticatedAccounts.has(account);
  }

  // Function to check that the address is a valid admin
  function addAuthenticatedAccount(address account)
    internal
    onlyAuthenticatedAccount
    returns (bool)
  {
    authenticatedAccounts.add(account);
    emit AuthenticatedAccountAdded(account);
  }
  
}
pragma solidity ^0.4.24;

import "./TokenVesting.sol";


contract TokenVestingFactory {
  address public defaultOwner;
  uint256 constant public DEFAULT_CLIFF = 365 days;
  uint256 constant public DEFAULT_DURATION = 4 * 365 days;
  bool constant public DEFAULT_REVOCABLE = true;

  event DeployedVestingContract(address indexed vesting, address indexed beneficiary, address indexed owner);

  constructor (address _defaultOwner) public {
    defaultOwner = _defaultOwner;
  }

  function deployDefaultVestingContract(address _beneficiary, uint256 _start) public {
    deployVestingContract(defaultOwner, _beneficiary, _start, DEFAULT_CLIFF, DEFAULT_DURATION, DEFAULT_REVOCABLE);
  }

  function deployVestingContract(address _owner, address _beneficiary, uint256 _start, uint256 _cliff, uint256 _duration, bool _revocable) public {
    TokenVesting vesting = new TokenVesting(_beneficiary, _start, _cliff, _duration, _revocable);

    vesting.transferOwnership(_owner);

    emit DeployedVestingContract(vesting, _beneficiary, _owner);
  }
}
//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

interface ERC20{
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract Glaze is ERC20{
    string public name = "Glaze";
    string public symbol = "GLZ";
    uint public decimal=0;
    uint public override totalSupply;
    address public founder;
    mapping (address=>uint) internal balances;
    mapping (address =>mapping(address => uint)) allowed;
    constructor(){
        totalSupply = 100;
        founder= msg.sender;
        balances[msg.sender]=totalSupply;
    }

    function balanceOf(address _tokenOwner) public view override returns(uint){
        return balances[_tokenOwner]; 
    }

    function transfer(address _to, uint256 _value) public override returns (bool success){
        require(balances[msg.sender] >= _value, "You have insufficient balance");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }

    function allowance(address _owner, address _spender) public view override returns (uint256 remaining){
        return allowed[_owner][_spender];
    }

    function approve(address _spender, uint256 _value) public override returns (bool success){
        require(balances[msg.sender] >= _value, "You dont have sufficient balance"); 
        require(_value>0, "You cant transfere 0 tokens");
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
        require(allowed[_from][_to] >= _value, "User have not approved you");
        require(balances[_from] >= _value,"he have insuffiect balance");
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from,_to,_value);
        return true;
    }

}
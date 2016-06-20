contract Owned {

    address public owner;

    modifier fromOwner {
        if (msg.sender != owner)
			throw;
    }

    function getOwner() constant returns (address) {
        return owner;
    }

}

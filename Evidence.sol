contract Evidence {

    address private owner;
    address private jugdment;
    bytes32 private name;
    bytes32 private url;

    function Evidence(address _jugdment, bytes32 _name, bytes32 _url) {
        owner = msg.sender;
        jugdment = _jugdment;
        name = _name;
        url = _url;
    }

    function edit(bytes32 _name, bytes32 _url) constant returns (bool){
        if (owner != msg.sender)
            return (false);
        jugdment = _jugdment;
        name = _name;
        return (true);
    }

    function getData() constant returns (address, address, bytes32, bytes32){
        return (owner, jugdment, name, url);
    }

}

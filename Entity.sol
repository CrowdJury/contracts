contract Entity {

    address private owner;
    bytes32 private name;
    bytes32 private legal_name;
    bytes32 private legal_email;
    bytes32 private residency_country;
    bytes32 private residency_address;
    bytes32 private id_string;
    bytes32 private id_type;
    addressArray private jugdments;

    struct addressArray {
        uint size;
        mapping (uint => address) array;
    }

    function Entity(bytes32 _legal_name, bytes32 _legal_email, bytes32 _residency_country, bytes32 _residency_address, bytes32 _id_string, bytes32 _id_type) {
        owner = msg.sender;
        legal_name = _legal_name;
        legal_email = _legal_email;
        residency_country = _residency_country;
        residency_address = _residency_address;
        id_string = _id_string;
        id_type = _id_type;
        jugdments = addressArray(0);
    }

    function edit(bytes32 _legal_name, bytes32 _legal_email, bytes32 _residency_country, bytes32 _residency_address, bytes32 _id_string, bytes32 _id_type) constant returns (bool){
        if (owner != msg.sender)
            return (false);
        legal_name = _legal_name;
        legal_email = _legal_email;
        residency_country = _residency_country;
        residency_address = _residency_address;
        id_string = _id_string;
        id_type = _id_type;
        return (true);
    }

    function getData() constant returns (bytes32, bytes32, bytes32, bytes32, bytes32, bytes32){
        return (legal_name, legal_email,residency_country, residency_address, id_string, id_type);
    }

    function getJugdment(uint i) constant returns (address){
        if (i < jugdments.size)
            return (jugdments.array[i]);
        return (0x0000000000000000000000000000000000000000);
    }

    function addJugdment(address jugdment_address) constant returns (bool){
        if (owner != msg.sender)
                return (false);
        for(uint i = 0; i < jugdments.size; i ++)
            if (jugdments.array[i] == jugdment_address)
                return (false);
        jugdments.array[jugdments.size] = jugdment_address;
        jugdments.size ++;
        return (true);
    }

    function removeJugdment(address jugdment_address) constant returns (bool){
        if (owner != msg.sender)
                return (false);
        for(uint i = 0; i < jugdments.size; i ++)
            if (jugdments.array[i] == jugdment_address){
                if (i == (jugdments.size-1)){
                    delete jugdments.array[i];
                } else {
                    for(uint z = i; z < jugdments.size; z ++)
                        jugdments.array[z] = jugdments.array[z+1];
                    delete jugdments.array[jugdments.size-1];
                }
                jugdments.size --;
                return (true);
            }
        return (false);
    }

}
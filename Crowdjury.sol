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
        url = _url;
        name = _name;
        return (true);
    }

    function getData() constant returns (address, address, bytes32, bytes32){
        return (owner, jugdment, name, url);
    }

}
contract Person {

    address private owner;
    bytes32 private first_name;
    bytes32 private last_name;
    bytes32 private email;
    bytes12 private birthdate;
    bytes32 private id_string;
    bytes32 private id_type;
    bytes32 private skill_one;
    bytes32 private skill_two;
    bytes32 private skill_three;
    bytes32 private skill_four;
    bytes32 private skill_five;
    Addresses private jugdments;

    struct Addresses {
        uint size;
        mapping (uint => address) array;
    }

    function Person(bytes32 _first_name, bytes32 _last_name, bytes32 _email, bytes12 _birthdate, bytes32 _id_string, bytes32 _id_type, bytes32 _skill_one, bytes32 _skill_two, bytes32 _skill_three, bytes32 _skill_four, bytes32 _skill_five) {
        owner = msg.sender;
        first_name = _first_name;
        last_name = _last_name;
        email = _email;
        birthdate = _birthdate;
        id_string = _id_string;
        id_type = _id_type;
        jugdments = Addresses(0);
        skill_one = _skill_one;
        skill_two = _skill_two;
        skill_three = _skill_three;
        skill_four = _skill_four;
        skill_five = _skill_five;
    }

    function edit(bytes32 _first_name, bytes32 _last_name, bytes32 _email, bytes12 _birthdate, bytes32 _id_string, bytes32 _id_type, bytes32 _skill_one, bytes32 _skill_two, bytes32 _skill_three, bytes32 _skill_four, bytes32 _skill_five) constant returns (bool){
        if (owner != msg.sender)
            return (false);
        first_name = _first_name;
        last_name = _last_name;
        email = _email;
        birthdate = _birthdate;
        id_string = _id_string;
        id_type = _id_type;
        skill_one = _skill_one;
        skill_two = _skill_two;
        skill_three = _skill_three;
        skill_four = _skill_four;
        skill_five = _skill_five;
        return (true);
    }

    function getData() constant returns (bytes32, bytes32, bytes32, bytes12, bytes32, bytes32, bytes32, bytes32, bytes32, bytes32, bytes32){
        return (first_name, last_name, email, birthdate, id_string, id_type, skill_one, skill_two, skill_three, skill_four, skill_five);
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
contract Entity {

    address private owner;
    bytes32 private name;
    bytes32 private legal_name;
    bytes32 private legal_email;
    bytes32 private residency_country;
    bytes32 private residency_address;
    bytes32 private id_string;
    bytes32 private id_type;
    Addresses private jugdments;

    struct Addresses {
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
        jugdments = Addresses(0);
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

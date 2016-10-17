pragma solidity ^0.4.1;contract Owned {

    address public owner;

    modifier fromOwner() {
        if (msg.sender != owner)
			_;
    }

    function getOwner() constant returns (address) {
        return owner;
    }

}
contract Entity is Owned{

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

    function edit(bytes32 _legal_name, bytes32 _legal_email, bytes32 _residency_country, bytes32 _residency_address, bytes32 _id_string, bytes32 _id_type) constant fromOwner returns (bool){
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
        return (0x0);
    }

    function addJugdment(address jugdment_address) constant fromOwner returns (bool){
        for(uint i = 0; i < jugdments.size; i ++)
            if (jugdments.array[i] == jugdment_address)
                return (false);
        jugdments.array[jugdments.size] = jugdment_address;
        jugdments.size ++;
        return (true);
    }

    function removeJugdment(address jugdment_address) constant fromOwner returns (bool){
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
contract Evidence is Owned{

    address private jugdment;
    bytes32 private name;
    bytes32 private url;

    function Evidence(address _jugdment, bytes32 _name, bytes32 _url) {
        owner = msg.sender;
        jugdment = _jugdment;
        name = _name;
        url = _url;
    }

    function edit(bytes32 _name, bytes32 _url) constant fromOwner returns (bool){
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
contract Person is Owned{

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

    function edit(bytes32 _first_name, bytes32 _last_name, bytes32 _email, bytes12 _birthdate, bytes32 _id_string, bytes32 _id_type, bytes32 _skill_one, bytes32 _skill_two, bytes32 _skill_three, bytes32 _skill_four, bytes32 _skill_five) constant fromOwner returns (bool){
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
        return (0x0);
    }

    function addJugdment(address jugdment_address) constant fromOwner returns (bool){
        for(uint i = 0; i < jugdments.size; i ++)
            if (jugdments.array[i] == jugdment_address)
                return (false);
        jugdments.array[jugdments.size] = jugdment_address;
        jugdments.size ++;
        return (true);
    }

    function removeJugdment(address jugdment_address) constant fromOwner returns (bool){
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
contract Judgment is Owned{

    address private litigantSelected;
    bool private finished;
    Litigants private litigants;
    Jury private jury;
    Addresses private evidences;

    struct Jury {
        uint size;
        uint totalWeight;
        uint totalReward;
        mapping (uint => JuryMember) array;
    }
    struct JuryMember {
        address vote;
        uint weight;
        uint reward;
        address memberAddress;
    }
    struct Litigants {
        uint size;
        mapping (uint => Litigant) array;
    }
    struct Litigant {
        uint votes;
        address litigantAddress;
    }
    struct Addresses {
        uint size;
        mapping (uint => address) array;
    }

    event judgmentFinish(address litigantSelected, uint votes);

	modifier litigantComplete(bool isSpace){
        for (uint i = 0; i < litigants.size; i ++)
            if ((litigants.array[i].litigantAddress == 0x0) && (!isSpace))
				throw;
		if (isSpace)
			throw;
        _;
    }

	modifier juryComplete(bool isSpace){
        for (uint i = 0; i < jury.size; i ++)
            if ((jury.array[i].memberAddress == 0x0) && (!isSpace))
				throw;
		if (isSpace)
			throw;
        _;
    }

    function Judgment(uint jurySize, uint litigantsSize) {
        owner = msg.sender;
        jury = Jury(jurySize,0,0);
        litigants = Litigants(litigantsSize);
        evidences = Addresses(0);
        finished = false;
        for (uint i = 0; i < jurySize; i ++){
            jury.array[i] = JuryMember({
                vote : 0x0,
                weight : 0,
                reward : 0,
                memberAddress : 0x0
            });
        }
        for (i = 0; i < litigantsSize; i ++){
            litigants.array[i] = Litigant({
                votes : 0,
                litigantAddress : 0x0
            });
        }
    }

    function addJuryMember(bytes32 _name, address _memberAddress, uint _weight, uint _reward) constant fromOwner litigantComplete(true) returns (bool){
        if ((_weight > 100) || (_reward > 100))
            return (false);
        for (uint i = 0; i < jury.size; i ++)
            if (jury.array[i].memberAddress == 0x0){
                jury.array[i].weight = _weight;
                jury.array[i].reward = _reward;
                jury.array[i].memberAddress = _memberAddress;
                jury.totalWeight =+ _weight;
                jury.totalReward =+ _reward;
                return (true);
            }
        return (false);
    }

    function addLitigant(bytes32 _name, address _litigantAddress) constant fromOwner juryComplete(false) returns (bool){
        for (uint i = 0; i < litigants.size; i ++)
            if (litigants.array[i].litigantAddress == 0x0){
                litigants.array[i].litigantAddress = _litigantAddress;
                return (true);
            }
        return (false);
    }

    function addEvidence(address evidenceAddress) constant fromOwner returns (bool){
        for (uint i = 0; i < evidences.size; i ++)
            if (evidences.array[i] == evidenceAddress)
                return (false);
        evidences.array[evidences.size] = evidenceAddress;
        evidences.size ++;
        return (true);
    }

    function vote(address litigantAddress) constant juryComplete(true) litigantComplete(true) returns (bool){
        for (uint i = 0; i < jury.size; i ++)
            if ((jury.array[i].memberAddress == msg.sender) && (jury.array[i].vote == 0x0))
                for (uint z = 0; z < litigants.size; z ++)
                    if (litigants.array[z].litigantAddress == litigantAddress){
                        jury.array[i].vote = litigantAddress;
                        litigants.array[z].votes =+ jury.array[i].weight;
                        if (votesCompleted()){
							litigantSelected = 0x0;
					        uint selectedVotes = 0;
					        for (i = 0; i < litigants.size; i ++)
					            if (litigants.array[i].votes > selectedVotes){
					                litigantSelected = litigants.array[i].litigantAddress;
					                selectedVotes = litigants.array[i].votes;
					            }
                            if (litigantSelected != 0x0){
                                distributeRewards();
                                judgmentFinish(litigantSelected, selectedVotes);
                                finished = true;
                            }
                        }
                        return (true);
                    }
        return (false);
    }

    function distributeRewards() constant returns (bool){
        for (uint i = 0; i < jury.size; i ++)
            if (!jury.array[i].memberAddress.send(this.balance*(jury.array[i].reward/jury.totalReward)))
                return (false);
        return (true);
    }

    function getJurySize() returns (uint){
        return (jury.size);
    }

    function getLitigantsSize() returns (uint){
        return (litigants.size);
    }

    function getJuryMember(uint i) returns (address, uint, uint, address){
        if (i < jury.size)
            if (votesCompleted())
                return (jury.array[i].vote, jury.array[i].weight, jury.array[i].reward, jury.array[i].memberAddress);
            else
                return (0x0, jury.array[i].weight, jury.array[i].reward, jury.array[i].memberAddress);
		return (0x0, 0, 0, 0x0);
	}

    function getLitigant(uint i) returns (uint, address){
        if (i < litigants.size)
            if (votesCompleted())
                return (litigants.array[i].votes, litigants.array[i].litigantAddress);
            else
                return (0, litigants.array[i].litigantAddress);
		return (0, 0x0);
    }

    function getEvidence(uint i) returns (address){
        if (i > evidences.size)
            return (0x0);
        for (uint z = 0; z < jury.size; z ++)
            if (jury.array[z].memberAddress == msg.sender)
                return (evidences.array[i]);
        for (z = 0; z < litigants.size; z ++)
            if (litigants.array[z].litigantAddress == msg.sender)
                return (evidences.array[i]);
        return (0x0);
    }

	function votesCompleted() returns (bool){
        for (uint i = 0; i < jury.size; i ++)
            if (jury.array[i].vote == 0x0)
                return (false);
		return (true);
    }

    function isFinished() returns (bool){
        return (finished);
    }

}

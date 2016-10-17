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

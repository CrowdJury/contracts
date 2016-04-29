contract Judgment {

    address private owner;
    address private litigantSelected;
    bool private finished;
    Litigants private litigants;
    Jury private jury;
    Addresses private evidences

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

    event judgmentFinish(address litigantSelected);

    function Judgment(uint jurySize, uint litigantsSize) {
        owner = msg.sender;
        jury = Jury(jurySize,0,0);
        litigants = Litigants(litigantsSize);
        evidences = Addresses(0);
        finished = false;
        for (uint i = 0; i < jurySize; i ++){
            jury.array[i] = JuryMember({
                vote : 0x0000000000000000000000000000000000000000,
                weight : 0,
                reward : 0,
                memberAddress : 0x0000000000000000000000000000000000000000
            });
        }
        for (i = 0; i < litigantsSize; i ++){
            litigants.array[i] = Litigant({
                votes : 0,
                litigantAddress : 0x0000000000000000000000000000000000000000
            });
        }
    }

    function addJuryMember(bytes32 _name, address _memberAddress, uint _weight, uint _reward) constant returns (bool){
        if ((!litigantComplete()) || (_weight > 100) || (_reward > 100) || owner != msg.sender)
            return false;
        for (uint i = 0; i < jury.size; i ++)
            if (jury.array[i].memberAddress == 0x0000000000000000000000000000000000000000){
                jury.array[i].weight = _weight;
                jury.array[i].reward = _reward;
                jury.array[i].memberAddress = _memberAddress;
                jury.totalWeight =+ _weight;
                jury.totalReward =+ _reward;
                return true;
            }
        return false;
    }

    function addLitigant(bytes32 _name, address _litigantAddress) constant returns (bool){
        if (juryComplete() || owner != msg.sender)
            return false;
        for (uint i = 0; i < litigants.size; i ++)
            if (litigants.array[i].litigantAddress == 0x0000000000000000000000000000000000000000){
                litigants.array[i].litigantAddress = _litigantAddress;
                return true;
            }
        return false;
    }

    function addEvidence(address evidenceAddress) constant returns (bool){
        if (owner != msg.sender)
            return false;
        for (uint i = 0; i < evidences.size; i ++)
            if (evidences.array[i] == evidenceAddress)
                return false;
        evidences[evidences.size] = evidenceAddress;
        evidences.size ++;
        return true;
    }

    function vote(address litigantAddress) constant returns (bool){
        if (!juryComplete() || !litigantComplete())
            return false;
        for (uint i = 0; i < jury.size; i ++)
            if ((jury.array[i].memberAddress == msg.sender) && (jury.array[i].vote == 0x0000000000000000000000000000000000000000))
                for (uint z = 0; z < litigants.size; z ++)
                    if (litigants.array[z].litigantAddress == litigantAddress){
                        jury.array[i].vote = litigantAddress;
                        litigants.array[z].votes =+ jury.array[i].weight;
                        if (votesCompleted()){
                            litigantSelected = selectLitigant();
                            if (litigantSelected != 0x0000000000000000000000000000000000000000){
                                distributeRewards();
                                judgmentFinish(litigantSelected);
                                finished = true;
                            }
                        }
                        return true;
                    }
        return false;
    }

    function selectLitigant() returns (address){
        if (!votesCompleted())
            return 0x0000000000000000000000000000000000000000;
        address selected = 0x0000000000000000000000000000000000000000;
        uint selectedVotes = 0;
        for (uint i = 0; i < litigants.size; i ++)
            if (litigants.array[i].votes > selectedVotes){
                selected = litigants.array[i].litigantAddress;
                selectedVotes = litigants.array[i].votes;
            }
        return selected;
    }

    function distributeRewards() constant returns (bool){
        for (uint i = 0; i < jury.size; i ++)
            if (!jury.array[i].memberAddress.send(this.balance*(jury.array[i].reward/jury.totalReward)))
                return false;
        return true;
    }

    function juryComplete() constant returns (bool){
        for (uint i = 0; i < jury.size; i ++)
            if (jury.array[i].memberAddress == 0x0000000000000000000000000000000000000000)
                return false;
        return true;
    }

    function litigantComplete() constant returns (bool){
        for (uint i = 0; i < litigants.size; i ++)
            if (litigants.array[i].litigantAddress == 0x0000000000000000000000000000000000000000)
                return false;
        return true;
    }

    function votesCompleted() constant returns (bool){
        for (uint i = 0; i < jury.size; i ++)
            if (jury.array[i].vote == 0x0000000000000000000000000000000000000000)
                return false;
        return true;
    }

    function getJurySize() constant returns (uint){
        return jury.size;
    }

    function getLitigantsSize() constant returns (uint){
        return litigants.size;
    }

    function getJuryMember(uint i) constant returns (address, uint, uint, address){
        if (i < jury.size)
            if (votesCompleted())
                return (jury.array[i].vote, jury.array[i].weight, jury.array[i].reward, jury.array[i].memberAddress);
            else
                return (0x0000000000000000000000000000000000000000, jury.array[i].weight, jury.array[i].reward, jury.array[i].memberAddress);
    }

    function getLitigant(uint i) constant returns (uint, address){
        if (i < litigants.size)
            if (votesCompleted())
                return (litigants.array[i].votes, litigants.array[i].litigantAddress);
            else
                return (0, litigants.array[i].litigantAddress);
    }

    function getEvidence(uint i) constant returns (address){
        if (i > evidences.size)
            return 0x0000000000000000000000000000000000000000;
        for (uint i = 0; i < jury.size; i ++)
            if (jury.array[i].memberAddress == msg.sender)
                return evidences.array[i];
        for (uint i = 0; i < litigants.size; i ++)
            if (litigants.array[i].litigantAddress == msg.sender)
                return evidences.array[i];
        return 0x0000000000000000000000000000000000000000;
    }

    function isFinished() constant returns (bool){
        return finished;
    }

}

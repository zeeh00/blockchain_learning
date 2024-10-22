// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TPS {
    struct Candidate {
        string name;
        // uint256 ipk;
        // string party;
        uint256 voteCount;
        // string daddyName;
    }

    struct Voter {
        uint256 age;
        // address delegate;
        bool hasVoted;
        // uint256 weight;
    }

    address public chairperson;

    Candidate[] candidates;

    mapping (address => Voter) voters;

    constructor(string[] memory candidatesName) {
        chairperson = msg.sender;
        for (uint i=0; i<candidatesName.length;i++) {
            candidates.push(Candidate ({
               name: candidatesName[i],
               voteCount: 0
            }));
        }
    }

    function giveVotingRight (address _voterAddress, uint256 _voterAge) public  {
        require(msg.sender == chairperson, "Only chairperson can give right to vote.");
        require(!voters[_voterAddress].hasVoted, "Voter already has voted.");
        voters[_voterAddress].hasVoted = false;
        voters[_voterAddress].age = _voterAge;
    }


    // identify security risk in this function ?
    function voting(address _voterAddress, uint256 _votedCandidate) public  {
        Voter memory theVoter = voters[_voterAddress];
        require(theVoter.hasVoted != true, "The voter already voted");
        theVoter.hasVoted = true;
        candidates[_votedCandidate - 1].voteCount++;
    }
}
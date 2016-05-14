# CrowdJury Smart Contracts

Ethereum smart contracts for the CrowdJury app.

###Judgment.sol

A judgment with a fixed number of jury members and litigants is created, the jury its composed with persons and their litigants can be persons or entities. Every member of the jury select a litigant with no possibility of change after make a decision, when all the members of the jury reach a decision the reward its distributed among them based on their reward points.

###Person.sol

A contract representing a person with his public information, skills and judgments.

###Entity.sol

A contract representing a entity with his public information and judgments.

###Evidence.sol

A contract representing the evidence that is going to be use on the jugdment by the jury.

## Build

To concatenate all the files in only one contracts run:

`grunt`

## Test

You can test the contracts on this solidity online compiler:

https://chriseth.github.io/browser-solidity/#version=soljson-latest.js&optimize=true

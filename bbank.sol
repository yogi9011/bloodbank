// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract BloodBank{
    address public owner;

    constructor(){
        msg.sender == owner;
    }

    enum PatientType {
        Donor,
        Receiver
    }

    struct BloodTransaction {
        PatientType patientType;
        uint256 time;
        address from;
        address to;
    }

    struct Patient {
        uint256 aadhar;
        string name;
        uint256 age;
        string bloodGroup;
        uint256 contact;
        string homeAddress;
        BloodTransaction[] bT;
    }

    Patient[] public PatientRecord;
    uint count = 0;

    mapping(uint256 => uint256) PatientRecordIndex;
    
    function newPatient(string memory _name,uint256 _age,string memory _bloodGroup,uint256 _contact,string memory _homeAddress,uint256 _aadhar) public {

    uint256 index = PatientRecord.length;
    Patient memory tempPatient;
    tempPatient.name = _name;
    tempPatient.age = _age;
    tempPatient.bloodGroup = _bloodGroup;
    tempPatient.contact = _contact;
    tempPatient.homeAddress = _homeAddress;
    tempPatient.aadhar = _aadhar;
    PatientRecord.push(tempPatient);
    PatientRecordIndex[_aadhar] = index;
    count++;
    }
    
    function getPatientRecord(uint256 _aadhar) external view returns (Patient memory)
    {
        uint256 index = PatientRecordIndex[_aadhar];
        return PatientRecord[index];
    }

    function getAllRecord() external view returns (Patient[] memory) {
        return PatientRecord;
    }
    function bloodTransaction(uint256 _aadhar,PatientType _type,address _from,address _to) external {
    
    uint256 index = PatientRecordIndex[_aadhar];

    BloodTransaction memory txObj = BloodTransaction({
            patientType: _type,
            time: block.timestamp,
            from: _from,
            to: _to
        });

        PatientRecord[index].bT.push(txObj);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SupplyChain {
    //Smart Contract owner will be the person who deploys the contract only he can authorize various roles like retailer, Manufacturer,etc
    address public Owner;

    //note this constructor will be called when smart contract will be deployed on blockchain
    constructor() public {
    Owner = msg.sender;
}

    //modifier to make sure only the owner is using the function
    modifier onlyByOwner() {
        require(msg.sender == Owner);
        _;
    }


    enum STAGE {
        Init,
        RawMaterialSupply,
        Manufacture,
        Distribution,
        Retail,
        sold
    }



    uint256 public medicineCtr = 0;
    //Raw material supplier count
    uint256 public rmsCtr = 0;
    //Manufacturer count
    uint256 public manCtr = 0;
    //distributor count
    uint256 public disCtr = 0;
    //retailer count
    uint256 public retCtr = 0;
    uint256 public price=0;
    uint256 public price1=10;
    uint256 public price2=20;
    uint256 public price3=30;
    uint256 public price4=40;
    uint256 public price5=50;
    uint256 public price6=60;
    uint256 public organicscore=0;


    //To store information about the medicine
    struct product {
        uint256 id; //unique medicine id
        string name; //name of the medicine
        uint256 RMSid; //id of the Raw Material supplier for this particular medicine
        uint256 MANid; //id of the Manufacturer for this particular medicine
        uint256 DISid; //id of the distributor for this particular medicine
        uint256 RETid; //id of the retailer for this particular medicine
        STAGE stage; //current medicine stage
        uint256 price1;
        uint256 price2;
        uint256 price3;
        uint256 price4;
        uint256 organicscore;
    }

    struct soil{
        uint256 id;
        uint256 NaturalFertilizer;
        uint256 SyntheticFertilizer;
        uint256 Organicertilizer;
        uint256 phLevel;
        uint256 waterquality;
    }

   
   struct Storage{
       uint256 id;
       uint256 temp;
       uint256 humidity;
   }

   struct Certify{
       uint256 id;
       Certification certify;
   }

   enum Certification{
       Yes,
       No,
       Pending
   }
    

    //To store all the medicines on the blockchain
    function setPrice1(uint256 _medicineID, uint256 _price) public {
    MedicineStock[_medicineID].price1 = _price;
}
    function setPrice2(uint256 _medicineID, uint256 _price) public {
    MedicineStock[_medicineID].price2 = _price;
}
    function setPrice3(uint256 _medicineID, uint256 _price) public {
    MedicineStock[_medicineID].price3 = _price;
}
    function setPrice4(uint256 _medicineID, uint256 _price) public {
    MedicineStock[_medicineID].price4 = _price;
}

function getPrice1(uint256 _medicineID) public view returns (uint256) {
    return MedicineStock[_medicineID].price1;
}

function getPrice2(uint256 _medicineID) public view returns (uint256) {
    return MedicineStock[_medicineID].price2;
}
function getPrice3(uint256 _medicineID) public view returns (uint256) {
    return MedicineStock[_medicineID].price3;
}
function getPrice4(uint256 _medicineID) public view returns (uint256) {
    return MedicineStock[_medicineID].price4;
}
    mapping(uint256 => product) public MedicineStock;
    mapping(uint256 => soil) public Soil;
    mapping(uint256 => Storage) public StorageStock;
    mapping(uint256 => Certify) public CertificationStock;
    //To show status to client applications


 function showCertification(uint256 _medicineID)
    public
    view
    returns (string memory)
{
    require(medicineCtr > 0, "No Product available");
    
    if (CertificationStock[_medicineID].certify == Certification.No)
        return "No";
    else if (CertificationStock[_medicineID].certify == Certification.Pending)
        return "Pending";
    else if (CertificationStock[_medicineID].certify == Certification.Yes)
        return "Yes";
    else
        return ""; // add a default return statement to avoid the warning
}

 function showStage(uint256 _medicineID)
    public
    view
    returns (string memory)
{
    require(medicineCtr > 0, "No Product available");
    
    if (MedicineStock[_medicineID].stage == STAGE.Init)
        return "Product Ordered";
    else if (MedicineStock[_medicineID].stage == STAGE.RawMaterialSupply)
        return "Raw Material Supply Stage";
    else if (MedicineStock[_medicineID].stage == STAGE.Manufacture)
        return "Manufacturing Stage";
    else if (MedicineStock[_medicineID].stage == STAGE.Distribution)
        return "Distribution Stage";
    else if (MedicineStock[_medicineID].stage == STAGE.Retail)
        return "Retail Stage";
    else if (MedicineStock[_medicineID].stage == STAGE.sold)
        return "Product Sold";
    else
        return ""; // add a default return statement to avoid the warning
}


function showPrice(uint256 _medicineID)
    public
    view
    returns (uint256)
{
    require(medicineCtr > 0, "No Product available");
    
    if (MedicineStock[_medicineID].stage == STAGE.Init)
        return price1;
    else if (MedicineStock[_medicineID].stage == STAGE.RawMaterialSupply)
        return price2;
    else if (MedicineStock[_medicineID].stage == STAGE.Manufacture)
        return price3;
    else if (MedicineStock[_medicineID].stage == STAGE.Distribution)
        return price4;
    else if (MedicineStock[_medicineID].stage == STAGE.Retail)
        return price5;
    else if (MedicineStock[_medicineID].stage == STAGE.sold)
        return price6;
    else
        revert("Invalid medicine ID"); // add a default return statement to avoid the warning
}

    //To store information about raw material supplier
    struct rawMaterialSupplier {
        address addr;
        uint256 id; //supplier id
        string name; //Name of the raw material supplier
        string place; //Place the raw material supplier is based in
    }

    //To store all the raw material suppliers on the blockchain
    mapping(uint256 => rawMaterialSupplier) public RMS;

    //To store information about manufacturer
    struct manufacturer {
        address addr;
        uint256 id; //manufacturer id
        string name; //Name of the manufacturer
        string place; //Place the manufacturer is based in
    }

    //To store all the manufacturers on the blockchain
    mapping(uint256 => manufacturer) public MAN;

    //To store information about distributor
    struct distributor {
        address addr;
        uint256 id; //distributor id
        string name; //Name of the distributor
        string place; //Place the distributor is based in
    }

    //To store all the distributors on the blockchain
    mapping(uint256 => distributor) public DIS;

    //To store information about retailer
    struct retailer {
        address addr;
        uint256 id; //retailer id
        string name; //Name of the retailer
        string place; //Place the retailer is based in
    }

    //To store all the retailers on the blockchain
    mapping(uint256 => retailer) public RET;

    //To add raw material suppliers. Only contract owner can add a new raw material supplier
    function addRMS(
        address _address,
        string memory _name,
        string memory _place
    ) public onlyByOwner() {
        rmsCtr++;
        RMS[rmsCtr] = rawMaterialSupplier(_address, rmsCtr, _name, _place);
    }

    //To add manufacturer. Only contract owner can add a new manufacturer
    function addManufacturer(
        address _address,
        string memory _name,
        string memory _place
    ) public onlyByOwner() {
        manCtr++;
        MAN[manCtr] = manufacturer(_address, manCtr, _name, _place);
    }

    //To add distributor. Only contract owner can add a new distributor
    function addDistributor(
        address _address,
        string memory _name,
        string memory _place
    ) public onlyByOwner() {
        disCtr++;
        DIS[disCtr] = distributor(_address, disCtr, _name, _place);
    }

    //To add retailer. Only contract owner can add a new retailer
    function addRetailer(
        address _address,
        string memory _name,
        string memory _place
    ) public onlyByOwner() {
        retCtr++;
        RET[retCtr] = retailer(_address, retCtr, _name, _place);
    }

    //To supply raw materials from RMS supplier to the manufacturer
    function RMSsupply(uint256 _medicineID,uint256 _nf,uint256 _sf,uint256 _of) public {
        require(_medicineID > 0 && _medicineID <= medicineCtr);
        uint256 _id = findRMS(msg.sender);
        require(_id > 0);
        require(MedicineStock[_medicineID].stage == STAGE.Init);
        MedicineStock[_medicineID].RMSid = _id;
        MedicineStock[_medicineID].stage = STAGE.RawMaterialSupply;
        Soil[_medicineID].NaturalFertilizer= _nf;
        Soil[_medicineID].SyntheticFertilizer= _sf;
        Soil[_medicineID].Organicertilizer= _of;
        CertificationStock[_medicineID].certify = Certification.No;
    }

    //To check if RMS is available in the blockchain
    function findRMS(address _address) private view returns (uint256) {
        require(rmsCtr > 0);
        for (uint256 i = 1; i <= rmsCtr; i++) {
            if (RMS[i].addr == _address) return RMS[i].id;
        }
        return 0;
    }

    //To manufacture medicine
    function Manufacturing(uint256 _medicineID,uint256 _ph,uint256 _wq) public {
        require(_medicineID > 0 && _medicineID <= medicineCtr);
        uint256 _id = findMAN(msg.sender);
        require(_id > 0);
        require(MedicineStock[_medicineID].stage == STAGE.RawMaterialSupply);
        MedicineStock[_medicineID].MANid = _id;
        MedicineStock[_medicineID].stage = STAGE.Manufacture;
        Soil[_medicineID].phLevel= _ph;
        Soil[_medicineID].waterquality= _wq;
        CertificationStock[_medicineID].certify = Certification.No;
    }

    //To check if Manufacturer is available in the blockchain
    function findMAN(address _address) private view returns (uint256) {
        require(manCtr > 0);
        for (uint256 i = 1; i <= manCtr; i++) {
            if (MAN[i].addr == _address) return MAN[i].id;
        }
        return 0;
    }

    //To supply medicines from Manufacturer to distributor
    function Distribute(uint256 _medicineID,uint256 _temp,uint256 _hum) public {
        require(_medicineID > 0 && _medicineID <= medicineCtr);
        uint256 _id = findDIS(msg.sender);
        require(_id > 0);
        require(MedicineStock[_medicineID].stage == STAGE.Manufacture);
        MedicineStock[_medicineID].DISid = _id;
        MedicineStock[_medicineID].stage = STAGE.Distribution;
        StorageStock[_medicineID].temp= _temp;
        StorageStock[_medicineID].humidity= _hum;
        CertificationStock[_medicineID].certify = Certification.No;
    }

    //To check if distributor is available in the blockchain
    function findDIS(address _address) private view returns (uint256) {
        require(disCtr > 0);
        for (uint256 i = 1; i <= disCtr; i++) {
            if (DIS[i].addr == _address) return DIS[i].id;
        }
        return 0;
    }

    //To supply medicines from distributor to retailer
    function Retail(uint256 _medicineID) public {
        require(_medicineID > 0 && _medicineID <= medicineCtr);
        uint256 _id = findRET(msg.sender);
        require(_id > 0);
        require(MedicineStock[_medicineID].stage == STAGE.Distribution);
        MedicineStock[_medicineID].RETid = _id;
        MedicineStock[_medicineID].stage = STAGE.Retail;
        CertificationStock[_medicineID].certify = Certification.Yes;
    }

    //To check if retailer is available in the blockchain
    function findRET(address _address) private view returns (uint256) {
        require(retCtr > 0);
        for (uint256 i = 1; i <= retCtr; i++) {
            if (RET[i].addr == _address) return RET[i].id;
        }
        return 0;
    }

    //To sell medicines from retailer to consumer
    function sold(uint256 _medicineID) public {
        require(_medicineID > 0 && _medicineID <= medicineCtr);
        uint256 _id = findRET(msg.sender);
        require(_id > 0);
        require(_id == MedicineStock[_medicineID].RETid); //Only correct retailer can mark medicine as sold
        require(MedicineStock[_medicineID].stage == STAGE.Retail);
        MedicineStock[_medicineID].stage = STAGE.sold;
    }

    // To add new medicines to the stock
    function addMedicine(string memory _name)
        public
        onlyByOwner()
    {
        require((rmsCtr > 0) && (manCtr > 0) && (disCtr > 0) && (retCtr > 0));
        medicineCtr++;
        MedicineStock[medicineCtr] = product(
            medicineCtr,
            _name,
            0,
            0,
            0,
            0,
            STAGE.Init,price1,price2,price3,price4,organicscore);
    }
}
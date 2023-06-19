CREATE TABLE `WombatHR`.`Grade`(
    `GradeID` INT AUTO_INCREMENT NOT NULL,
    `Title` VARCHAR(128) NOT NULL,
    `Code` VARCHAR(16) NOT NULL UNIQUE,
    `SpineMin` INT NOT NULL DEFAULT 1,
    `SpineMax` INT NOT NULL DEFAULT 1,
    INDEX(`GradeID`),
    INDEX(`Code`),
    PRIMARY KEY(`GradeID`)
    );
	
CREATE TABLE `WombatHR`.`Project` ( 
	`ProjectID` BIGINT NOT NULL AUTO_INCREMENT , 
	`Title` VARCHAR(255) NOT NULL , 
	`Notes` TEXT NULL , 
	`Internal` BOOLEAN NOT NULL DEFAULT 0 , 
	`Sensitive` BOOLEAN NOT NULL DEFAULT 0 , 
	`Started` DATE NOT NULL , 
	`Ended` DATE NULL , 
	PRIMARY KEY (`ProjectID`), 
	INDEX `Title` (`Title`), 
	INDEX `Notes` (`Notes`)
	);
	
CREATE TABLE `WombatHR`.`Equipment` ( 
	`EquipmentID` BIGINT NOT NULL AUTO_INCREMENT , 
	`Type` VARCHAR(255) NOT NULL , 
	`Make` VARCHAR(255) NULL , 
	`Model` VARCHAR(255) NULL , 
	`Description` VARCHAR(255) NULL , 
	`OperationNotes` TEXT NULL , 
	`Damaged` BOOLEAN NOT NULL DEFAULT 0 , 
	PRIMARY KEY (`EquipmentID`), 
	INDEX `Type` (`Type`), 
	INDEX `Model` (`Model`), 
	INDEX `Description` (`Description`), 
	INDEX `Damaged` (`Damaged`)
	);
	
CREATE TABLE `WombatHR`.`Skill` ( 
	`SkillID` BIGINT NOT NULL AUTO_INCREMENT , 
	`Title` VARCHAR(255) NOT NULL UNIQUE, 
	PRIMARY KEY (`SkillID`), 
	INDEX (`Title`)
	);

CREATE TABLE `WombatHR`.`Employee` ( 
	`EmployeeID` BIGINT NOT NULL AUTO_INCREMENT , 
	`Title` VARCHAR(32) NULL , 
	`FirstName` VARCHAR(255) NOT NULL , 
	`LastName` VARCHAR(255) NOT NULL , 
	`Email` VARCHAR(255) NULL UNIQUE, 
	`Joined` DATE NULL , 
	`Left` DATE NULL , 
	`Current` BOOLEAN NOT NULL DEFAULT 1 , 
	`Phone` VARCHAR(32) NOT NULL , 
	`GradeID` INT NOT NULL ,
	`Manager` BIGINT NULL , 
	PRIMARY KEY (`EmployeeID`), 
	INDEX (`Email`), 
	INDEX `FirstName` (`FirstName`), 
	INDEX `LastName` (`LastName`), 
	INDEX `Manager` (`Manager`), 
	INDEX `Current` (`Current`),
	FOREIGN KEY (`Manager`) REFERENCES Employee(`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`GradeID`) REFERENCES Grade(`GradeID`) ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE `WombatHR`.`Assignment` ( 
	`ProjectID` BIGINT NOT NULL , 
	`EmployeeID` BIGINT NOT NULL , 
	INDEX `EmployeeProjectID` (`ProjectID`, `EmployeeID`),
	FOREIGN KEY (`EmployeeID`) REFERENCES Employee(`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`ProjectID`) REFERENCES Project(`ProjectID`) ON DELETE CASCADE ON UPDATE CASCADE
	);
	
CREATE TABLE `WombatHR`.`FileItem` ( 
	`ItemID` BIGINT NOT NULL AUTO_INCREMENT , 
	`Title` VARCHAR(255) NOT NULL DEFAULT '\"\"' , 
	`Location` VARCHAR(255) NOT NULL DEFAULT '\"\"' , 
	`EmployeeID` BIGINT NOT NULL , 
	PRIMARY KEY (`ItemID`), 
	INDEX `Title` (`Title`), 
	INDEX `EmployeeID` (`EmployeeID`),
	FOREIGN KEY (`EmployeeID`) REFERENCES Employee(`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE `WombatHR`.`EmployeeSkill` ( 
	`EmployeeID` BIGINT NOT NULL , 
	`SkillID` BIGINT NOT NULL , 
	`DateAchieved` DATE NULL , 
	INDEX `EmployeeSkillID` (`EmployeeID`, `SkillID`),
	FOREIGN KEY (`EmployeeID`) REFERENCES Employee(`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`SkillID`) REFERENCES Skill(`SkillID`) ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE `WombatHR`.`Payslip` ( 
	`PayslipID` BIGINT NOT NULL AUTO_INCREMENT , 
	`EmployeeID` BIGINT NOT NULL , 
	`Taxable` DOUBLE NOT NULL DEFAULT '0' , 
	`NonTaxable` DOUBLE NOT NULL DEFAULT '0' , 
	`IncomeTax` DOUBLE NOT NULL DEFAULT '0' , 
	`NationalInsurance` DOUBLE NOT NULL DEFAULT '0' , 
	`NetPay` DOUBLE NOT NULL DEFAULT '0' , 
	`Payday` DATE NOT NULL , 
	`TransferDay` DATE NOT NULL , 
	`TransferRef` VARCHAR(32) NOT NULL , 
	PRIMARY KEY (`PayslipID`), 
	INDEX `EmployeeID` (`EmployeeID`),
	FOREIGN KEY (`EmployeeID`) REFERENCES Employee(`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE
	);	

CREATE TABLE `WombatHR`.`Contract` ( 
	`ContractID` BIGINT NOT NULL AUTO_INCREMENT , 
	`Title` VARCHAR(255) NOT NULL , 
	`Start` DATE NOT NULL , 
	`DueFinish` DATE NULL , 
	`ActualFinish` DATE NULL , 
	`EmployeeID` BIGINT NOT NULL , 
	PRIMARY KEY (`ContractID`), 
	INDEX `Title` (`Title`), 
	INDEX `EmployeeID` (`EmployeeID`),
	FOREIGN KEY (`EmployeeID`) REFERENCES Employee(`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE `WombatHR`.`EquipmentLoan` ( 
	`EmployeeID` BIGINT NOT NULL , 
	`EquipmentID` BIGINT NOT NULL , 
	`StartDate` DATE NOT NULL , 
	`EndDate` DATE NULL , 
	`Current` BOOLEAN NOT NULL DEFAULT 1 , 
	`Notes` TEXT NULL , 
	INDEX `EmployeeEquipmentID` (`EmployeeID`, `EquipmentID`), 
	INDEX `StartDate` (`StartDate`), 
	INDEX `EndDate` (`EndDate`), 
	INDEX `Current` (`Current`),
	FOREIGN KEY (`EmployeeID`) REFERENCES Employee(`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`EquipmentID`) REFERENCES Equipment(`EquipmentID`) ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE `WombatHR`.`Expense` ( 
	`ExpenseID` BIGINT NOT NULL AUTO_INCREMENT , 
	`EmployeeID` BIGINT NOT NULL , 
	`ProjectID` BIGINT NULL , 
	`Description` VARCHAR(255) NOT NULL , 
	`Amount` DOUBLE NOT NULL , 
	`Paid` BOOLEAN NOT NULL DEFAULT 0 , 
	PRIMARY KEY (`ExpenseID`), 
	INDEX `Description` (`Description`), 
	INDEX `EmployeeID` (`EmployeeID`), 
	INDEX `ProjectID` (`ProjectID`),
	FOREIGN KEY (`EmployeeID`) REFERENCES Employee(`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`ProjectID`) REFERENCES Project(`ProjectID`) ON DELETE CASCADE ON UPDATE CASCADE
	);
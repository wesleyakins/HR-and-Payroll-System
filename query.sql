1.
SELECT Equipment.EquipmentID, Equipment.Make, Equipment.Model, Equipment.Description 
FROM Equipment
LEFT JOIN EquipmentLoan ON Equipment.EquipmentID = EquipmentLoan.EquipmentID
WHERE Damaged = '0' 
AND 
TYPE LIKE '%video%' 
OR 
Description LIKE '%video%' 
AND EndDate IS NOT NULL;

2.
SELECT Employee.EmployeeID, Employee.FirstName, Employee.LastName
FROM Employee
LEFT JOIN Contract ON Employee.EmployeeID = Contract.EmployeeID
WHERE DueFinish LIKE '%2019%';

3.
SELECT `Project`.`Title`, `Expense`.`Amount` AS `Expenses`
FROM `Project` 
LEFT JOIN `Expense` ON `Expense`.`ProjectID` = `Project`.`ProjectID`

4.
SELECT `Employee`.`FirstName`, `Employee`.`LastName`, `Employee`.`Email`, `Grade`.`Title`
FROM `Employee` 
LEFT JOIN `Grade` ON `Employee`.`GradeID` = `Grade`.`GradeID`
JOIN `EmployeeSkill` ON `Employee`.`EmployeeID`=  `EmployeeSkill`.`SkillID`
JOIN `Skill` ON `EmployeeSkill`.`SkillID` = `Skill`.`Title`
WHERE `Skill`.`Title` LIKE 'video'

5.
SELECT `Project`.`Title`, `Assignment`.`EmployeeID`, `Project`.*
FROM `Project` 
LEFT JOIN `Assignment` ON `Assignment`.`ProjectID` = `Project`.`ProjectID`
WHERE `Project`.`Internal`= 0 AND COUNT(Assignment.EmployeeID) > '2';

6.
SELECT `Employee`.`EmployeeID`, `Employee`.`FirstName`, `Employee`.`LastName`, `Assignment`.*
FROM `Employee` 
LEFT JOIN `Assignment` ON `Assignment`.`EmployeeID` = `Employee`.`EmployeeID`
WHERE Assignment.EmployeeID NOT LIKE Employee.EmployeeID

7.
SELECT `Skill`.`Title`, COUNT(`EmployeeSkill`.`EmployeeID`) AS 'No of Skilled Employees'
FROM `Skill` 
LEFT JOIN `EmployeeSkill` ON `EmployeeSkill`.`SkillID` = `Skill`.`SkillID`;

8.
SELECT `EquipmentLoan`.`EmployeeID`, count(`EquipmentLoan`.`Current`)
FROM `EquipmentLoan`
WHERE `EquipmentLoan`.`Current` = 1;

9.
SELECT `EquipmentLoan`.`EmployeeID`, count(`EquipmentLoan`.`Current`)
FROM `EquipmentLoan`;

10.
SELECT `Payslip`.`EmployeeID`, `Payslip`.`PayslipID`, `Contract`.`DueFinish`
FROM `Payslip`,`Contract`
WHERE Contract.DueFinish BETWEEN '2017-01-01' AND '2017-12-31';
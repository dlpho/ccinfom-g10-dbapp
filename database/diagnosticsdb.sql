-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema diagnosticsdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `diagnosticsdb` ;

-- -----------------------------------------------------
-- Schema diagnosticsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `diagnosticsdb` DEFAULT CHARACTER SET utf8 ;
USE `diagnosticsdb` ;

-- -----------------------------------------------------
-- Table `diagnosticsdb`.`REF_InsuranceInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnosticsdb`.`REF_InsuranceInfo` ;

CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`REF_InsuranceInfo` (
  `insurance_provider` VARCHAR(45) NOT NULL,
  `pct_coverage` DECIMAL(3,2) NOT NULL,
  `min_amount` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`insurance_provider`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Patients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnosticsdb`.`Patients` ;

CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Patients` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(20) NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `middle_name` VARCHAR(20) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `contact_number` VARCHAR(13) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `zip_code` SMALLINT NOT NULL,
  `insurance_provider` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  INDEX `fk_Patients_InsuranceInfo1_idx` (`insurance_provider` ASC) VISIBLE,
  UNIQUE INDEX `contact_number_UNIQUE` (`contact_number` ASC) VISIBLE,
  CONSTRAINT `fk_Patients_InsuranceInfo1`
    FOREIGN KEY (`insurance_provider`)
    REFERENCES `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1001;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Appointments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnosticsdb`.`Appointments` ;

CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Appointments` (
  `appointment_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `num_tests` INT NOT NULL COMMENT 'number of tests ordered for this appointment',
  `order_date` DATETIME NOT NULL,
  `scheduled_date` DATETIME NOT NULL,
  `test_date` DATETIME NOT NULL DEFAULT '9999-01-01 00:00:00' COMMENT 'default if haven\'t done any test',
  `status` ENUM('Scheduled', 'Rescheduled', 'In-Progress', 'Pending Payment', 'Completed', 'Completed w/ Follow-up Advised)', 'Canceled') NOT NULL,
  PRIMARY KEY (`appointment_id`),
  INDEX `patient_id_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `patient_id`
    FOREIGN KEY (`patient_id`)
    REFERENCES `diagnosticsdb`.`Patients` (`patient_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Equipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnosticsdb`.`Equipment` ;

CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Equipment` (
  `equip_name` VARCHAR(45) NOT NULL,
  `location` ENUM('Hematology Lab', 'Biochemistry Lab', 'Microbiology Lab', 'Imaging Lab') NOT NULL,
  `condition` ENUM('Functional', 'Needs Maintenance', 'Out of Order') NOT NULL,
  `maintenance_start` DATETIME NULL DEFAULT NULL,
  `maintenance_end` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`equip_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`REF_OutcomesTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnosticsdb`.`REF_OutcomesTypes` ;

CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`REF_OutcomesTypes` (
  `outcome_type` TINYINT NOT NULL,
  PRIMARY KEY (`outcome_type`),
  INDEX `index2` (`outcome_type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Tests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnosticsdb`.`Tests` ;

CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Tests` (
  `test_type` VARCHAR(5) NOT NULL,
  `test_name` VARCHAR(45) NOT NULL,
  `equip_name` VARCHAR(45) NOT NULL,
  `test_cost` DECIMAL(7,2) NOT NULL,
  `days_valid` INT NOT NULL,
  `outcome_type` TINYINT NOT NULL,
  PRIMARY KEY (`test_type`),
  UNIQUE INDEX `test_name_UNIQUE` (`test_name` ASC) VISIBLE,
  INDEX `fk_Tests_Equipment1_idx` (`equip_name` ASC) VISIBLE,
  INDEX `fk_Tests_REF_ChoiceTypes1_idx` (`outcome_type` ASC) VISIBLE,
  CONSTRAINT `fk_Tests_Equipment1`
    FOREIGN KEY (`equip_name`)
    REFERENCES `diagnosticsdb`.`Equipment` (`equip_name`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tests_REF_ChoiceTypes1`
    FOREIGN KEY (`outcome_type`)
    REFERENCES `diagnosticsdb`.`REF_OutcomesTypes` (`outcome_type`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnosticsdb`.`Staff` ;

CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `middle_name` VARCHAR(20) NOT NULL,
  `role` ENUM('Technician', 'Doctor', 'Nurse', 'Administrator', 'Receptionist', 'Billing Clerk') NOT NULL,
  `contact_number` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE INDEX `contact_number_UNIQUE` (`contact_number` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 2001;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnosticsdb`.`Payments` ;

CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `appointment_id` INT NOT NULL,
  `total_cost` DECIMAL(7,2) NOT NULL,
  `payment_method` ENUM('N/A', 'Cash', 'Credit Card', 'Debit Card', 'Online Payment') NOT NULL DEFAULT 'N/A',
  `date_paid` DATETIME NOT NULL DEFAULT '9999-01-01 00:00:00' COMMENT 'default if unpaid',
  PRIMARY KEY (`payment_id`),
  INDEX `order_id_idx` (`appointment_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `diagnosticsdb`.`Appointments` (`appointment_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4001;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnosticsdb`.`Results` ;

CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Results` (
  `appointment_id` INT NOT NULL,
  `test_type` VARCHAR(5) NOT NULL,
  `staff_id` INT NOT NULL,
  `outcome` ENUM('Normal', 'Abnormal-Below', 'Abnormal-Above', 'Positive', 'Negative', 'Low Risk', 'Moderate Risk', 'High Risk', 'Invalid/Inconvlusive') NULL,
  `comments` TEXT NULL DEFAULT NULL,
  `status` ENUM('Completed', 'Pending', 'Canceled') NOT NULL DEFAULT 'Pending',
  INDEX `fk_Results_Appointments2_idx` (`appointment_id` ASC) VISIBLE,
  INDEX `fk_Results_Staff2_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fk_Results_Tests2_idx` (`test_type` ASC) VISIBLE,
  PRIMARY KEY (`appointment_id`, `test_type`),
  CONSTRAINT `fk_Results_Appointments2`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `diagnosticsdb`.`Appointments` (`appointment_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Results_Staff2`
    FOREIGN KEY (`staff_id`)
    REFERENCES `diagnosticsdb`.`Staff` (`staff_id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Results_Tests2`
    FOREIGN KEY (`test_type`)
    REFERENCES `diagnosticsdb`.`Tests` (`test_type`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`REF_Outcomes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnosticsdb`.`REF_Outcomes` ;

CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`REF_Outcomes` (
  `outcome` VARCHAR(45) NOT NULL,
  `outcome_type` TINYINT NOT NULL,
  PRIMARY KEY (`outcome`, `outcome_type`),
  INDEX `fk_REF_Outcomes_REF_OutcomesTypes1_idx` (`outcome_type` ASC) VISIBLE,
  CONSTRAINT `fk_REF_Outcomes_REF_OutcomesTypes1`
    FOREIGN KEY (`outcome_type`)
    REFERENCES `diagnosticsdb`.`REF_OutcomesTypes` (`outcome_type`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `diagnosticsdb` ;

-- -----------------------------------------------------
-- procedure get_appointments
-- -----------------------------------------------------

USE `diagnosticsdb`;
DROP procedure IF EXISTS `diagnosticsdb`.`get_appointments`;

DELIMITER $$
USE `diagnosticsdb`$$
CREATE PROCEDURE `get_appointments` (IN id INT)
BEGIN
	SELECT *
    FROM Appointments
    WHERE patient_id = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_results
-- -----------------------------------------------------

USE `diagnosticsdb`;
DROP procedure IF EXISTS `diagnosticsdb`.`get_results`;

DELIMITER $$
USE `diagnosticsdb`$$
CREATE PROCEDURE `get_results` (IN id INT)
BEGIN
	SELECT *
    FROM Results
    WHERE appointment_id = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_patient_results
-- -----------------------------------------------------

USE `diagnosticsdb`;
DROP procedure IF EXISTS `diagnosticsdb`.`get_patient_results`;

DELIMITER $$
USE `diagnosticsdb`$$
CREATE PROCEDURE `get_patient_results` (IN patient_id INT)
BEGIN
	SELECT a.order_date, r.*
    FROM Appointments a
    JOIN Results r ON a.appointment_id = a.appointment_id
    ORDER BY a.order_date ASC;
END$$

DELIMITER ;
USE `diagnosticsdb`;

DELIMITER $$

USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`REF_InsuranceInfo_Pct` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`REF_InsuranceInfo_Pct` 
BEFORE INSERT ON `REF_InsuranceInfo` 
FOR EACH ROW
BEGIN
    -- Check if the coverage_rate is between 0 and 1 (exclusive 0, inclusive 1)
    IF NEW.pct_coverage <= 0 OR NEW.pct_coverage >= 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Coverage rate must be between 0 (exclusive) and 1 (exclusive)';
    END IF;
END;$$


USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`Appointments_LimitNumTests` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`Appointments_LimitNumTests`
BEFORE INSERT ON `Appointments`
FOR EACH ROW
BEGIN
    -- Check if num_tests is between 1 and 5
    IF NEW.num_tests < 1 OR NEW.num_tests > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'num_tests must be between 1 and 5';
    END IF;
END;$$


USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`Appointments_Limit1PerDay` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`Appointments_Limit1PerDay`
BEFORE INSERT ON `Appointments`
FOR EACH ROW
BEGIN
    -- Check if there is already an appointment with the same patient_id and scheduled_date
    DECLARE existing_count INT;

    -- Query to count appointments with the same patient_id and scheduled_date
    SELECT COUNT(*) INTO existing_count
    FROM `Appointments`
    WHERE `patient_id` = NEW.patient_id
    AND DATE(`scheduled_date`) = DATE(NEW.scheduled_date);

    -- If an appointment already exists for the same patient on the same day, prevent the insert
    IF existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Patient already has an appointment scheduled for this day.';
    END IF;
END;$$


USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`Appointments_MakePayment` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`Appointments_MakePayment` 
AFTER UPDATE ON `Appointments` 
FOR EACH ROW
BEGIN
	DECLARE total_cost DECIMAL(7,2);

    IF NEW.status = 'Completed' AND OLD.status != 'Completed' THEN
		-- Compute the total cost from the Results table
        
		SELECT SUM(t.test_cost) INTO total_cost
		FROM Results r
		JOIN Tests t ON t.test_type = r.test_type
		WHERE appointment_id = NEW.appointment_id AND r.status = 'Completed';	
		
        -- Create payment entry
        INSERT INTO `Payments` (total_cost, appointment_id)
        VALUES (total_cost, NEW.appointment_id);
    END IF;
END;$$


USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`Payments_NoPayAllCancel` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`Payments_NoPayAllCancel`
BEFORE INSERT ON `Payments`
FOR EACH ROW
BEGIN
    DECLARE cancelled_count INT;
    DECLARE num_tests INT;

    -- Count the number of Results with status 'Cancelled'
    SELECT COUNT(*) INTO cancelled_count
    FROM Results
    WHERE appointment_id = NEW.appointment_id AND status = 'Canceled';
	
    SELECT num_tests INTO num_tests
    FROM Appointments
    WHERE NEW.appointment_id = appointment_id;
    -- Check if all Results are cancelled
    IF cancelled_count = num_tests THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot create payment: all results are cancelled.';
    END IF;
END;$$


USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`Payments_ApptCanceled` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`Payments_ApptCanceled` 
BEFORE INSERT ON `Payments` 
FOR EACH ROW
BEGIN
    -- Declare a variable to hold the Appointment status
    DECLARE appointment_status VARCHAR(255);

    -- Get the status of the Appointment associated with the payment
    SELECT status INTO appointment_status
    FROM Appointments
    WHERE appointment_id = NEW.appointment_id;

    -- If the Appointment status is 'Cancelled', signal an error and prevent payment insertion
    IF appointment_status = 'Canceled' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot make payment. Appointment status is Cancelled.';
    END IF;
END;$$


USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`Payment_UpdateApptStatus` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`Payment_UpdateApptStatus`
AFTER UPDATE ON `Payments`
FOR EACH ROW
BEGIN
    -- Check if the new payment_method is not 'Unpaid'
    IF NEW.payment_method != 'N/A' THEN
        -- Update the corresponding Appointments status to 'Completed'
        UPDATE Appointments
        SET status = 'Completed',
            date_paid = NOW()  -- Set the date_paid to the current timestamp
        WHERE appointment_id = NEW.appointment_id; -- Assuming there's an appointment_id in Payment that links to Appointments
    END IF;
END;$$


USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`Results_LimitToNumOrdered` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`Results_LimitToNumOrdered`
BEFORE INSERT ON `Results`
FOR EACH ROW
BEGIN
    DECLARE ordered_tests INT;

    -- Get the number of tests ordered for the appointment
    SELECT num_tests INTO ordered_tests
    FROM Appointments
    WHERE appointment_id = NEW.appointment_id;

    -- Check if the number of existing test results for this appointment exceeds the limit
    IF (SELECT COUNT(*) FROM Results WHERE appointment_id = NEW.appointment_id) >= ordered_tests THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot add more test results than the number of tests ordered for this appointment';
    END IF;
END;$$


USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`Results_NoSameTestType` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`Results_NoSameTestType`
BEFORE INSERT ON `Results`
FOR EACH ROW
BEGIN
    -- Check if the test_type for the given appointment_id already exists in the Results table
    DECLARE existing_count INT;

    -- Query to count the number of results with the same appointment_id and test_type
    SELECT COUNT(*) INTO existing_count
    FROM `Results`
    WHERE `appointment_id` = NEW.appointment_id
    AND `test_type` = NEW.test_type;

    -- If there is already a result with the same appointment_id and test_type, prevent the insert
    IF existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A result with the same test_type already exists for this appointment.';
    END IF;
END;$$


USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`Results_CompleteAppt` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`Results_CompleteAppt` 
AFTER UPDATE ON `Results` 
FOR EACH ROW
BEGIN
    -- Declare a variable to count results with invalid status
    DECLARE not_done INT;

    -- Check if there are any results with status other than 'Completed' or 'Cancelled' for the same appointment_id
    SELECT COUNT(*) INTO not_done
    FROM Results r
    WHERE appointment_id = NEW.appointment_id
    AND status = 'Pending';

    -- If all tests done update the appointment status to 'Completed'
    IF not_done = 0 THEN
        UPDATE Appointments
        SET status = 'Completed'
        WHERE appointment_id = New.appointment_id;
    END IF;
END;$$


USE `diagnosticsdb`$$
DROP TRIGGER IF EXISTS `diagnosticsdb`.`Results_CancelAppt` $$
USE `diagnosticsdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `diagnosticsdb`.`Results_CancelAppt` 
AFTER UPDATE ON `Results`
FOR EACH ROW
BEGIN
    -- Declare a variable to count cancelled results
    DECLARE cancelled_count INT;
    DECLARE total_tests INT;

    -- Get the number of cancelled results for the same appointment_id
    SELECT COUNT(*) INTO cancelled_count
    FROM Results r
    WHERE r.appointment_id = NEW.appointment_id
    AND r.status = 'Canceled';

    -- Get the number of tests in the appointment
    SELECT num_tests INTO total_tests
    FROM Appointments
    WHERE appointment_id = NEW.appointment_id;

    -- If the number of cancelled results equals the number of tests, update the appointment status to 'Cancelled'
    IF cancelled_count = total_tests THEN
        UPDATE Appointments
        SET status = 'Canceled'
        WHERE appointment_id = NEW.appointment_id;
    END IF;
END;$$


DELIMITER ;
SET SQL_MODE = '';
DROP USER IF EXISTS Admin;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'Admin' IDENTIFIED BY 'password123';

GRANT ALL ON `diagnosticsdb`.* TO 'Admin';
SET SQL_MODE = '';
DROP USER IF EXISTS Staff;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'Staff';

GRANT SELECT ON TABLE `diagnosticsdb`.* TO 'Staff';
GRANT SELECT, INSERT, TRIGGER ON TABLE `diagnosticsdb`.* TO 'Staff';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `diagnosticsdb`.* TO 'Staff';
SET SQL_MODE = '';
DROP USER IF EXISTS Patient;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'Patient';

GRANT SELECT ON TABLE `diagnosticsdb`.* TO 'Patient';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `diagnosticsdb`.`REF_InsuranceInfo`
-- -----------------------------------------------------
START TRANSACTION;
USE `diagnosticsdb`;
INSERT INTO `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`, `pct_coverage`, `min_amount`) VALUES ('Philam Life', 0.12, 1000.00);
INSERT INTO `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`, `pct_coverage`, `min_amount`) VALUES ('Sun Life', 0.20, 1200.00);
INSERT INTO `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`, `pct_coverage`, `min_amount`) VALUES ('Manulife', 0.45, 3520.00);
INSERT INTO `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`, `pct_coverage`, `min_amount`) VALUES ('AXA Philippines', 0.10, 750.00);
INSERT INTO `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`, `pct_coverage`, `min_amount`) VALUES ('CARD MRI Insurance', 0.33, 2450.00);
INSERT INTO `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`, `pct_coverage`, `min_amount`) VALUES ('Bayani Insurance', 0.40, 3200.00);
INSERT INTO `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`, `pct_coverage`, `min_amount`) VALUES ('BPI Life Insurance', 0.25, 1225.00);
INSERT INTO `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`, `pct_coverage`, `min_amount`) VALUES ('FWD Life Insurance', 0.50, 4000.00);
INSERT INTO `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`, `pct_coverage`, `min_amount`) VALUES ('Lunas Insurance', 0.66, 6900.00);
INSERT INTO `diagnosticsdb`.`REF_InsuranceInfo` (`insurance_provider`, `pct_coverage`, `min_amount`) VALUES ('Pru Life UK', 0.60, 8200.00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `diagnosticsdb`.`Patients`
-- -----------------------------------------------------
START TRANSACTION;
USE `diagnosticsdb`;
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1001, 'Go', 'Rhea Joy', 'Cabuyao', '2001-10-05', 'F', '09123456789', '2252 Pasong Tamo', 'Makati City', 'Metro Manila', 1200, 'Philam Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1039, 'Dela Torre', 'Lucas', 'Garcia', '1990-02-17', 'M', '09272345678', 'lot 2 block 4 Bartalome', 'Binan', 'Laguna', 4024, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1002, 'Quigley', 'Mason', 'Galvez', '1995-08-23', 'M', '09286543210', '261 Baltazar St', 'Caloocan City', 'Metro Manila', 1123, 'Sun Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1047, 'Lacson', 'Faye Anne', 'Mamaril', '1999-12-12', 'F', '09152345678', '618 6th Avenue', 'Caloocan City', 'Metro Manila', 1400, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1056, 'Enriquez', 'Jessa', 'Wenceslao', '1992-03-30', 'F', '09187654321', '166 General Luna Street', 'Caloocan City', 'Metro Manila', 1408, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1086, 'Radcliffe', 'Nia', 'Felix', '1998-04-15', 'F', '09175462431', '170 F. Roxas Street', 'Caloocan City', 'Metro Manila', 1420, 'AXA Philippines');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1087, 'Garcia', 'Julyan Faith', 'De Luna', '1983-11-09', 'F', '09323451678', '163 M. Bartolome St.', 'Caloocan City', 'Metro Manila', 1400, 'CARD MRI Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1090, 'Ramos', 'Dan', 'Morillo', '1986-01-06', 'M', '09293761981', '810 McArthur Road', 'Caloocan City', 'Metro Manila', 1400, 'CARD MRI Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1009, 'Morales', 'Louie', 'Ylagan', '1991-07-14', 'M', '09167890123', '166 M.L. Quezon Street', 'Antipolo City', 'Rizal', 1870, 'CARD MRI Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1010, 'Fabella', 'Faye', 'Danao', '1994-09-11', 'F', '09081234567', '305 Wayan Boni Avenue', 'Iloilo City', 'Iloilo', 5000, 'Bayani Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1011, 'Gamalinda', 'Joy', 'Osorio', '1996-05-17', 'F', '09186543210', '305 Wayan Boni Avenue', 'Iloilo City', 'Iloilo', 5000, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1012, 'Jimenez', 'Leah', 'Sumagaysay', '1990-06-22', 'F', '09338765432', 'b2 lot 3 2nd St.', 'Bacoor', 'Cavite', 4102, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1013, 'Castillo', 'Vince', 'Waling', '1980-12-03', 'M', '09456782345', 'b2 lot 3 2nd St.', 'Bacoor', 'Cavite', 4102, 'Philam Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1014, 'Abad', 'Aris', 'Zamora', '1994-11-21', 'M', '09378901234', 'b2 lot 3 2nd St.', 'Bacoor', 'Cavite', 4102, 'Sun Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1015, 'De Guzman', 'Alex', 'Rigor', '1998-06-04', 'F', '09065439876', '12 San Jose Street', 'Ligao', 'Albay', 4504, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1016, 'Catubay', 'Nina', 'Kasilag', '1992-10-25', 'F', '09147654321', 'B12 L7 Kaliraya Rd', 'Quezon City', 'Metro Manila', 1103, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1017, 'Torres', 'Rita', 'Velez', '1987-02-11', 'F', '09182345678', 'B3 L2 Visita Altares Pasong Putik', 'Quezon City', 'Metro Manila', 1118, 'BPI Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1018, 'Santos', 'Sheryl', 'Gamboa', '1993-08-18', 'F', '09248765432', 'B3 L2 Visita Altares Pasong Putik', 'Quezon City', 'Metro Manila', 1118, 'FWD Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1023, 'Quimpo', 'John Paul', 'Jugueta', '1989-01-25', 'M', '09172345678', '503-D St. Agnes', 'Las Pinas', 'Metro Manila', 1740, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1059, 'Aquino', 'Daryl', 'Kanto', '1991-12-10', 'M', '09293234321', 'M Alvarez Avenue', 'Las Pinas', 'Metro Manila', 1740, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1005, 'Aquino', 'Max', 'Unas', '1995-05-05', 'M', '09328901234', '2406 J A Santos Avenue', 'Silang', 'Cavite', 4118, 'BPI Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1022, 'Torres', 'Gigi', 'Yumul', '1985-07-28', 'F', '09345678901', '222 Diversion Road', 'Lucena City', 'Quezon', 4301, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1006, 'Fajardo', 'Ella Mae', 'Wenceslao', '1993-01-03', 'F', '09032456789', '301b Aguirre Building', 'Makati City', 'Metro Manila', 1201, 'FWD Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1008, 'Mendoza', 'Tessa', 'Abad', '1999-11-26', 'F', '09223456789', '6F Zeta Building 191 Salcedo Street', 'Makati City', 'Metro Manila', 1200, 'AXA Philippines');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1025, 'Nolasco', 'Jessa Mae', 'Candido', '2004-09-14', 'F', '09211234567', 'Prince Tower 80 M. Cornejo Street', 'Pasay City', 'Metro Manila', 1300, 'BPI Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1019, 'Ocampo', 'Maria Clara', 'Alayon', '1988-04-12', 'F', '09287654321', 'Sakap Building, 121 Sacred Heart Street', 'Makati City', 'Metro Manila', 1210, 'Lunas Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1020, 'Estrella', 'Anna', 'Ubial', '1997-02-01', 'F', '09347654321', '2210 Chino Roces Avenue', 'Makati City', 'Metro Manila', 1209, 'Philam Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1029, 'Bautista', 'Jose', 'Inocencio', '1992-07-19', 'M', '09407654321', '11-6 Rainbow Drive', 'Makati City', 'Metro Manila', 1200, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1034, 'Quimpo', 'Zia', 'Delacruz', '1990-11-10', 'F', '09025678901', '8061 Estrella Avenue', 'Makati City', 'Metro Manila', 1210, 'AXA Philippines');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1048, 'White', 'Cora', 'Ubaldo', '1997-08-30', 'F', '09134567890', '13-F Perea Street', 'Makati City', 'Metro Manila', 1200, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1031, 'Reyes', 'Edwin', 'Feliciano', '1994-02-22', 'M', '09078765432', '1145-A M. Ocampo Street', 'Cavite City', 'Cavite', 4100, 'BPI Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1032, 'Ramos', 'Jojo', 'Galang', '1998-03-08', 'M', '09219287543', '03337 Borromeo Street', 'Surigao City', 'Surigao del Norte', 8400, 'FWD Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1033, 'Jambalos', 'Rina', 'Nihil', '1985-09-04', 'F', '09176432165', '48 D. Tuazon Street ', 'Quezon City', 'Metro Manila', 1100, 'Lunas Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1063, 'Morales', 'Mia', 'Urbano', '1982-12-25', 'M', '09112452342', 'Comembo Street, 81', 'Makati City', 'Metro Manila', 1200, 'AXA Philippines');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1077, 'Galvez', 'Lito', 'Deniega', '1999-06-14', 'M', '09176543210', '2275 Chino Roces St.', 'Makati City', 'Metro Manila', 1231, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1081, 'Sinclair', 'Ted', 'Villamor', '1983-07-29', 'M', '09136548578', 'Unit3-F Teresa Apartment ', 'Makati City', 'Metro Manila', 1200, 'Bayani Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1037, 'Reyes', 'Trixie Mae', 'Fuentebella', '1996-10-11', 'F', '09278201347', 'Mercantile Insurance Building', 'Manila', 'Metro Manila', 1000, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1082, 'Bautista', 'Ben', 'Regino', '1990-05-01', 'M', '09121356789', '1511 Cityland PT Towers', 'Makati City', 'Metro Manila', 1200, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1083, 'Magsino', 'Kim', 'Bicolano', '1981-10-19', 'F', '09056782345', 'UNIT 9-A 9/F Country Bldg. Forte Ave.', 'Makati City', 'Metro Manila', 1200, 'Sun Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1096, 'Santos', 'Marco', 'Ureta', '1993-01-25', 'M', '09186541234', '23B JCS St', 'Makati City', 'Metro Manila', 1200, 'Sun Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1021, 'Pineda', 'Gary', 'Natividad', '1984-04-08', 'M', '09065432345', '559 J. Luna Street', 'Mandaluyong City', 'Metro Manila', 1551, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1004, 'Panganiban', 'Lisa Marie', 'Malanday', '1998-07-21', 'F', '09054323445', '4B Quinta St', 'Manila', 'Metro Manila', 1012, 'Pru Life UK');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1026, 'Sarmiento', 'Juan Carlos', 'Dizon', '2013-07-23', 'M', '09265439876', '936 Espeleta Street Sta. Cruz ', 'Manila', 'Metro Manila', 1018, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1028, 'Villanueva', 'Renz', 'Xaver', '1999-09-28', 'M', '09087654321', 'Mercantile Insurance Building', 'Manila', 'Metro Manila', 1000, 'Sun Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1045, 'Yu', 'Rami Joseph', 'Gregorio', '1991-04-13', 'M', '09198765432', '5F McKinley Street', 'Roxas City', 'Capiz', 5800, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1046, 'Ogihara', 'Miguel', 'Batalion', '1987-06-23', 'M', '09297654321', '23-A Acacia Street', 'Quezon City', 'Metro Manila', 1101, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1035, 'Gatchalian', 'Liza Mae', 'Miralles', '1996-08-09', 'F', '09276543210', '24C Tomas Mapua St.', 'Manila', 'Metro Manila', 1000, 'CARD MRI Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1040, 'Cruz', 'Zane Anthony', 'Nunes', '2004-12-17', 'M', '09224567643', '56 Sabayle Street', 'Silang', 'Cavite', 4118, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1041, 'Dela Cruz', 'Carla', 'Castillo', '1992-09-02', 'F', '09023456789', 'Rm. 206 Plaza Towers, Ermita Street', 'Manila', 'Metro Manila', 1000, 'Philam Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1050, 'Bulaon', 'Jace Paul', 'Pagdanganan', '1995-06-27', 'M', '09347890123', '16B Bonifacio Rd.', 'Angeles City', 'Pampanga', 2009, 'BPI Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1051, 'Shi', 'Carl', 'Albano', '1999-02-19', 'M', '09323876231', 'F. Cabahug Street, Mabolo', 'Cebu City', 'Cebu', 6000, 'FWD Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1042, 'Rigor', 'David John', 'Tria', '1980-11-11', 'M', '09128395678', 'L13 B20 Binondo', 'Manila', 'Metro Manila', 1009, 'Sun Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1049, 'Jimenez', 'Niko', 'Wagas', '1998-10-05', 'M', '09342930133', 'Rm 306 3/F Mercantile Insurance Bldg.', 'Manila', 'Metro Manila', 1000, 'Philam Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1054, 'Bautista', 'Ethan', 'Obispo', '1997-09-12', 'M', '09245398776', '1 San Pedro', 'Magalang', 'Pampanga', 2011, 'Philam Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1055, 'Magsino', 'Chet', 'Sison', '1994-07-28', 'M', '09354230678', '1904 J Zamora St.', 'Manila', 'Metro Manila', 1001, 'Sun Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1052, 'Dela Cruz', 'Nicole', 'Yabut', '1993-03-01', 'F', '09087634567', '517 Roxas Boulevard', 'Manila', 'Metro Manila', 1015, 'Lunas Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1053, 'Reyes', 'Chris', 'Delos Santos', '1989-05-24', 'M', '09182376123', 'Mercantile Insurance Building', 'Manila', 'Metro Manila', 1000, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1058, 'Ramos', 'Tanya', 'Rosales', '1985-01-18', 'F', '09218765432', 'Unit 17/18 Juana Osmena St.', 'Cebu City', 'Cebu', 6000, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1057, 'Jimenez', 'Paul', 'Ho', '1997-11-13', 'M', '09156273499', '713 R. Hidalgo Street, Quiapo', 'Manila', 'Metro Manila', 1000, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1060, 'Santos', 'Mae', 'Vistal', '1999-04-25', 'F', '09176543123', '428 El Grande Avenue', 'Paranaque City', 'Metro Manila', 1700, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1061, 'Morales', 'Liam', 'Gaya', '1991-03-22', 'M', '09326432513', '32 Rosario Street', 'Legaspi', 'Albay', 4500, 'FWD Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1062, 'Taylor', 'Peter', 'Alcaraz', '1980-08-17', 'M', '09198765430', '2034 S Reyes', 'Manila', 'Metro Manila', 1000, 'Lunas Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1065, 'Ibay', 'Jay', 'Sison', '1984-06-06', 'M', '09351762563', 'Ermita', 'Manila', 'Metro Manila', 1000, 'Bayani Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1064, 'Villanueva', 'Ava', 'Noche', '1996-12-31', 'F', '09123456234', '#06 Don Julio Llorente Street', 'Cebu City', 'Cebu', 6000, 'CARD MRI Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1067, 'Anderson', 'Noah', 'Bantilan', '1986-11-04', 'M', '09231582374', '1118 J. Luna Street, Tondo', 'Manila', 'Metro Manila', 1000, 'Sun Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1085, 'Jackson', 'Ethan', 'Go', '1995-07-14', 'M', '09238951767', 'Quintin Paredes', 'Manila', 'Metro Manila', 1000, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1089, 'Dela Cruz', 'Harper', 'Jacinto', '1992-11-27', 'F', '09123457891', '23 Malabang', 'Manila', 'Metro Manila', 1015, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1068, 'Cruz', 'Ray', 'Cavite', '2003-02-02', 'M', '09329834556', '56 Sabayle Street', 'Silang', 'Cavite', 4118, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1092, 'Cruz', 'Fred', 'Silos', '1987-08-20', 'M', '09124657932', '56 Sabayle Street', 'Silang', 'Cavite', 4118, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1070, 'Hontiveros', 'Henry', 'Tadeo', '1994-04-04', 'M', '09298765432', 'Marasigan Street', 'Calaca', 'Batangas', 4212, 'BPI Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1071, 'Salcedo', 'Ralph', 'Co', '1980-03-21', 'M', '09376543210', '14E McArthur St', 'Marilao', 'Bulacan', 3019, 'FWD Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1072, 'Garcia', 'Arnold', 'Inocencio', '1999-01-02', 'M', '09175779187', '100 Scout Ojeda St.', 'Sampaloc', 'Quezon', 4329, 'Lunas Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1093, 'Villalobos', 'Grace Ann', 'Duenas', '1993-06-15', 'F', '09183545123', '1922 J.A. Santos Avenue', 'Manila', 'Metro Manila', 1000, 'AXA Philippines');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1074, 'Dela Cruz', 'Leo', 'Felipe', '1983-09-07', 'M', '09120345366', 'Block 18 Lot 8 Valencia', 'Bacoor', 'Cavite', 4102, 'FWD Life Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1075, 'Torres', 'Rhea Joy', 'Galvez', '1996-10-23', 'F', '09308765432', 'Bubog, San Jose', 'Silang', 'Cavite', 4118, 'Lunas Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1076, 'Ramos', 'Christine', 'Nituda', '1997-12-01', 'F', '09257641276', '854 Tabora Street ', 'Silang', 'Cavite', 4118, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1066, 'Quinto', 'Bea', 'Jara', '1990-10-06', 'F', '09172348766', 'Units 3,4 & 5, Sycamore Arcade', 'Muntinlupa City', 'Metro Manila', 1770, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1078, 'Prescott', 'Mark Anthony', 'Fernandez', '1999-07-31', 'M', '09224567291', 'Insular Village', 'Bansalan', 'Davao del Sur', 8005, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1079, 'Torres', 'Mia', 'Shi', '1981-05-08', 'F', '09378945691', '51-B Del Monte Avenue ', 'Quezon City', 'Metro Manila', 1100, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1007, 'Javelosa', 'Rick', 'Panganiban', '1992-08-27', 'M', '09023456781', '976 M Naval', 'Navotas', 'Metro Manila', 1400, 'Lunas Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1024, 'Kasilag', 'Kiko', 'Yu', '1982-01-01', 'M', '09412345678', 'Unit 10, Carfel Bldg., Aguirre St.', 'Paranaque', 'Metro Manila', 1700, 'Pru Life UK');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1003, 'Mendoza', 'Joy', 'Bantay', '1995-09-09', 'F', '09031567410', 'U-11-18 Meralco Avenue', 'Pasig', 'Metro Manila', 1604, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1073, 'Castillo', 'Ellaine', 'Mabilog', '1988-07-13', 'F', '09237452021', '890-A Eusebio Avenue', 'Pasig', 'Metro Manila', 1600, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1084, 'Aquino', 'Roy', 'Quinto', '1990-04-04', 'M', '09187456790', '2406 J A Santos Avenue', 'Silang', 'Cavite', 4118, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1027, 'Ilagan', 'Ana Marie', 'Tagle', '1997-05-25', 'F', '09238177589', '34 Morato Street', 'Quezon City', 'Metro Manila', 1100, 'Philam Life');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1036, 'Lopez', 'Daryl John', 'Egina', '1991-01-15', 'M', '09368452030', '12 Baesa St.', 'Quezon City', 'Metro Manila', 1106, 'Bayani Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1038, 'Villanueva', 'Mark Anthony', 'Ibarra', '1994-12-07', 'M', '09164849584', '#06 Don Julio Llorente Street', 'Cebu City', 'Cebu', 6000, 'CARD MRI Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1043, 'Macandog', 'Joni', 'Cruz', '1983-03-19', 'M', '09163834838', '745 Aurora Boulevard ', 'Quezon City', 'Metro Manila', 1112, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1044, 'Castillo', 'Ryan', 'Ciriaco', '1981-09-30', 'M', '09178348937', '6C North Avenue', 'Quezon City', 'Metro Manila', 1100, 'Bayani Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1080, 'Yu', 'Vicky', 'Guinto', '1995-02-14', 'F', '09172938427', '1295 Gen Araneta Avenue', 'Quezon City', 'Metro Manila', 1100, 'Lunas Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1091, 'Cruz', 'Liza Mae', 'Nepomuceno', '1998-05-16', 'F', '09172428743', '56 Sabayle Street', 'Silang', 'Cavite', 4118, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1088, 'Castillo', 'Zoe', 'Madrid', '1987-01-30', 'F', '09117747274', '6C North Avenue', 'Quezon City', 'Metro Manila', 1100, 'Bayani Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1094, 'Thorne', 'Juno', 'Altamirano', '1991-06-29', 'F', '09174728297', '78 Marang Street Project 2', 'Quezon City', 'Metro Manila', 1100, 'CARD MRI Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1069, 'Lontoc', 'Belle', 'Dela Cruz', '1993-02-09', 'F', '09162274992', '162 Aurora Boulevard', 'San Juan', 'Metro Manila', 1500, NULL);
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1030, 'Ching', 'Pio Andrew', 'Mendoza', '1983-12-27', 'M', '09168778982', '13 Bonifacio Street', 'Valenzuela', 'Metro Manila', 1440, 'Pru Life UK');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1095, 'Lopez', 'Vince', 'Quijano', '1999-06-03', 'M', '09172878277', '5082 Darlucio Street', 'Valenzuela', 'Metro Manila', 1447, 'Bayani Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1097, 'Garcia', 'Eren Myles', 'Felicidad', '1992-04-24', 'M', '09022382884', '12 Gapuz Zig-Zag Road', 'Imus', 'Cavite', 4103, 'Manulife');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1098, 'Lee', 'Kira Anne', 'Guardiano', '1994-10-17', 'F', '09032283247', 'L3 B18 Felix Pplazo Street', 'Naga', 'Camarines Sur', 4400, 'CARD MRI Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1099, 'Tiongson', 'Samuela', 'Montoya', '1989-03-07', 'F', '09583388855', '107 Enterprise Drv.', 'Bacoor', 'Cavite', 4102, 'Bayani Insurance');
INSERT INTO `diagnosticsdb`.`Patients` (`patient_id`, `last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `street`, `city`, `province`, `zip_code`, `insurance_provider`) VALUES (1100, 'Lee', 'Scarlett Jyra', 'Yulo', '1995-12-04', 'F', '09184274772', '8888 Marian Rd 2', 'Kawit', 'Cavite', 4100, 'AXA Philippines');

COMMIT;


-- -----------------------------------------------------
-- Data for table `diagnosticsdb`.`Appointments`
-- -----------------------------------------------------
START TRANSACTION;
USE `diagnosticsdb`;
INSERT INTO `diagnosticsdb`.`Appointments` (`appointment_id`, `patient_id`, `num_tests`, `order_date`, `scheduled_date`, `test_date`, `status`) VALUES (3001, 1001, 3, '2021-04-23', '2021-04-23', '2021-04-23', 'Completed');

COMMIT;


-- -----------------------------------------------------
-- Data for table `diagnosticsdb`.`Equipment`
-- -----------------------------------------------------
START TRANSACTION;
USE `diagnosticsdb`;
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Hematology Analyzer', 'Hematology Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Glucometer', 'Hematology Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Centrifuge', 'Hematology Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Biochemistry Analyzer', 'Biochemistry Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Urine Analyzer', 'Biochemistry Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Immunoassay Analyzer', 'Biochemistry Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Incubator', 'Microbiology Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Stool Analyzer', 'Microbiology Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Coagulation Analyzer', 'Hematology Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('PCR Analyzer', 'Microbiology Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('X-Ray Machine', 'Imaging Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Ultrasound Machine', 'Imaging Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('CT Scanner', 'Imaging Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('MRI Scanner', 'Imaging Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Electrocardiogram', 'Imaging Lab', 'Functional', NULL, NULL);
INSERT INTO `diagnosticsdb`.`Equipment` (`equip_name`, `location`, `condition`, `maintenance_start`, `maintenance_end`) VALUES ('Blood Pressure Monitor', 'Hematology Lab', 'Functional', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `diagnosticsdb`.`REF_OutcomesTypes`
-- -----------------------------------------------------
START TRANSACTION;
USE `diagnosticsdb`;
INSERT INTO `diagnosticsdb`.`REF_OutcomesTypes` (`outcome_type`) VALUES (1);
INSERT INTO `diagnosticsdb`.`REF_OutcomesTypes` (`outcome_type`) VALUES (2);
INSERT INTO `diagnosticsdb`.`REF_OutcomesTypes` (`outcome_type`) VALUES (3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `diagnosticsdb`.`Tests`
-- -----------------------------------------------------
START TRANSACTION;
USE `diagnosticsdb`;
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CBC', 'Complete Blood Count', 'Hematology Analyzer', 816.00, 7, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('BGT', 'Blood Glucose Test', 'Glucometer', 527.00, 1, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('LP', 'Lipid Profile', 'Centrifuge', 1384.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('LFT', 'Liver Function Test', 'Biochemistry Analyzer', 1007.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('KFT', 'Kidney Function Test', 'Biochemistry Analyzer', 983.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('UA', 'Urinalysis', 'Urine Analyzer', 409.00, 7, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('TFT', 'Thyroid Function Test', 'Biochemistry Analyzer', 1123.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('PT', 'Pregnancy Test', 'Immunoassay Analyzer', 312.00, 30, 2);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('PSA', 'Prostate-Specific Antigen', 'Immunoassay Analyzer', 719.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('EP', 'Electrolyte Panel', 'Biochemistry Analyzer', 871.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('A1C', 'Hemoglobin A1c', 'Hematology Analyzer', 635.00, 90, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('VDT', 'Vitamin D Test', 'Biochemistry Analyzer', 1228.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CRP', 'C-Reactive Protein', 'Immunoassay Analyzer', 679.00, 7, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('BC', 'Blood Culture', 'Incubator', 1573.00, 7, 2);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('RST', 'Rapid Strep Test', 'Immunoassay Analyzer', 403.00, 1, 2);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('ST', 'Stool Test', 'Stool Analyzer', 514.00, 7, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CP', 'Coagulation Profile', 'Coagulation Analyzer', 1023.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('SE', 'Serum Electrolytes', 'Biochemistry Analyzer', 846.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('HIV', 'HIV Test', 'Immunoassay Analyzer', 1023.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('HBsAg', 'Hepatitis B Surface Antigen', 'Immunoassay Analyzer', 813.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('HE', 'Hemoglobin Electrophoresis', 'Hematology Analyzer', 1224.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CL', 'Calcium Level', 'Biochemistry Analyzer', 604.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('ML', 'Magnesium Level', 'Biochemistry Analyzer', 751.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('BNP', 'B-Type Natriuretic Peptide', 'Immunoassay Analyzer', 1340.00, 30, 3);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CR', 'Creatinine Level', 'Biochemistry Analyzer', 589.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('FEL', 'Ferritin Level', 'Biochemistry Analyzer', 834.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('DT', 'D-dimer Test', 'Coagulation Analyzer', 932.00, 7, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('FOL', 'Folate Level', 'Biochemistry Analyzer', 742.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('SA', 'Serum Albumin', 'Biochemistry Analyzer', 1283.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('C19', 'COVID-19 Test', 'PCR Analyzer', 1624.00, 7, 2);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CXR', 'Chest X-Ray', 'X-Ray Machine', 2041.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('AUS', 'Abdominal Ultrasound', 'Ultrasound Machine', 3479.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('ECHO', 'Echocardiogram', 'Ultrasound Machine', 2531.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('RUS', 'Renal Ultrasound', 'Ultrasound Machine', 1894.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('PUS', 'Pelvic Ultrasound', 'Ultrasound Machine', 2116.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('BDT', 'Bone Density Test', 'X-Ray Machine', 1325.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('MMG', 'Mammogram', 'X-Ray Machine', 5078.00, 365, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CTA', 'CT Scan (Abdomen)', 'CT Scanner', 5117.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CTH', 'CT Scan (Head)', 'CT Scanner', 8419.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('MRI', 'Magnetic Resonance Imaging', 'MRI Scanner', 3181.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CD', 'Carotid Doppler', 'Ultrasound Machine', 2093.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('FUS', 'Fetal Ultrasound', 'Ultrasound Machine', 1589.00, 30, 1);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CVD', 'Cardiovascular Disease Test', 'Electrocardiogram', 937.00, 1, 2);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('DKD', 'Diabetic Kidney Disease Test', 'Biochemistry Analyzer', 1516.00, 1, 2);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('CAD', 'Coronary Artery Disease Test', 'Electrocardiogram', 891.00, 1, 2);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('HTN', 'Hypertension Test', 'Blood Pressure Monitor', 352.00, 1, 2);
INSERT INTO `diagnosticsdb`.`Tests` (`test_type`, `test_name`, `equip_name`, `test_cost`, `days_valid`, `outcome_type`) VALUES ('ART', 'Allergic Reaction Test', 'Immunoassay Analyzer', 350.00, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `diagnosticsdb`.`Staff`
-- -----------------------------------------------------
START TRANSACTION;
USE `diagnosticsdb`;
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2001, 'Aquino', 'Joaqin', 'Mercedes', 'Nurse', '09182746622');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2002, 'Bautista', 'Maria Nicole', 'Ogay', 'Technician', '09234567890');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2003, 'Bautista', 'Alexander Joseph', 'Escobar', 'Doctor', '09284616177');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2004, 'Cruz', 'Maria Elena', 'Abogado', 'Billing Clerk', '09456789012');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2005, 'Tan', 'Zandy Yola', 'Faustino', 'Technician', '09567890123');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2006, 'Chua', 'Noah', 'Sy', 'Technician', '09678901234');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2007, 'Fuentebella', 'Santino', 'Parana', 'Doctor', '09789012345');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2008, 'Gamboa', 'Mikaela Xyra', 'Tan', 'Technician', '09890123456');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2009, 'Garcia', 'Rafael Zander', 'Liu', 'Administrator', '09123456780');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2010, 'Yap', 'Allen Ricardo', 'Macapili', 'Billing Clerk', '09234567801');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2011, 'Ilustre', 'Justin Blake', 'Ibanez', 'Nurse', '09345678912');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2012, 'Jambalos', 'Annalyn', 'Sarmiento', 'Nurse', '09456789023');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2013, 'Jimenez', 'Ella Grace', 'Panganiban', 'Administrator', '09567890134');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2014, 'Salazar', 'Florante', 'Alvarado', 'Technician', '09678901245');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2015, 'Kasilag', 'Carlo', 'Bautista', 'Nurse', '09789012356');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2016, 'Llorente', 'Katnis Faith', 'Dizon', 'Nurse', '09890123467');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2017, 'Pua', 'Jazzie', 'Fajardo', 'Receptionist', '09123456701');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2018, 'Meyer', 'Michael Dale', 'Quimpo', 'Nurse', '09234567812');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2019, 'Morales', 'Joseph', 'Escobar', 'Doctor', '09345678923');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2020, 'Noche', 'Nikki', 'Lacuna', 'Doctor', '09456789034');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2021, 'Ocampo', 'Christopher', 'Yap', 'Nurse', '09567890145');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2022, 'Pineda', 'Maricar', 'Natividad', 'Receptionist', '09678901256');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2023, 'Sy', 'Marcus Aurelius', 'Villamin', 'Nurse', '09789012367');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2024, 'Lim', 'Leslie', 'Pascual', 'Technician', '09890123478');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2025, 'Rojas', 'Christian Lee', 'Sison', 'Technician', '09123456702');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2026, 'Santos', 'Avery Joseph', 'Yuchengco', 'Doctor', '09234567813');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2027, 'Sison', 'Mark Paolo', 'Villar', 'Technician', '09345678924');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2028, 'Pineda', 'Julienne Victoria', 'Gokongwei', 'Doctor', '09456789035');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2029, 'Yap', 'Elena Vivienne', 'Velasco', 'Technician', '09567890146');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2030, 'Villanueva', 'Maria Rosella', 'Galante', 'Nurse', '09678901257');
INSERT INTO `diagnosticsdb`.`Staff` (`staff_id`, `first_name`, `last_name`, `middle_name`, `role`, `contact_number`) VALUES (2031, 'Webber', 'Christine Marie', 'Jorvina', 'Receptionist', '09789012368');

COMMIT;


-- -----------------------------------------------------
-- Data for table `diagnosticsdb`.`Results`
-- -----------------------------------------------------
START TRANSACTION;
USE `diagnosticsdb`;
INSERT INTO `diagnosticsdb`.`Results` (`appointment_id`, `test_type`, `staff_id`, `outcome`, `comments`, `status`) VALUES (3001, 'C19', 2014, 'Positive', 'patient already came in with symptoms consistent with COVID-19, including loss of taste and smell', 'Completed');
INSERT INTO `diagnosticsdb`.`Results` (`appointment_id`, `test_type`, `staff_id`, `outcome`, `comments`, `status`) VALUES (3001, 'CBC', 2002, 'Abnormal-Above', NULL, 'Completed');
INSERT INTO `diagnosticsdb`.`Results` (`appointment_id`, `test_type`, `staff_id`, `outcome`, `comments`, `status`) VALUES (3001, 'UA', 2003, 'Normal', NULL, 'Completed');

COMMIT;


-- -----------------------------------------------------
-- Data for table `diagnosticsdb`.`REF_Outcomes`
-- -----------------------------------------------------
START TRANSACTION;
USE `diagnosticsdb`;
INSERT INTO `diagnosticsdb`.`REF_Outcomes` (`outcome`, `outcome_type`) VALUES ('Normal', 1);
INSERT INTO `diagnosticsdb`.`REF_Outcomes` (`outcome`, `outcome_type`) VALUES ('Abnormal (Above Normal)', 1);
INSERT INTO `diagnosticsdb`.`REF_Outcomes` (`outcome`, `outcome_type`) VALUES ('Abnormal (Below Normal)', 1);
INSERT INTO `diagnosticsdb`.`REF_Outcomes` (`outcome`, `outcome_type`) VALUES ('Positive', 2);
INSERT INTO `diagnosticsdb`.`REF_Outcomes` (`outcome`, `outcome_type`) VALUES ('Negative', 2);
INSERT INTO `diagnosticsdb`.`REF_Outcomes` (`outcome`, `outcome_type`) VALUES ('Low Risk', 3);
INSERT INTO `diagnosticsdb`.`REF_Outcomes` (`outcome`, `outcome_type`) VALUES ('Moderate Risk', 3);
INSERT INTO `diagnosticsdb`.`REF_Outcomes` (`outcome`, `outcome_type`) VALUES ('High Risk', 3);

COMMIT;


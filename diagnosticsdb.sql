-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema diagnosticsdb
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `diagnosticsdb` DEFAULT CHARACTER SET utf8mb4 ;
USE `diagnosticsdb` ;

-- -----------------------------------------------------
-- Table `Patients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Patients`;
CREATE TABLE `Patients` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(20) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(20) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `contact_number` VARCHAR(13) NOT NULL,
  `insurance_provider` VARCHAR(45) NOT NULL DEFAULT '',
  `insurance_pct` FLOAT NOT NULL DEFAULT 0.0,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `zip_code` SMALLINT NOT NULL,
  PRIMARY KEY (`patient_id`),
  CONSTRAINT `chk_contact_number` 
	CHECK (`contact_number` 
    REGEXP '^09[0-9]{9}$') -- follow 09123456789 format
) ENGINE = InnoDB AUTO_INCREMENT = 1001;

-- -----------------------------------------------------
-- Data for table `Patients`
-- -----------------------------------------------------
LOCK TABLES `Patients` WRITE;
INSERT INTO `Patients` (`last_name`, `first_name`, `middle_name`, `date_of_birth`, `gender`, `contact_number`, `insurance_provider`, `insurance_pct`, `street`, `city`, `province`, `zip_code`)
VALUES 
('Go', 'Rhea Joy', 'Cabuyao', '2001-10-05', 'F', '09123456789', 'Philam Life', 0.34, '2252 Pasong Tamo', 'Makati City', 'Metro Manila', 1200),
('Dela Torre', 'Lucas', 'Garcia', '1990-02-17', 'M', '09272345678', '', 0, 'lot 2 block 4 Bartalome', 'Binan', 'Laguna', 4024), 
('Quigley', 'Mason', 'Galvez', '1995-08-23', 'M', '09286543210', 'Sun Life ', 0.29, '261 Baltazar St', 'Caloocan City', 'Metro Manila', 1123), 
('Lacson', 'Faye Anne', 'Mamaril', '1999-12-12', 'F', '09152345678', '', 0, '618 6th Avenue', 'Caloocan City', 'Metro Manila', 1400),
('Enriquez', 'Jessa', 'Wenceslao', '1992-03-30', 'F', '09187654321', 'Manulife ', 0.1, '166 General Luna Street', 'Caloocan City', 'Metro Manila', 1408), 
('Radcliffe', 'Nia', 'Felix', '1998-04-15', 'F', '09175462431', 'AXA Philippines', 0.3, '170 F. Roxas Street', 'Caloocan City', 'Metro Manila', 1420), 
('Garcia', 'Julyan Faith', 'De Luna', '1983-11-09', 'F', '09323451678', 'CARD MRI Insurance', 0.16, '163 M. Bartolome St.', 'Caloocan City', 'Metro Manila', 1400), 
('Ramos', 'Dan', 'Morillo', '1986-01-06', 'M', '09293761981', 'CARD MRI Insurance', 0.28, '810 McArthur Road', 'Caloocan City', 'Metro Manila', 1400), 
('Morales', 'Louie', 'Ylagan', '1991-07-14', 'M', '09167890123', 'CARD MRI Insurance', 0.16, '166 M.L. Quezon Street', 'Antipolo City', 'Rizal', 1870), 
('Fabella', 'Faye', 'Danao', '1994-09-11', 'F', '09081234567', 'Bayani Seguro', 0.35, '305 Wayan Boni Avenue', 'Iloilo City', 'Iloilo', 5000), 
('Gamalinda', 'Joy', 'Osorio', '1996-05-17', 'F', '09186543210', '', 0, '305 Wayan Boni Avenue', 'Iloilo City', 'Iloilo', 5000), 
('Jimenez', 'Leah', 'Sumagaysay', '1990-06-22', 'F', '09338765432', '', 0, 'b2 lot 3 2nd St.', 'Bacoor', 'Cavite', 4102), 
('Castillo', 'Vince', 'Waling', '1980-12-03', 'M', '09456782345', 'Philam Life', 0.22, 'b2 lot 3 2nd St.', 'Bacoor', 'Cavite', 4102), 
('Abad', 'Aris', 'Zamora', '1994-11-21', 'M', '09378901234', 'Sun Life ', 0.29, 'b2 lot 3 2nd St.', 'Bacoor', 'Cavite', 4102), 
('De Guzman', 'Alex', 'Rigor', '1998-06-04', 'F', '09065439876', 'Manulife ', 0.18, '12 San Jose Street', 'Ligao', 'Albay', 4504), 
('Catubay', 'Nina', 'Kasilag', '1992-10-25', 'F', '09147654321', '', 0, 'B12 L7 Kaliraya Rd', 'Quezon City', 'Metro Manila', 1103), 
('Torres', 'Rita', 'Velez', '1987-02-11', 'F', '09182345678', 'BPI Life Insurance', 0.23, 'B3 L2 Visita Altares Pasong Putik', 'Quezon City', 'Metro Manila', 1118), 
('Santos', 'Sheryl', 'Gamboa', '1993-08-18', 'F', '09248765432', 'FWD Life Insurance', 0.19, 'B3 L2 Visita Altares Pasong Putik', 'Quezon City', 'Metro Manila', 1118), 
('Quimpo', 'John Paul', 'Jugueta', '1989-01-25', 'M', '09172345678', 'Manulife ', 0.3, '503-D St. Agnes', 'Las Pinas', 'Metro Manila', 1740), 
('Aquino', 'Daryl', 'Kanto', '1991-12-10', 'M', '09293234321', '', 0, 'M Alvarez Avenue', 'Las Pinas', 'Metro Manila', 1740), 
('Aquino', 'Max', 'Unas', '1995-05-05', 'M', '09293234321', 'BPI Life Insurance', 0.43, '2406 J A Santos Avenue', 'Silang', 'Cavite', 4118), 
('Torres', 'Gigi', 'Yumul', '1985-07-28', 'F', '09328901234', '', 0, '222 Diversion Road', 'Lucena City', 'Quezon', 4301), 
('Fajardo', 'Ella Mae', 'Wenceslao', '1993-01-03', 'F', '09345678901', 'FWD Life Insurance', 0.5, '301b Aguirre Building', 'Makati City', 'Metro Manila', 1201), 
('Mendoza', 'Tessa', 'Abad', '1999-11-26', 'F', '09032456789', 'AXA Philippines', 0.25, '6F Zeta Building 191 Salcedo Street', 'Makati City', 'Metro Manila', 1200), 
('Nolasco', 'Jessa Mae', 'Candido', '2004-09-14', 'F', '09223456789', 'BPI Life Insurance', 0.43, 'Prince Tower 80 M. Cornejo Street', 'Pasay City', 'Metro Manila', 1300), 
('Ocampo', 'Maria Clara', 'Alayon', '1988-04-12', 'F', '09211234567', 'Lunas Insurance', 0.45, 'Sakap Building, 121 Sacred Heart Street', 'Makati City', 'Metro Manila', 1210), 
('Estrella', 'Anna', 'Ubial', '1997-02-01', 'F', '09287654321', 'Philam Life', 0.22, '2210 Chino Roces Avenue', 'Makati City', 'Metro Manila', 1209), 
('Bautista', 'Jose', 'Inocencio', '1992-07-19', 'M', '09347654321', 'Manulife ', 0.18, '11-6 Rainbow Drive', 'Makati City', 'Metro Manila', 1200), 
('Quimpo', 'Zia', 'Delacruz', '1990-11-10', 'F', '09152345678', 'AXA Philippines', 0.3, '8061 Estrella Avenue', 'Makati City', 'Metro Manila', 1210), 
('White', 'Cora', 'Ubaldo', '1997-08-30', 'F', '09407654321', '', 0, '13-F Perea Street', 'Makati City', 'Metro Manila', 1200), 
('Reyes', 'Edwin', 'Feliciano', '1994-02-22', 'M', '09025678901', 'BPI Life Insurance', 0.43, '1145-A M. Ocampo Street', 'Cavite City', 'Cavite', 4100), 
('Ramos', 'Jojo', 'Galang', '1998-03-08', 'M', '09134567890', 'FWD Life Insurance', 0.34, '03337 Borromeo Street', 'Surigao City', 'Surigao del Norte', 8400), 
('Jambalos', 'Rina', 'Nihil', '1985-09-04', 'F', '09078765432', 'Lunas Insurance', 0.5, '48 D. Tuazon Street ', 'Quezon City', 'Metro Manila', 1100), 
('Morales', 'Mia', 'Urbano', '1982-12-25', 'M', '09219287543', 'AXA Philippines', 0.25, 'Comembo Street, 81', 'Makati City', 'Metro Manila', 1200), 
('Galvez', 'Lito', 'Deniega', '1999-06-14', 'M', '09176432165', '', 0, '2275 Chino Roces St.', 'Makati City', 'Metro Manila', 1231), 
('Sinclair', 'Ted', 'Villamor', '1983-07-29', 'M', '09112452342', 'Bayani Seguro', 0.5, 'Unit3-F Teresa Apartment ', 'Makati City', 'Metro Manila', 1200), 
('Reyes', 'Trixie Mae', 'Fuentebella', '1996-10-11', 'F', '09176543210', '', 0, 'Mercantile Insurance Building', 'Manila', 'Metro Manila', 1000), 
('Bautista', 'Ben', 'Regino', '1990-05-01', 'M', '09136548578', '', 0, '1511 Cityland PT Towers', 'Makati City', 'Metro Manila', 1200), 
('Magsino', 'Kim', 'Bicolano', '1981-10-19', 'F', '09278201347', 'Sun Life ', 0.29, 'UNIT 9-A 9/F Country Bldg. Forte Ave.', 'Makati City', 'Metro Manila', 1200), 
('Santos', 'Marco', 'Ureta', '1993-01-25', 'M', '09121356789', 'Sun Life ', 0.29, '23B JCS St', 'Makati City', 'Metro Manila', 1200), 
('Pineda', 'Gary', 'Natividad', '1984-04-08', 'M', '09056782345', '', 0, '559 J. Luna Street', 'Mandaluyong City', 'Metro Manila', 1551), 
('Panganiban', 'Lisa Marie', 'Malanday', '1998-07-21', 'F', '09223456789', 'Pru Life UK', 0.31, '4B Quinta St', 'Manila', 'Metro Manila', 1012), 
('Sarmiento', 'Juan Carlos', 'Dizon', '2013-07-23', 'M', '09186541234', '', 0, '936 Espeleta Street Sta. Cruz ', 'Manila', 'Metro Manila', 1018), 
('Villanueva', 'Renz', 'Xaver', '1999-09-28', 'M', '09065432345', 'Sun Life ', 0.29, 'Mercantile Insurance Building', 'Manila', 'Metro Manila', 1000), 
('Yu', 'Rami Joseph', 'Gregorio', '1991-04-13', 'M', '09054323445', '', 0, '5F McKinley Street', 'Roxas City', 'Capiz', 5800), 
('Ogihara', 'Miguel', 'Batalion', '1987-06-23', 'M', '09378901234', 'Manulife ', 0.1, '23-A Acacia Street', 'Quezon City', 'Metro Manila', 1101), 
('Gatchalian', 'Liza Mae', 'Miralles', '1996-08-09', 'F', '09265439876', 'CARD MRI Insurance', 0.28, '24C Tomas Mapua St.', 'Manila', 'Metro Manila', 1000), 
('Cruz', 'Zane Anthony', 'Nunes', '2004-12-17', 'M', '09087654321', 'Manulife ', 0.18, '56 Sabayle Street', 'Silang', 'Cavite', 4118), 
('Dela Cruz', 'Carla', 'Castillo', '1992-09-02', 'F', '09345678901', 'Philam Life', 0.22, 'Rm. 206 Plaza Towers, Ermita Street', 'Manila', 'Metro Manila', 1000), 
('Bulaon', 'Jace Paul', 'Pagdanganan', '1995-06-27', 'M', '09032456789', 'BPI Life Insurance', 0.23, '16B Bonifacio Rd.', 'Angeles City', 'Pampanga', 2009), 
('Shi', 'Carl', 'Albano', '1999-02-19', 'M', '09265439876', 'FWD Life Insurance', 0.5, 'F. Cabahug Street, Mabolo', 'Cebu City', 'Cebu', 6000), 
('Rigor', 'David John', 'Tria', '1980-11-11', 'M', '09211234567', 'Sun Life ', 0.29, 'L13 B20 Binondo', 'Manila', 'Metro Manila', 1009), 
('Jimenez', 'Niko', 'Wagas', '1998-10-05', 'M', '09198765432', 'Philam Life', 0.22, 'Rm 306 3/F Mercantile Insurance Bldg.', 'Manila', 'Metro Manila', 1000), 
('Bautista', 'Ethan', 'Obispo', '1997-09-12', 'M', '09211234567', 'Philam Life', 0.22, '1 San Pedro', 'Magalang', 'Pampanga', 2011), 
('Magsino', 'Chet', 'Sison', '1994-07-28', 'M', '09297654321', 'Sun Life ', 0.29, '1904 J Zamora St.', 'Manila', 'Metro Manila', 1001), 
('Dela Cruz', 'Nicole', 'Yabut', '1993-03-01', 'F', '09123456789', 'Lunas Insurance', 0.5, '517 Roxas Boulevard', 'Manila', 'Metro Manila', 1015), 
('Reyes', 'Chris', 'Delos Santos', '1989-05-24', 'M', '09276543210', '', 0, 'Mercantile Insurance Building', 'Manila', 'Metro Manila', 1000), 
('Ramos', 'Tanya', 'Rosales', '1985-01-18', 'F', '09224567643', '', 0, 'Unit 17/18 Juana Osmena St.', 'Cebu City', 'Cebu', 6000), 
('Jimenez', 'Paul', 'Ho', '1997-11-13', 'M', '09023456789', '', 0, '713 R. Hidalgo Street, Quiapo', 'Manila', 'Metro Manila', 1000), 
('Santos', 'Mae', 'Vistal', '1999-04-25', 'F', '09347890123', 'Manulife ', 0.3, '428 El Grande Avenue', 'Paranaque City', 'Metro Manila', 1700), 
('Morales', 'Liam', 'Gaya', '1991-03-22', 'M', '09323876231', 'FWD Life Insurance', 0.19, '32 Rosario Street', 'Legaspi', 'Albay', 4500), 
('Taylor', 'Peter', 'Alcaraz', '1980-08-17', 'M', '09128395678', 'Lunas Insurance', 0.33, '2034 S Reyes', 'Manila', 'Metro Manila', 1000), 
('Ibay', 'Jay', 'Sison', '1984-06-06', 'M', '09342930133', 'Bayani Seguro', 0.35, 'Ermita', 'Manila', 'Metro Manila', 1000), 
('Villanueva', 'Ava', 'Noche', '1996-12-31', 'F', '09245398776', 'CARD MRI Insurance', 0.16, '#06 Don Julio Llorente Street', 'Cebu City', 'Cebu', 6000), 
('Anderson', 'Noah', 'Bantilan', '1986-11-04', 'M', '09354230678', 'Sun Life ', 0.29, '1118 J. Luna Street, Tondo', 'Manila', 'Metro Manila', 1000), 
('Jackson', 'Ethan', 'Go', '1995-07-14', 'M', '09087634567', '', 0, 'Quintin Paredes', 'Manila', 'Metro Manila', 1000), 
('Dela Cruz', 'Harper', 'Jacinto', '1992-11-27', 'F', '09182376123', '', 0, '23 Malabang', 'Manila', 'Metro Manila', 1015), 
('Cruz', 'Ray', 'Cavite', '2003-02-02', 'M', '09218765432', 'Manulife ', 0.1, '56 Sabayle Street', 'Silang', 'Cavite', 4118), 
('Cruz', 'Fred', 'Silos', '1987-08-20', 'M', '09156273499', 'Manulife ', 0.3, '56 Sabayle Street', 'Silang', 'Cavite', 4118), 
('Hontiveros', 'Henry', 'Tadeo', '1994-04-04', 'M', '09176543123', 'BPI Life Insurance', 0.43, 'Marasigan Street', 'Calaca', 'Batangas', 4212), 
('Salcedo', 'Ralph', 'Co', '1980-03-21', 'M', '09326432513', 'FWD Life Insurance', 0.5, '14E McArthur St', 'Marilao', 'Bulacan', 3019), 
('Garcia', 'Arnold', 'Inocencio', '1999-01-02', 'M', '09198765430', 'Lunas Insurance', 0.5, '100 Scout Ojeda St.', 'Sampaloc', 'Quezon', 4329), 
('Villalobos', 'Grace Ann', 'Duenas', '1993-06-15', 'F', '09351762563', 'AXA Philippines', 0.3, '1922 J.A. Santos Avenue', 'Manila', 'Metro Manila', 1000), 
('Dela Cruz', 'Leo', 'Felipe', '1983-09-07', 'M', '09123456234', 'FWD Life Insurance', 0.34, 'Block 18 Lot 8 Valencia', 'Bacoor', 'Cavite', 4102), 
('Torres', 'Rhea Joy', 'Galvez', '1996-10-23', 'F', '09231582374', 'Lunas Insurance', 0.33, 'Bubog, San Jose', 'Silang', 'Cavite', 4118), 
('Ramos', 'Christine', 'Nituda', '1997-12-01', 'F', '09238951767', '', 0, '854 Tabora Street ', 'Silang', 'Cavite', 4118), 
('Quinto', 'Bea', 'Jara', '1990-10-06', 'F', '09123457891', '', 0, 'Units 3,4 & 5, Sycamore Arcade', 'Muntinlupa City', 'Metro Manila', 1770), 
('Prescott', 'Mark Anthony', 'Fernandez', '1999-07-31', 'M', '09329834556', '', 0, 'Insular Village', 'Bansalan', 'Davao del Sur', 8005), 
('Torres', 'Mia', 'Shi', '1981-05-08', 'F', '09124657932', '', 0, '51-B Del Monte Avenue ', 'Quezon City', 'Metro Manila', 1100), 
('Javelosa', 'Rick', 'Panganiban', '1992-08-27', 'M', '09298765432', 'Lunas Insurance', 0.33, '976 M Naval', 'Navotas', 'Metro Manila', 1400), 
('Kasilag', 'Kiko', 'Yu', '1982-01-01', 'M', '09376543210', 'Pru Life UK', 0.31, 'Unit 10, Carfel Bldg., Aguirre St.', 'Paranaque City', 'Metro Manila', 1700), 
('Mendoza', 'Joy', 'Bantay', '1995-09-09', 'F', '09175779187', 'Manulife ', 0.18, 'U-11-18 Meralco Avenue', 'Pasig City', 'Metro Manila', 1604), 
('Castillo', 'Ellaine', 'Mabilog', '1988-07-13', 'F', '09183545123', '', 0, '890-A Eusebio Avenue', 'Pasig City', 'Metro Manila', 1600), 
('Aquino', 'Roy', 'Quinto', '1990-04-04', 'M', '09120345366', 'Manulife ', 0.1, '2406 J A Santos Avenue', 'Silang', 'Cavite', 4118), 
('Ilagan', 'Ana Marie', 'Tagle', '1997-05-25', 'F', '09298765432', 'Philam Life', 0.22, '34 Morato Street', 'Quezon City', 'Metro Manila', 1100), 
('Lopez', 'Daryl John', 'Egina', '1991-01-15', 'M', '09308765432', 'Bayani Seguro', 0.5, '12 Baesa St.', 'Quezon City', 'Metro Manila', 1106), 
('Villanueva', 'Mark Anthony', 'Ibarra', '1994-12-07', 'M', '09218765432', 'CARD MRI Insurance', 0.16, '#06 Don Julio Llorente Street', 'Cebu City', 'Cebu', 6000), 
('Macandog', 'Joni', 'Cruz', '1983-03-19', 'M', '09123456789', 'Manulife ', 0.18, '745 Aurora Boulevard ', 'Quezon City', 'Metro Manila', 1112), 
('Castillo', 'Ryan', 'Ciriaco', '1981-09-30', 'M', '09257641276', 'Bayani Seguro', 0.35, '6C North Avenue', 'Quezon City', 'Metro Manila', 1100), 
('Yu', 'Vicky', 'Guinto', '1995-02-14', 'F', '09172348766', 'Lunas Insurance', 0.33, '1295 Gen Araneta Avenue', 'Quezon City', 'Metro Manila', 1100), 
('Cruz', 'Liza Mae', 'Nepomuceno', '1998-05-16', 'F', '09224567291', 'Manulife ', 0.3, '56 Sabayle Street', 'Silang', 'Cavite', 4118), 
('Castillo', 'Zoe', 'Madrid', '1987-01-30', 'F', '09257641276', 'Bayani Seguro', 0.5, '6C North Avenue', 'Quezon City', 'Metro Manila', 1100), 
('Thorne', 'Juno', 'Altamirano', '1991-06-29', 'F', '09378945691', 'CARD MRI Insurance', 0.28, '78 Marang Street Project 2', 'Quezon City', 'Metro Manila', 1100), 
('Lontoc', 'Belle', 'Dela Cruz', '1993-02-09', 'F', '09023456781', '', 0, '162 Aurora Boulevard', 'San Juan', 'Metro Manila', 1500), 
('Ching', 'Pio Andrew', 'Mendoza', '1983-12-27', 'M', '09412345678', 'Pru Life UK', 0.31, '13 Bonifacio Street', 'Valenzuela', 'Metro Manila', 1440), 
('Lopez', 'Vince', 'Quijano', '1999-06-03', 'M', '09031567410', 'Bayani Seguro', 0.35, '5082 Darlucio Street', 'Valenzuela', 'Metro Manila', 1447), 
('Garcia', 'Eric', 'Felicidad', '1992-04-24', 'M', '09237452021', 'Manulife ', 0.18, '12 Gapuz Zig-Zag Road', 'Imus', 'Cavite', 4103), 
('Lee', 'Kira', 'Guardiano', '1994-10-17', 'F', '09187456790', 'CARD MRI Insurance', 0.28, 'L3 B18 Felix Pplazo Street', 'Naga', 'Camarines Sur', 4400), 
('Tiongson', 'Sam', 'Montoya', '1989-03-07', 'F', '09238177589', 'Bayani Seguro', 0.5, '107 Enterprise Drv.', 'Bacoor', 'Cavite', 4102), 
('Lee', 'Scarlett', 'Yulo', '1995-12-04', 'F', '09368452030', 'AXA Philippines', 0.25, '8888 Marian Rd 2', 'Kawit', 'Cavite', 4100);
UNLOCK TABLES;

-- -----------------------------------------------------
-- Table `Appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Appointments` (
  `appointment_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `num_tests` INT NOT NULL COMMENT 'number of tests ordered for this appointment',
  `order_date` DATETIME NOT NULL,
  `scheduled_date` DATETIME NOT NULL,
  `test_date` DATETIME NOT NULL,
  `status` ENUM('Scheduled', 'Rescheduled', 'In-Progress', 'Pending Payment', 'Completed', 'Follow-Up Required', 'Cancelled') NOT NULL,
  PRIMARY KEY (`appointment_id`),
  CONSTRAINT `patient_id`
    FOREIGN KEY (`patient_id`)
    REFERENCES `diagnosticsdb`.`Patients` (`patient_id`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Equipment` (
  `equipment_id` VARCHAR(5) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(25) NOT NULL,
  `status` ENUM('Available', 'Under Maintenance', 'Retired') NOT NULL,
  `condition` VARCHAR(15) NOT NULL,
  `maintenance_start` DATETIME NULL DEFAULT NULL,
  `maintenance_end` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`equipment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Tests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Tests` (
  `test_type` VARCHAR(5) NOT NULL,
  `equipment_id` VARCHAR(5) NOT NULL,
  `test_name` VARCHAR(45) NOT NULL,
  `staff_required` VARCHAR(45) NOT NULL,
  `test_cost` DECIMAL(5,2) NOT NULL,
  `days_valid` INT NOT NULL,
  PRIMARY KEY (`test_type`),
  CONSTRAINT `equipment_id`
    FOREIGN KEY (`equipment_id`)
    REFERENCES `diagnosticsdb`.`Equipment` (`equipment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Staff` (
  `staff_id` INT NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `middle_name` VARCHAR(20) NOT NULL,
  `role` VARCHAR(25) NOT NULL,
  `contact_number` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Payment` (
  `payment_id` INT NOT NULL,
  `appointment_id` INT NOT NULL,
  `total_cost` DECIMAL(10,2) NOT NULL,
  `payment_method` VARCHAR(25) NOT NULL,
  `payment_date` DATETIME NOT NULL DEFAULT '9999-01-01 00:00:00',
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `order_id`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `diagnosticsdb`.`Appointments` (`appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diagnosticsdb`.`Results`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diagnosticsdb`.`Results` (
  `result_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  `appointment_id` INT NOT NULL,
  `test_type` VARCHAR(5) NOT NULL,
  `results` ENUM('Normal', 'Abnormal', 'Positive', 'Negative', 'Below Normal', 'Within Normal', 'Above Normal', 'Low Risk', 'Moderate Risk', 'High Risk', 'Invalid') NULL DEFAULT NULL COMMENT 'null if pending or cancelled',
  `comments` TEXT NULL DEFAULT NULL,
  `status` ENUM('Completed', 'Pending', 'Cancelled') NOT NULL,
  PRIMARY KEY (`result_id`),
  CONSTRAINT `fk_Results_Appointments2`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `diagnosticsdb`.`Appointments` (`appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Results_Staff2`
    FOREIGN KEY (`staff_id`)
    REFERENCES `diagnosticsdb`.`Staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Results_Tests2`
    FOREIGN KEY (`test_type`)
    REFERENCES `diagnosticsdb`.`Tests` (`test_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



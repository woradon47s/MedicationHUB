-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 10, 2023 at 07:53 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medicationhub2`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointmentId` int(10) NOT NULL,
  `patientId` int(10) DEFAULT NULL,
  `doctorId` int(10) DEFAULT NULL,
  `departmentName` varchar(250) DEFAULT NULL,
  `hospitalName` varchar(250) DEFAULT NULL,
  `appointmentDate` varchar(250) DEFAULT NULL,
  `appointmentTime` varchar(50) DEFAULT NULL,
  `appointmentStatus` varchar(250) NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointmentId`, `patientId`, `doctorId`, `departmentName`, `hospitalName`, `appointmentDate`, `appointmentTime`, `appointmentStatus`) VALUES
(1, 1, 2, 'Check-Up', 'Bangmod Hospital', '15 December 2023', '11:30 AM', 'Success'),
(2, 1, 2, 'Check-Up', 'Bangmod Hospital', '31 December 2023', '09:00 AM', 'Pending'),
(3, 3, 6, 'Eye', 'Bangmod Hospital', '20 December 2023', '11:00 AM', 'Pending'),
(4, 5, 2, 'Check-Up', 'Bangmod Hospital', '15 December 2023', '02:00 PM', 'Success'),
(5, 3, 2, 'Check-Up', 'Bangmod Hospital', '20 December 2023', '10:00 AM', 'Pending'),
(6, 5, 2, 'Check-Up', 'Bangmod Hospital', '22 December 2023', '01:30 PM', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `departmentName` varchar(250) NOT NULL,
  `hospitalName` varchar(250) DEFAULT NULL,
  `departmentPicture` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`departmentName`, `hospitalName`, `departmentPicture`) VALUES
('Cancer', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171769871651045396/image.png?ex=655de2bb&is=654b6dbb&hm=ec5feb9558cb1728cf6bf3342a3ced8dd17ab0f419f4b3a2ba5e11e47ed17100&'),
('Cardiology', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171770035048562688/image.png?ex=655de2e2&is=654b6de2&hm=5d776b75e9f628be1fef4aa0d1fff74f236a9edfc656ba20db406d943e5b868b&'),
('Check-Up', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171769869650366495/image.png?ex=655de2bb&is=654b6dbb&hm=0ca1c631c6bc704b625d949235b3db8b076f8a857798ab56d663dc18824dce9e&'),
('Children', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171769869021220924/image.png?ex=655de2bb&is=654b6dbb&hm=15b634c61d28ac62899ddf585d5b48494d55fb5d60b4f0f868524203697500c8&'),
('Emergency', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171769869381926982/image.png?ex=655de2bb&is=654b6dbb&hm=86ebe0564d54b0068b155dcf8bf10d010ed78c14919a73a150a466950527eea2&'),
('Eye', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171769871118377000/image.png?ex=655de2bb&is=654b6dbb&hm=6db0e9c9633ab1c74435b7e6a04b37b09b39a62a9e88d2b44ae38532579f0f9c&'),
('Internal Medicine', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171769869897826395/image.png?ex=655de2bb&is=654b6dbb&hm=3af302a2831ceba3e6cb2d035f89c8ab0bc44f0a8ab8454267cc06cbed425b42&'),
('Kidney', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171770034608148550/image.png?ex=655de2e2&is=654b6de2&hm=2ad6321195b2b1fd314eb2c03e52721f19943b517dde06f5fb954149a5c15073&'),
('Orthopedic', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171769870245961829/image.png?ex=655de2bb&is=654b6dbb&hm=6cfbdb376abc4ca0bb3dae49207fd72306e9433a9922c900c6e9db10634cca55&'),
('Surgery', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171769870577307649/image.png?ex=655de2bb&is=654b6dbb&hm=25835932403cb91fc617886ec337dc3aa4f582d5dfdbce082fd2d5265bd74b1b&'),
('Women', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171769871391002634/image.png?ex=655de2bb&is=654b6dbb&hm=3bd5664b910fb1eea6a5faa5a5a2457238c0258dc9a5f1d75f2556bbec3ffc2f&'),
('X-Ray', 'Suksawat Inter Hospital', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171769870875099226/image.png?ex=655de2bb&is=654b6dbb&hm=f7d5a1cea431ff6431192ccd9c79f64707cfb9315ac066c94fb94d47df54c5cc&');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `doctorId` int(10) NOT NULL,
  `doctorName` varchar(100) DEFAULT NULL,
  `doctorEmail` varchar(250) DEFAULT NULL,
  `doctorPassword` varchar(250) DEFAULT NULL,
  `departmentName` varchar(250) DEFAULT NULL,
  `doctorRating` decimal(10,1) DEFAULT NULL,
  `doctorAbout` varchar(250) NOT NULL,
  `doctorPicture` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`doctorId`, `doctorName`, `doctorEmail`, `doctorPassword`, `departmentName`, `doctorRating`, `doctorAbout`, `doctorPicture`) VALUES
(1, 'Dr. Pang Pond', 'Pangpong99@gmail.com', 'pp9999', 'Cancer', 5.0, 'Orthopedics, also known as orthopedic surgery, is a branch of medicine that focuses on the care of the skeletal system and its interconnecting parts. These parts include the following: bones. muscles. joints.', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171768180805480448/image.png?ex=655de128&is=654b6c28&hm=87f04b65b56885b3a9e87ab5ff25fa5c0d47dddb906404469c8da2d39ac79205&'),
(2, 'Dr. Claire Browne', 'Claire123@hotmail.com', 'C123456', 'Cancer', 4.6, 'Orthopedics, also known as orthopedic surgery, is a branch of medicine that focuses on the care of the skeletal system and its interconnecting parts. These parts include the following: bones. muscles. joints.', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171768180486709278/image.png?ex=655de128&is=654b6c28&hm=ecf9291ba5b705423bb7db29be4fabb65f63c93e4a7057b888d9414936da871a&'),
(3, 'Dr. Aaron Glassman', 'Aaron8888@gmail.com', 'AR8888', 'Cancer', 4.2, 'Orthopedics, also known as orthopedic surgery, is a branch of medicine that focuses on the care of the skeletal system and its interconnecting parts. These parts include the following: bones. muscles. joints.', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171768179916288080/image.png?ex=655de128&is=654b6c28&hm=2d6c8765b66327152cbca9b4dee89a9d989fad74d1517bad2c2da29b774009e8&'),
(4, 'Dr. Morgan Reznick', 'Mor_rez@gmail.com', 'Mor123', 'Cancer', 4.7, 'Orthopedics, also known as orthopedic surgery, is a branch of medicine that focuses on the care of the skeletal system and its interconnecting parts. These parts include the following: bones. muscles. joints.', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171768179626876978/image.png?ex=655de128&is=654b6c28&hm=afaea4dfce974655bbbb50a269475a7deb646c357302da4bbdb3a3efc55f72b9&'),
(5, 'Dr. Shaun Murphy', 'Shaun.mur@hotmail.com', 'Shaun123', 'Cancer', 4.1, 'Orthopedics, also known as orthopedic surgery, is a branch of medicine that focuses on the care of the skeletal system and its interconnecting parts. These parts include the following: bones. muscles. joints.', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171768179291340820/image.png?ex=655de128&is=654b6c28&hm=94c4439791ab0c3ad087458b8eea6c2f889c158d2dfdeb7b98559c7d74464e17&'),
(6, 'Dr. Alex Park', 'Alex2345@gmail.com', 'A6666', 'Cancer', 4.6, 'Orthopedics, also known as orthopedic surgery, is a branch of medicine that focuses on the care of the skeletal system and its interconnecting parts. These parts include the following: bones. muscles. joints.', 'https://cdn.discordapp.com/attachments/1171768174195261480/1171768180172144671/image.png?ex=655de128&is=654b6c28&hm=580752cdb6057080781120c1b00064d5b7942ef86adc593981304184e8ded7ec&');

-- --------------------------------------------------------

--
-- Table structure for table `hospital`
--

CREATE TABLE `hospital` (
  `hospitalName` varchar(250) NOT NULL,
  `hospitalRating` decimal(10,1) DEFAULT NULL,
  `hospitalReview` int(100) DEFAULT NULL,
  `hospitalAddress` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hospital`
--

INSERT INTO `hospital` (`hospitalName`, `hospitalRating`, `hospitalReview`, `hospitalAddress`) VALUES
('Bangmod Hospital', 3.9, 607, '747 ถ. พระราม ๒ Bang Mot, Chom Thong'),
('Bangna Hospital Medical Office', 4.0, 3, '548 ถ. ทางรถไฟสายเก่าปากน้ำ Bang Na Nuea, Bang Na'),
('Bangpakok 1 Hospital', 3.6, 157, '2 Suk Sawat 25/1 Alley, Bang Pakok, Rat Burana'),
('Bangpakok 3 Hospital', 2.4, 210, '27/14 หมู่ที่ 10 Suk Sawat Rd, Lat Luang, Phra Pradaeng District'),
('Bangpakok 9 International Hospital', 4.5, 777, '362 Rama II Rd, Bang Mot, Chom Thong'),
('Bangpakok Samut Prakan Hospital', 3.3, 79, 'เลขที่ 99 หมู่ที่ 7, Suk Sawat Rd, Lat Luang, Phra Pradaeng District'),
('Bijou Hospital', 0.0, 0, '1 1 ซอย สุขสวัสดิ์ Bang Pakok, Rat Burana'),
('IMH Thonburi hospital', 2.8, 287, '146 Suk Sawat Rd, Bang Pakok, Rat Burana'),
('Muang Samut Poo Chao Hospital', 2.3, 156, '83 16 หมู่7 Phuchao Saming Phray, Samrong Klang, Phra Pradaeng District'),
('Paolo Hospital Phra Pradaeng', 3.1, 148, '288 หมู่ที่ 1 Suk Sawat Rd, Pak Khlong Bang Pla Kot, Phra Samut Chedi District'),
('Phra Chulachomklao Fort Hospital', 3.8, 5, 'GHRF+H85, Laem Fa Pha, Phra Samut Chedi District'),
('Phra Samut Chedi Hospital', 2.5, 88, '172 Suk Sawat Rd, Pak Khlong Bang Pla Kot, Phra Samut Chedi District'),
('PRARAM 3 NURSING HOME', 0.0, 0, 'Bangkok, 1817/117-118 Soi Sathupradit 57 sub soi 19 Pra-Ram3 Rd. Soi41 Bangpongpang Sub district'),
('Raj Burana Hospital', 2.3, 246, '377 Soi Suk Sawat 27, Bang Pakok, Rat Burana'),
('Samrong Medical Hospital', 3.0, 243, 'เลขที่ 1748 ซอย สุขุมวิท 78 Sukhumvit Road, Samrong Nuea, Mueang Samut Prakan District'),
('Sirichai Hospital', 4.0, 1, 'Bang Khunthianrd., Bang Bon, Bang Bon, Bangkok, 10150'),
('Suksawat Inter Hospital', 3.2, 234, '272 Suk Sawat Rd, Bang Pakok, Rat Burana'),
('ร.พ.ทหารเรือ กรุงเทพฯ', 4.4, 5, 'อยู่ในรพ ทหารเรือสรรพวุธ, 224 ถนน ทางรถไฟสายเก่า Bang Na Tai, Bang Na'),
('สำนักงานชันสูตรสาธารณสุข สำนักอนามัย กทม', 0.0, 0, '888 Sanphawut Rd, Bang Na Nuea, Bang Na'),
('โรงพยาบาลวิภาราม สมุทรปราการ', 3.6, 36, '555 หมู่ 3 Phuchao Saming Phray, สำโรงกลาง Phra Pradaeng District');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patientId` int(10) NOT NULL,
  `patientEmail` varchar(50) DEFAULT NULL,
  `patientPassword` varchar(50) DEFAULT NULL,
  `patientFirstname` varchar(50) DEFAULT NULL,
  `patientLastname` varchar(50) DEFAULT NULL,
  `patientCitizenId` varchar(20) DEFAULT NULL,
  `patientAddress` varchar(250) DEFAULT NULL,
  `patientPhoneNumber` varchar(20) DEFAULT NULL,
  `patientGender` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patientId`, `patientEmail`, `patientPassword`, `patientFirstname`, `patientLastname`, `patientCitizenId`, `patientAddress`, `patientPhoneNumber`, `patientGender`) VALUES
(1, 'Jiraphat6575@gmail.com', 'M12345', 'Jiraphat ', 'Ruttanabumrungsin ', '123456789012', 'Thungkru, Bangkok ', '0812345567', 'female'),
(2, 'Mary_zaza@gmail.com', 'Mo9999', 'Maria', 'Rauren', '1100223344551', 'Bangruk, Bangkok ', '0898887777', 'female'),
(3, 'Ken1234@hotmail.com', 'K11111', 'Kenny', 'Zena', '16783421342', 'Bangmod, Bangkok ', '0865554335', 'male'),
(4, 'Paul_4654@gmail.com', 'Paul46', 'Paul', 'Enzarzarse ', '123456781', 'Bangmod, Bangkok ', '0823134242', 'male'),
(5, 'GG6666@gmail.com', 'GG6666', 'Ganrada', 'Gave ', '143246752', 'Thonburi, Bangkok ', '0864443212', 'female'),
(6, 'fara123@gmail.com', 'Farad4', 'Farada', 'Wonhda', '110213312456', 'Bangmod, Bangkok ', '0875554444', 'female');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appointmentId`),
  ADD KEY `doctorId` (`doctorId`),
  ADD KEY `departmentName` (`departmentName`),
  ADD KEY `hospitalName` (`hospitalName`),
  ADD KEY `patientId` (`patientId`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`departmentName`),
  ADD KEY `hospitalName` (`hospitalName`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`doctorId`),
  ADD KEY `departmentName` (`departmentName`);

--
-- Indexes for table `hospital`
--
ALTER TABLE `hospital`
  ADD PRIMARY KEY (`hospitalName`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patientId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appointmentId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `doctorId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patientId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`doctorId`) REFERENCES `doctor` (`doctorId`),
  ADD CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`departmentName`) REFERENCES `department` (`departmentName`),
  ADD CONSTRAINT `appointment_ibfk_4` FOREIGN KEY (`hospitalName`) REFERENCES `hospital` (`hospitalName`),
  ADD CONSTRAINT `appointment_ibfk_5` FOREIGN KEY (`patientId`) REFERENCES `patient` (`patientId`);

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `department_ibfk_1` FOREIGN KEY (`hospitalName`) REFERENCES `hospital` (`hospitalName`);

--
-- Constraints for table `doctor`
--
ALTER TABLE `doctor`
  ADD CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`departmentName`) REFERENCES `department` (`departmentName`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

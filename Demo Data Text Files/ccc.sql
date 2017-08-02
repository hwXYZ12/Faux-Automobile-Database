-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: localhost    Database: ccc
-- ------------------------------------------------------
-- Server version	5.6.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ccc`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ccc` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `ccc`;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `CustomerID` int(11) DEFAULT NULL,
  `AccountNumber` int(11) NOT NULL DEFAULT '0',
  `AccountCreationDate` date NOT NULL,
  `CreditCardNumber` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AccountNumber`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (100100101,90010101,'2011-04-10',4123132454456550),(100100102,90010102,'2011-04-10',1221344356657880),(100100103,90010103,'2011-04-10',9889677645543220),(100100104,90010104,'2011-04-10',1221655609907660),(100100105,90010105,'2011-05-10',1221322334434550),(100100106,90010106,'2011-05-10',9889877867764550),(100100107,90010107,'2011-06-10',3443566576678770),(100100108,90010108,'2011-06-10',1221122132232330),(100100109,90010109,'2011-06-10',1234432145544550),(100100110,90010110,'2011-06-10',2345543289000980),(100100101,90010111,'2011-07-10',2345543282424980),(100100102,90010112,'2011-07-10',2345543289003440);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertisement`
--

DROP TABLE IF EXISTS `advertisement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advertisement` (
  `AdvertisementID` int(11) NOT NULL DEFAULT '0',
  `EmployeeID` int(11) NOT NULL,
  `Type` varchar(50) NOT NULL,
  `Date` date NOT NULL,
  `Company` varchar(50) NOT NULL,
  `ItemName` varchar(50) DEFAULT NULL,
  `Content` varchar(200) DEFAULT NULL,
  `UnitPrice` double(13,4) NOT NULL,
  `AvailableUnits` int(11) NOT NULL,
  PRIMARY KEY (`AdvertisementID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `advertisement_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisement`
--

LOCK TABLES `advertisement` WRITE;
/*!40000 ALTER TABLE `advertisement` DISABLE KEYS */;
INSERT INTO `advertisement` VALUES (33331,111221,'car(s)','2011-04-10','Ford','2012-Mustang','Ford Mustang! First 10 cutomers get a 10%Discount!',22000.0000,30),(33332,111222,'clothing','2011-04-10','GAP','Superman Shirt','Just $5!!!!!!!',5.0000,100);
/*!40000 ALTER TABLE `advertisement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circle`
--

DROP TABLE IF EXISTS `circle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circle` (
  `CircleID` int(11) NOT NULL DEFAULT '0',
  `CircleName` varchar(50) DEFAULT NULL,
  `Type` varchar(50) NOT NULL DEFAULT 'Group',
  `Owner` int(11) NOT NULL,
  PRIMARY KEY (`CircleID`),
  KEY `Owner` (`Owner`),
  CONSTRAINT `circle_ibfk_1` FOREIGN KEY (`Owner`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circle`
--

LOCK TABLES `circle` WRITE;
/*!40000 ALTER TABLE `circle` DISABLE KEYS */;
INSERT INTO `circle` VALUES (8001,'My Friends','Friends',100100101),(8002,'Best Friends','Friends',100100102),(8003,'StonyBrookGang','Friends',100100105),(8004,'CSJunkies','Group',100100107),(8005,'Norris Family','Family',100100109),(8006,'Microsoft Groupies','Company',100100106);
/*!40000 ALTER TABLE `circle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circleinvite`
--

DROP TABLE IF EXISTS `circleinvite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circleinvite` (
  `CustomerID` int(11) NOT NULL DEFAULT '0',
  `CircleID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CustomerID`,`CircleID`),
  KEY `CircleID` (`CircleID`),
  CONSTRAINT `circleinvite_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `circleinvite_ibfk_2` FOREIGN KEY (`CircleID`) REFERENCES `circle` (`CircleID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circleinvite`
--

LOCK TABLES `circleinvite` WRITE;
/*!40000 ALTER TABLE `circleinvite` DISABLE KEYS */;
/*!40000 ALTER TABLE `circleinvite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circlemembership`
--

DROP TABLE IF EXISTS `circlemembership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circlemembership` (
  `CustomerID` int(11) NOT NULL DEFAULT '0',
  `CircleID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CustomerID`,`CircleID`),
  KEY `CircleID` (`CircleID`),
  CONSTRAINT `circlemembership_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `circlemembership_ibfk_2` FOREIGN KEY (`CircleID`) REFERENCES `circle` (`CircleID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circlemembership`
--

LOCK TABLES `circlemembership` WRITE;
/*!40000 ALTER TABLE `circlemembership` DISABLE KEYS */;
INSERT INTO `circlemembership` VALUES (100100101,8001),(100100102,8001),(100100103,8001),(100100104,8001),(100100101,8002),(100100102,8002),(100100110,8002),(100100105,8003),(100100106,8003),(100100103,8004),(100100104,8004),(100100107,8004),(100100105,8005),(100100108,8005),(100100109,8005),(100100110,8005),(100100106,8006),(100100107,8006),(100100108,8006),(100100109,8006);
/*!40000 ALTER TABLE `circlemembership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circlerequest`
--

DROP TABLE IF EXISTS `circlerequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circlerequest` (
  `CustomerID` int(11) NOT NULL DEFAULT '0',
  `CircleID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CustomerID`,`CircleID`),
  KEY `CircleID` (`CircleID`),
  CONSTRAINT `circlerequest_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `circlerequest_ibfk_2` FOREIGN KEY (`CircleID`) REFERENCES `circle` (`CircleID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circlerequest`
--

LOCK TABLES `circlerequest` WRITE;
/*!40000 ALTER TABLE `circlerequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `circlerequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `CommentID` int(11) NOT NULL DEFAULT '0',
  `Date` date NOT NULL,
  `Content` varchar(200) DEFAULT NULL,
  `Author` int(11) NOT NULL,
  `PostID` int(11) NOT NULL,
  PRIMARY KEY (`CommentID`),
  KEY `Author` (`Author`),
  KEY `PostID` (`PostID`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`Author`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`PostID`) REFERENCES `post` (`PostID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (900001,'2011-10-10','Its beautiful! :)',100100101,20111),(900002,'2011-11-10','Nature\'s white blanket :D',100100107,20111),(900003,'2011-11-10','GO! GO! GO!',100100104,20112),(900004,'2011-11-10','we totally owned them!',100100103,20112),(900005,'2011-12-10','we won! We won!',100100102,20112),(900006,'2011-12-10','Congrats!',100100109,20114);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentlikes`
--

DROP TABLE IF EXISTS `commentlikes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commentlikes` (
  `CommentID` int(11) NOT NULL DEFAULT '0',
  `CustomerID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CommentID`,`CustomerID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `commentlikes_ibfk_1` FOREIGN KEY (`CommentID`) REFERENCES `comment` (`CommentID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `commentlikes_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentlikes`
--

LOCK TABLES `commentlikes` WRITE;
/*!40000 ALTER TABLE `commentlikes` DISABLE KEYS */;
INSERT INTO `commentlikes` VALUES (900002,100100101),(900002,100100102),(900002,100100103),(900002,100100104),(900004,100100106),(900004,100100107),(900004,100100108);
/*!40000 ALTER TABLE `commentlikes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `CustomerID` int(11) NOT NULL DEFAULT '0',
  `Password` varchar(20) NOT NULL DEFAULT 'none',
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `Sex` char(1) NOT NULL,
  `EmailAddress` varchar(50) DEFAULT NULL,
  `DateOfBirth` date NOT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `ZipCode` int(11) DEFAULT NULL,
  `Telephone` varchar(20) DEFAULT NULL,
  `Rating` int(11) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (100100101,'none','Alice','McKeeny','F','alice@blah.com','1988-10-10','Chapin Apt 2010,Health Drive','Stony Brook','NY',11790,'4314649881',8),(100100102,'none','Bob','Wonderwall','M','bob@blah.com','1988-06-08','21 MajorApt,Oak St.','NewYork','NY',11700,'4314649882',5),(100100103,'none','Elisa','Roth','F','elisa@blah.com','1992-11-10','43 Corvette Apt, Maple St','Stony Brook','NY',11790,'4314649883',5),(100100104,'none','Kelly','Mcdonald','F','kelly@blah.com','1991-11-11','54 East Apt,Oak St','NewYork','NY',11700,'4314649884',5),(100100105,'none','Wendy','Stanley','F','wendy@blah.com','1992-08-08','21 MajorApt,Oak St.','Stony Brook','NY',11790,'4314649885',2),(100100106,'none','Dennis','Ritchie','M','den@blah.com','1992-03-02','43 Corvette Apt, Maple St','NewYork','NY',11700,'4314649886',2),(100100107,'none','Patrick','Norris','M','patnor@blahblah.com','1992-08-07','Chapin Apt 1001,Health Drive','Stony Brook','NY',11790,'4314649887',2),(100100108,'none','Chuck','Stewart','M','chuck@blah.com','1991-02-01','54 East Apt,Oak St','NewYork','NY',11700,'4314649888',2),(100100109,'none','Brad','Norton','M','brad@blah.com','1992-09-01','Chapin Apt 2010,Health Drive','Stony Brook','NY',11790,'4314649889',2),(100100110,'none','Jeniffer','Buffet','F','jennycool123@blah.com','1989-08-01','Chapin Apt 1223,Health Drive','NewYork','NY',11700,'4314649890',2);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerpreferences`
--

DROP TABLE IF EXISTS `customerpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customerpreferences` (
  `CustomerID` int(11) NOT NULL,
  `Preference` varchar(50) NOT NULL DEFAULT 'Default',
  PRIMARY KEY (`CustomerID`,`Preference`),
  CONSTRAINT `customerpreferences_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerpreferences`
--

LOCK TABLES `customerpreferences` WRITE;
/*!40000 ALTER TABLE `customerpreferences` DISABLE KEYS */;
INSERT INTO `customerpreferences` VALUES (100100101,'car(s)'),(100100101,'life insurance'),(100100102,'car(s)'),(100100102,'clothing'),(100100103,'clothing'),(100100104,'clothing'),(100100104,'toys'),(100100105,'life insurance'),(100100106,'life insurance'),(100100107,'car(s)'),(100100107,'clothing'),(100100108,'clothing'),(100100108,'life insurance'),(100100109,'life insurance'),(100100110,'life insurance');
/*!40000 ALTER TABLE `customerpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `EmployeeID` int(11) NOT NULL DEFAULT '0',
  `Password` varchar(20) NOT NULL DEFAULT 'none',
  `SSN` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `ZipCode` int(11) DEFAULT NULL,
  `Telephone` varchar(20) DEFAULT NULL,
  `StartDate` date NOT NULL,
  `HourlyRate` double(13,4) NOT NULL,
  `Role` varchar(50) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE KEY `SSN` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (111220,'none',111444111,'Scott','Thomas','11 Oak St,Mart Avenue','Stony Brook','NY',11790,'4312345432','2011-01-05',35.0000,'Manager'),(111221,'none',111222333,'Mike','Thomas','43 Apple Apt,Maple Street','Stony Brook','NY',11790,'6314648998','2011-04-10',20.0000,'Customer Representative'),(111222,'none',111333222,'Jonthan','Klaus','76 PotterApt,Muriel Avenue','Stony Brook','NY',11790,'6314651232','2011-05-05',20.0000,'Customer Representative');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `MessageID` int(11) NOT NULL DEFAULT '0',
  `Date` date NOT NULL,
  `Subject` varchar(50) DEFAULT NULL,
  `Content` varchar(200) DEFAULT NULL,
  `Sender` int(11) NOT NULL,
  `Receiver` int(11) NOT NULL,
  PRIMARY KEY (`MessageID`),
  KEY `Receiver` (`Receiver`),
  KEY `Sender` (`Sender`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`Receiver`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`Sender`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (3001,'2011-10-10','hey!','Hey! Do u have assignent 1 questions?',100100101,100100102),(3002,'2011-10-10','re: hey!','nope? I think patrick has them.',100100102,100100101),(3003,'2011-11-11','happy bday!','hey u there! Have an amazing and super duper bday! Don?t miss me too much :D',100100103,100100104),(3004,'2011-11-10','will be late','Hey! I am sorry I wont make it to tonights appointment.Stuck with some work! :(',100100105,100100105);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page` (
  `PageID` int(11) NOT NULL DEFAULT '0',
  `PostCount` int(11) NOT NULL,
  `AssociatedCircle` int(11) DEFAULT NULL,
  PRIMARY KEY (`PageID`),
  KEY `AssociatedCircle` (`AssociatedCircle`),
  CONSTRAINT `page_ibfk_1` FOREIGN KEY (`AssociatedCircle`) REFERENCES `circle` (`CircleID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page`
--

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` VALUES (6900,2,8001),(6904,1,8003),(6905,1,8004),(6908,0,8005),(6910,1,8006);
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `PostID` int(11) NOT NULL DEFAULT '0',
  `Date` date NOT NULL,
  `Content` varchar(200) DEFAULT NULL,
  `CommentCount` int(11) NOT NULL DEFAULT '0',
  `PostAuthor` int(11) NOT NULL,
  `PageID` int(11) NOT NULL,
  PRIMARY KEY (`PostID`),
  KEY `PostAuthor` (`PostAuthor`),
  KEY `PageID` (`PageID`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`PostAuthor`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`PageID`) REFERENCES `page` (`PageID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (20111,'2011-10-10','Its Snowing! :D',2,100100105,6904),(20112,'2011-11-10','GO Seawolves!!!!',3,100100106,6910),(20113,'2011-11-10','Arrgh!I hate facebook!',0,100100103,6900),(20114,'2011-12-10','MackBook Finally!!!',1,100100104,6900),(20115,'2011-12-10','ritchie RIP :(',0,100100104,6905);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postlikes`
--

DROP TABLE IF EXISTS `postlikes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postlikes` (
  `PostID` int(11) NOT NULL DEFAULT '0',
  `CustomerID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`PostID`,`CustomerID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `postlikes_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `postlikes_ibfk_2` FOREIGN KEY (`PostID`) REFERENCES `post` (`PostID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postlikes`
--

LOCK TABLES `postlikes` WRITE;
/*!40000 ALTER TABLE `postlikes` DISABLE KEYS */;
INSERT INTO `postlikes` VALUES (20111,100100101),(20112,100100101),(20111,100100102),(20112,100100102),(20114,100100102),(20111,100100103),(20112,100100103),(20111,100100104),(20112,100100104),(20112,100100105),(20113,100100105),(20114,100100106),(20112,100100107),(20112,100100108),(20112,100100109);
/*!40000 ALTER TABLE `postlikes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale`
--

DROP TABLE IF EXISTS `sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale` (
  `TransactionID` int(11) NOT NULL DEFAULT '0',
  `DateOfSale` date NOT NULL,
  `AdvertisementID` int(11) NOT NULL,
  `NumUnits` int(11) NOT NULL,
  `AccountNumber` int(11) NOT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `AdvertisementID` (`AdvertisementID`),
  KEY `AccountNumber` (`AccountNumber`),
  CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`AdvertisementID`) REFERENCES `advertisement` (`AdvertisementID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `sale_ibfk_2` FOREIGN KEY (`AccountNumber`) REFERENCES `account` (`AccountNumber`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale`
--

LOCK TABLES `sale` WRITE;
/*!40000 ALTER TABLE `sale` DISABLE KEYS */;
INSERT INTO `sale` VALUES (200010001,'2011-04-22',33331,1,90010101),(200010002,'2011-04-23',33332,2,90010101),(200010003,'2011-04-23',33332,4,90010102),(200010004,'2011-04-23',33332,2,90010103);
/*!40000 ALTER TABLE `sale` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-03 23:38:31

-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Czas wygenerowania: 30 Cze 2015, 07:00
-- Wersja serwera: 5.5.43
-- Wersja PHP: 5.4.39-0+deb7u2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `roleplay`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rp_characters`
--

CREATE TABLE IF NOT EXISTS `rp_characters` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `globalid` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `skin` int(11) NOT NULL DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT '1000',
  `opis` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rp_groups`
--

CREATE TABLE IF NOT EXISTS `rp_groups` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `leaderUID` int(11) NOT NULL,
  `types` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rp_groups_members`
--

CREATE TABLE IF NOT EXISTS `rp_groups_members` (
  `groupUID` int(11) NOT NULL,
  `charUID` int(11) NOT NULL,
  `dutyTime` int(11) NOT NULL DEFAULT '0',
  `permissions` int(11) NOT NULL DEFAULT '0',
  `skin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rp_groups_shop`
--

CREATE TABLE IF NOT EXISTS `rp_groups_shop` (
  `groupType` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `name` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `subtypes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rp_items`
--

CREATE TABLE IF NOT EXISTS `rp_items` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `subtypes` varchar(128) NOT NULL,
  `inUse` tinyint(1) NOT NULL DEFAULT '0',
  `ownertype` int(11) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rp_objects`
--

CREATE TABLE IF NOT EXISTS `rp_objects` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `modelid` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `zonetype` int(11) NOT NULL,
  `zoneid` int(11) NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rp_properties`
--

CREATE TABLE IF NOT EXISTS `rp_properties` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `enterX` float NOT NULL,
  `enterY` float NOT NULL,
  `enterZ` float NOT NULL,
  `enterInterior` int(11) NOT NULL DEFAULT '0',
  `exitX` float NOT NULL,
  `exitY` float NOT NULL,
  `exitZ` float NOT NULL,
  `closed` int(11) NOT NULL DEFAULT '1',
  `ownertype` int(11) NOT NULL,
  `ownerid` int(11) NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rp_vehicles`
--

CREATE TABLE IF NOT EXISTS `rp_vehicles` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `model` int(11) NOT NULL,
  `parkX` float NOT NULL,
  `parkY` float NOT NULL,
  `parkZ` float NOT NULL,
  `parkRX` float NOT NULL,
  `parkRY` float NOT NULL,
  `parkRZ` float NOT NULL,
  `ownertype` int(11) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `color1` varchar(9) NOT NULL DEFAULT '000000000',
  `color2` varchar(9) NOT NULL DEFAULT '000000000',
  `color3` varchar(9) NOT NULL DEFAULT '000000000',
  `color4` varchar(9) NOT NULL DEFAULT '000000000',
  `health` int(11) NOT NULL DEFAULT '1000',
  `doorState` varchar(32) NOT NULL DEFAULT '0,0,0,0,0,0',
  `panelState` varchar(20) NOT NULL DEFAULT '0,0,0,0,0,0,0',
  `fuel` float NOT NULL DEFAULT '50',
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Gegenereerd op: 02 nov 2018 om 16:48
-- Serverversie: 10.1.16-MariaDB
-- PHP-versie: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `bezette_kamer`
--

CREATE TABLE `bezette_kamer` (
  `id` int(11) NOT NULL,
  `check_in` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `check_out` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `kamer_id` int(11) DEFAULT NULL,
  `reservering_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `gast`
--

CREATE TABLE `gast` (
  `id` int(11) NOT NULL,
  `voornaam` varchar(80) NOT NULL,
  `achternaam` varchar(80) NOT NULL,
  `lid_sinds` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `gast`
--

INSERT INTO `gast` (`id`, `voornaam`, `achternaam`, `lid_sinds`) VALUES
(1, 'Kees', 'Jager', '2014-08-01'),
(2, 'Maartje', 'Dijkgraaf', '2016-02-15'),
(3, 'Peter', 'Buwalda', '2017-04-10'),
(4, 'Tommy', 'Wieringa', '2012-11-06'),
(5, 'Adriaan van', 'Dis', '2015-12-22'),
(6, 'Marieke Lucas', 'Rijneveld', '2014-07-08'),
(7, 'Jan', 'Harmens', '2013-09-20'),
(8, 'Hans', 'Dorrestijn', '2011-05-05'),
(9, 'Onno', 'Blom', '2018-10-14'),
(10, 'Jochem', 'Myjer', '2018-03-18');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `gereserveerde_kamer`
--

CREATE TABLE `gereserveerde_kamer` (
  `id` int(11) NOT NULL,
  `aantal_kamers` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `kamer_type_id` int(11) DEFAULT NULL,
  `reservering_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `ingecheckt`
--

CREATE TABLE `ingecheckt` (
  `id` int(11) NOT NULL,
  `gast_id` int(11) DEFAULT NULL,
  `bezette_kamer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `kamer`
--

CREATE TABLE `kamer` (
  `id` int(11) NOT NULL,
  `nummer` int(11) DEFAULT NULL,
  `naam` varchar(40) NOT NULL,
  `status` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `kamer`
--

INSERT INTO `kamer` (`id`, `nummer`, `naam`, `status`) VALUES
(1, 1, 'Ludwig', 'schoon'),
(2, 2, 'Amadeus', 'bezig'),
(3, 3, 'Brahms', 'schoon'),
(4, 4, 'Chopin', 'bezig'),
(5, 5, 'Schubert', 'schoon'),
(6, 6, 'Verdi', 'schoon'),
(7, 7, 'Haydn', 'schoon');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `kamer_type`
--

CREATE TABLE `kamer_type` (
  `id` int(11) NOT NULL,
  `type` varchar(80) NOT NULL,
  `beschrijving` varchar(255) DEFAULT NULL,
  `max_personen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `kamer_type`
--

INSERT INTO `kamer_type` (`id`, `type`, `beschrijving`, `max_personen`) VALUES
(1, 'Standaard Kamer', 'Basic kamer met eigen badkamer', 2),
(2, 'Deluxe Suite', 'Luxe suite, badkamer, keuken, minibar', 2),
(3, 'Superior Suite', 'Zeer luxe suite, badkamer/whirlpool, keuken, minibar, uitzicht', 4),
(4, 'Deluxe Apartement', 'Luxe apartement, badkamer, keuken, uitzichtt', 4),
(5, 'Superior Apartement', 'Zeer luxe apartement, badkamer/whirlpool, keuken/kookeiland, uitzichtt', 6);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `reservering`
--

CREATE TABLE `reservering` (
  `id` int(11) NOT NULL,
  `date_in` date NOT NULL,
  `date_out` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `made_by` varchar(20) DEFAULT NULL,
  `gast_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `bezette_kamer`
--
ALTER TABLE `bezette_kamer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kamer_id` (`kamer_id`),
  ADD KEY `reservering_id` (`reservering_id`);

--
-- Indexen voor tabel `gast`
--
ALTER TABLE `gast`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `gereserveerde_kamer`
--
ALTER TABLE `gereserveerde_kamer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kamer_type_id` (`kamer_type_id`),
  ADD KEY `reservering_id` (`reservering_id`);

--
-- Indexen voor tabel `ingecheckt`
--
ALTER TABLE `ingecheckt`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gast_id` (`gast_id`),
  ADD KEY `bezette_kamer_id` (`bezette_kamer_id`);

--
-- Indexen voor tabel `kamer`
--
ALTER TABLE `kamer`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `kamer_type`
--
ALTER TABLE `kamer_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `reservering`
--
ALTER TABLE `reservering`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gast_id` (`gast_id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `bezette_kamer`
--
ALTER TABLE `bezette_kamer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `gast`
--
ALTER TABLE `gast`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT voor een tabel `gereserveerde_kamer`
--
ALTER TABLE `gereserveerde_kamer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `ingecheckt`
--
ALTER TABLE `ingecheckt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `kamer`
--
ALTER TABLE `kamer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT voor een tabel `kamer_type`
--
ALTER TABLE `kamer_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT voor een tabel `reservering`
--
ALTER TABLE `reservering`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `bezette_kamer`
--
ALTER TABLE `bezette_kamer`
  ADD CONSTRAINT `bezette_kamer_ibfk_1` FOREIGN KEY (`kamer_id`) REFERENCES `kamer` (`id`),
  ADD CONSTRAINT `bezette_kamer_ibfk_2` FOREIGN KEY (`reservering_id`) REFERENCES `reservering` (`id`);

--
-- Beperkingen voor tabel `gereserveerde_kamer`
--
ALTER TABLE `gereserveerde_kamer`
  ADD CONSTRAINT `gereserveerde_kamer_ibfk_1` FOREIGN KEY (`kamer_type_id`) REFERENCES `kamer_type` (`id`),
  ADD CONSTRAINT `gereserveerde_kamer_ibfk_2` FOREIGN KEY (`reservering_id`) REFERENCES `reservering` (`id`);

--
-- Beperkingen voor tabel `ingecheckt`
--
ALTER TABLE `ingecheckt`
  ADD CONSTRAINT `ingecheckt_ibfk_1` FOREIGN KEY (`gast_id`) REFERENCES `gast` (`id`),
  ADD CONSTRAINT `ingecheckt_ibfk_2` FOREIGN KEY (`bezette_kamer_id`) REFERENCES `bezette_kamer` (`id`);

--
-- Beperkingen voor tabel `reservering`
--
ALTER TABLE `reservering`
  ADD CONSTRAINT `reservering_ibfk_1` FOREIGN KEY (`gast_id`) REFERENCES `gast` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

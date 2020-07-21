-- @author J.Kostensalo
-- @version 21.7.2020
-- SQL comands for creating the NuclearWizard database.

-- Nucleus table includes all the necessary isotope information
CREATE TABLE nucleus (
	symb VARCHAR(5) PRIMARY KEY,
	a INT,
    z INT,
    half_life INT,
    hl_unit CHAR(1),
    gs VARCHAR(10)
);

-- ncalc table is the nuclear calculation table. The calculation has 
-- a distinct ID number, and describes one isotope. Includes the file reference
-- to the original calculation files. 
CREATE TABLE ncalc (
	calc_id INT NOT NULL AUTO_INCREMENT,
	symb VARCHAR(5),
	model VARCHAR(15),
	hamil VARCHAR(15),
	author VARCHAR(20),
	fileref VARCHAR(20),
	PRIMARY KEY (calc_id),
	FOREIGN KEY (symb) REFERENCES nucleus (symb)
		ON UPDATE RESTRICT
		ON DELETE CASCADE
);

-- single_decay table includes all the beta, alpha, p, n, ... decays
-- with one well defined initial and final state 
CREATE TABLE single_decay (
	initial VARCHAR(5) NOT NULL,
    calc_id INT,
    ei NUMERIC(6,4),
    ef NUMERIC(6,4),
    jpi_i VARCHAR(6),
    jpi_f VARCHAR(6),
    ki INT,
    kf INT,
    dtype VARCHAR(10),  
    fileref VARCHAR(20),
    PRIMARY KEY (calc_id,jpi_i,jpi_f,ki,kf,dtype),
    FOREIGN KEY (initial) REFERENCES ncalc (symb)
		ON UPDATE RESTRICT
		ON DELETE CASCADE,
	FOREIGN KEY (calc_id) REFERENCES ncalc (calc_id)  
		ON UPDATE RESTRICT
		ON DELETE CASCADE
	
);

-- other_transition table includes calculations for 2vBB,
-- neutrino nucleus scattering etc. with multiple final/intermidiate
-- states.
CREATE TABLE other_transition (
	initial VARCHAR(5) NOT NULL,
    calc_id INT,
    dtype VARCHAR(10),  
    fileref VARCHAR(20),
    PRIMARY KEY (calc_id,dtype),
    FOREIGN KEY (initial) REFERENCES ncalc (symb)
		ON UPDATE RESTRICT
		ON DELETE CASCADE,
	FOREIGN KEY (calc_id) REFERENCES ncalc (calc_id)  
		ON UPDATE RESTRICT
		ON DELETE CASCADE	
);

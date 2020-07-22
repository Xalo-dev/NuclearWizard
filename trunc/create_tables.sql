-- @author J.Kostensalo
-- @version 21.7.2020
-- SQL comands for creating the NuclearWizard database.

-- Nucleus table includes all the necessary isotope information
-- symb = symbol (e.g. 92Rb)
-- a = mass number
-- z = proton number
-- half_life = numerical hl
-- hl_exp = exponent of hl (power of 10)
-- hl_unit = S, M, H, D or Y
-- gs = ground state spin-parity
CREATE TABLE nucleus (
	symb VARCHAR(5) PRIMARY KEY,
	a INT,
    z INT,
    half_life INT,
    hl_exp INT,
    hl_unit CHAR(1),
    gs VARCHAR(10)
);

-- ncalc table is the nuclear calculation table. The calculation has 
-- a distinct ID number, and describes one isotope. Includes the file reference
-- to the original calculation files. 
-- calc_id = ID of the nuclear calculation in the ncalc table
-- model = ISM, MQPM, IBM ...
-- hamil = Hamiltonian
-- fileref = reference to calculation files if available
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
-- Initial state: initial = init. isotope symbol, ei = energy of initial state, jpi_i = J,pi of initial state
-- ki = numeration of initial state (of same spin-parity)
-- Final state:  ef = energy of final state, jpi_f = J,pi of final state
-- kf = numeration of final state (of same spin-parity)
-- brr = BRANCHING RATIO in %
-- dtype = decay type A, B+, EC, B-, SF, ...
-- forb = F, GT 1FU, 1FNU,...
-- fileref = reference to the calculation files if available
-- calc_id = ID of the nuclear calculation in the ncalc table
CREATE TABLE single_decay (
	initial VARCHAR(5) NOT NULL,
    calc_id INT,
    ei NUMERIC(6,4),
    ef NUMERIC(6,4),
    jpi_i VARCHAR(6),
    jpi_f VARCHAR(6),
    ki INT,
    kf INT,
    br NUMERIC(10,7),
    dtype VARCHAR(10),  
    fileref VARCHAR(20),
    forb VARCHAR(6),
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
-- dtype = CC, NC, 0VBB, 2VBB, MU,....
-- NOTE, this would function with just calc_id (no symb) but it is much more user friendly with the symbol. The size of the database is relatively small,
-- so saving space here in a way which complicates querying later is not optimal.  
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


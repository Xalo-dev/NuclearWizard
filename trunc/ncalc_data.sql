-- Inserts the nuclear calculation information to NCALC table
-- @author J.Kostensalo
-- @version 22.7.2020

-- calc_id (automatic, just put NULL), symb, model, hamil, author, fileref
INSERT INTO ncalc VALUES (NULL,'39Ar','SM','sdpfu','Joel',NULL);
INSERT INTO ncalc VALUES (NULL,'39Ar','SM','sdpfk','Joel',NULL);
INSERT INTO ncalc VALUES (NULL,'39Ar','SM','sdpfnow','Joel',NULL);

SELECT * FROM ncalc;
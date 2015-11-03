-- ================================================
-- lsfr_cell.vhd
-- Ludovic L'Hours, Tanguy Risset
--
-- One cell of a LSFR
-- xor operator goes to the register
-- register goes to output
-- ================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity lsfr_cell is
  port (
    i_clk      : in std_logic;
    i_rst      : in std_logic;
    i_ce       : in std_logic;
    i_input    : in std_logic;
    i_feedback : in std_logic;
    i_conf     : in std_logic;
    o_output    : out std_logic
       );
end lsfr_cell;

architecture RTL of lsfr_cell is

  signal r_cell  : std_logic;
  signal w_xor   : std_logic;

begin
 
PROCESS(i_clk,i_rst)
BEGIN
IF (i_rst = '0' ) THEN
	IF (i_clk = '1' AND i_clk'EVENT) THEN
		IF i_ce='1' THEN o_output <= w_xor;
		END IF;
	END IF;
ELSE
	o_output <= '0'; --init au reset		
END IF;	
END PROCESS;
	r_cell<= i_conf and i_feedback;
	w_xor<= r_cell xor i_input;
  	-- o_output <= i_input;
end RTL;

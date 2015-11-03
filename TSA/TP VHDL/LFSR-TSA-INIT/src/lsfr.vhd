-- ================================================
-- lsfr.vhd
-- Ludovic L'Hours, Tanguy Risset
--
-- a LSFR using N LSFR_cell
-- The first cell (index 0) should allways have i_conf(0)='0'
-- ================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- K: size of input
-- M: size of the  divider (= degree of the polynomial g)
entity lsfr is
  generic (
    K : natural;                         
    M : natural
  );
  port (
    i_clk    : in std_logic;
    i_rst    : in std_logic;
    i_ce     : in std_logic;
    i_input  : in std_logic;
    i_feedback_ctrl  : in std_logic;
    i_conf   : in std_logic_vector((M-1) downto 0);
    o_output : out std_logic
  );
end lsfr;

architecture RTL of lsfr is

component lsfr_cell is
  port (
    i_clk      : in std_logic;
    i_rst      : in std_logic;
    i_ce       : in std_logic;
    i_input    : in std_logic;
    i_feedback : in std_logic;
    i_conf     : in std_logic;
    o_output   : out std_logic
       );
end component;

signal w_in : std_logic_vector((M-1) downto 0);
signal w_out : std_logic_vector((M-1) downto 0);

begin
  chain: for i in 0 to M-1 generate
    cell : lsfr_cell
    port map (
      i_clk      => i_clk,
      i_rst      => i_rst,
      i_ce       => i_ce,
      i_input    => w_in(i),
      i_feedback => w_in(0),
      i_conf     => i_conf(i),
      o_output   => w_out(i)
      );
  end generate;
  chain2: for i in 1 to M-1 generate
  	w_in(i) <= w_out(i-1);
end generate;
w_in(0)<= (i_feedback_ctrl and w_out(M-1)) xor i_input;
o_output <= (NOT i_feedback_ctrl and w_out(M-1)) or i_input;
 

end RTL;


-- ================================================
-- lfsm_cell_tb.vhd
--
-- Testbench for LFSM component
-- ================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity lsfr_cell_tb is
end lsfr_cell_tb;

architecture BEH of lsfr_cell_tb is

component lsfr_cell is
   port (
    i_clk      : in std_logic;
    i_rst      : in std_logic;
    i_ce       : in std_logic;
    i_input    : in std_logic;
    i_feedback : in std_logic;
    i_conf     : in std_logic;
    o_output    : out std_logic
  );
end component;

constant N : natural := 16;

signal w_clk : std_logic := '0';
signal w_rst : std_logic := '1';

signal w_s : std_logic;
signal w_input : std_logic;
signal w_conf : std_logic;
signal w_feed : std_logic;

signal r_conf : std_logic_vector((N-1) downto 0); 
signal r_feed : std_logic_vector((N-1) downto 0); 
signal r_input : std_logic_vector((N-1) downto 0); 
signal w_ce : std_logic;
signal w_cnt : integer;

begin

  w_clk <= not w_clk after 100 ns;
  w_rst <= '0' after 300 ns;

  w_input <= r_input(N-1);
  w_conf <= r_conf(N-1);
  w_feed <= r_feed(N-1);

  process (w_clk, w_rst)
  begin
    if w_rst = '1' then
      --test input mechanism
      r_conf <= "0011001100000000";
      r_input <= "1010101010101010";
      r_feed <= "0000111100000000"; 
      w_ce <= '0';
      w_cnt <= 0;
    elsif rising_edge(w_clk) then
      r_conf  <= r_conf((N-2) downto 0) & "0";
      r_input  <= r_input((N-2) downto 0) & "0";
      r_feed  <= r_feed((N-2) downto 0) & "0";
      w_cnt <= w_cnt + 1;
      w_ce <= '1';
    end if;
  end process;


  dut : lsfr_cell
    port map(
      i_clk    => w_clk,
      i_rst    => w_rst,
      i_ce     => w_ce,
      i_input   => w_input,
      i_feedback  => w_feed,
      i_conf   => w_conf,
      o_output => w_s
    );

end BEH;

-- ================================================
-- codeur_tb.vhd
-- Ludovic L'Hours, Tanguy Risset
--
-- Testbench for codeur component
-- ================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity codeur_tb is
end codeur_tb;

architecture BEH of codeur_tb is

component codeur is
  generic (
    K : natural;                         
    M : natural
  );
  port (
    i_clk    : in std_logic;
    i_rst    : in std_logic;
    i_ce     : in std_logic;
    i_input  : in std_logic;
    i_conf   : in std_logic_vector((M-1) downto 0);
    o_output : out std_logic
  );
end component;

-- K: size of input
-- M: size of the  divider (= degree of the polynomial g)
constant K : natural := 4;
constant M : natural := 3;

  
signal w_clk : std_logic := '0';
signal w_rst : std_logic := '1';
signal w_ce : std_logic := '1';
signal w_input : std_logic;
-- g(x)=x^3+x^2+1=1101 ==> on extrait le milieu: "10"
-- et on rajoute un 0 pour la cellule de poid faible: "100"
signal w_conf : std_logic_vector((M-1) downto 0):= "100";

signal w_out : std_logic;

signal cnt : integer;

begin

  w_clk <= not w_clk after 100 ns;
  w_rst <= '0' after 340 ns;

  process (w_clk, w_rst)
  begin
    if w_rst = '1' then
      cnt <= 0;
    elsif rising_edge(w_clk) then
        cnt <= cnt + 1;
    end if;
  end process;

  process (cnt)
    begin
    -- test vector g(x)=x^3+x^2+1
    -- i(x)= x^3 + 1
    -- Le resultat doit etre 1001011 (cf correction TD)
    --
    case cnt is
      when 0 => w_input <= '0';
      when 1 => w_input <= '1';
      when 2 => w_input <= '0';
      when 3 => w_input <= '0';
      when 4 => w_input <= '1';
      when 5 => w_input <= '0';
      when 6 => w_input <= '0';
      when others => w_input <= '0';
    end case;
  end process;


  dut : codeur
  generic map(
    K => K,
    M => M
             )
    port map(
      i_clk    => w_clk,
      i_rst    => w_rst,
      i_ce     => w_ce,
      i_input  => w_input,
      i_conf   => w_conf,
      o_output => w_out
            );

end BEH;

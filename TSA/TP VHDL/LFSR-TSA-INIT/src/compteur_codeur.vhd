-- ================================================
-- Compteur_codeur.vhd
-- Ludovic L'Hours, Tanguy Risset
--
-- Control of the codeur: K cycles of '1'followed by
-- M cycles of '0'
-- ================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- K: size of input
-- M: size of the  divider (= degree of the polynomial g)
entity compteur_codeur is
  generic (
    K : natural;                         
    M : natural
  );
  port (
    i_clk      : in std_logic;
    i_rst      : in std_logic;
    i_ce       : in std_logic;
    o_output    : out std_logic
       );
end compteur_codeur;

architecture RTL of compteur_codeur is

  signal cpt : std_logic_vector(7 downto 0);    -- compteur interne

begin


     process (i_clk, i_rst)
  begin
    if i_rst = '1' then
      cpt  <= (others => '0');
    elsif rising_edge(i_clk) and i_ce = '1' then
      cpt <= cpt+1;
    end if;
  end process;

  process (cpt)
  begin
    if (cpt <= K) then
      o_output <= '1';
    else
      o_output <= '0';
    end if;
  end process;

end RTL;

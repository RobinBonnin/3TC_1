-- ================================================
-- codeur.vhd
-- Ludovic L'Hours, Tanguy Risset
--
-- Codage de hamming utilisant un LSFR
-- ================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- K: size of input
-- M: size of the  divider (= degree - 1 because g0=1 and gM=1)
entity codeur is
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
end codeur;


architecture RTL of codeur is

component lsfr is
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
end component;

component compteur_codeur is
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
end component;

signal w_feedback_ctrl : std_logic;



begin


  lsfr_1 : lsfr
  generic map(
    K => K,
    M => M
             )
    port map (
      i_clk      => i_clk,
      i_rst      => i_rst,
      i_ce       => i_ce,
      i_input    => i_input,
      i_feedback_ctrl => w_feedback_ctrl,
      i_conf     => i_conf,
      o_output   => o_output
      );

  compteur : compteur_codeur
  generic map(
    K => K,
    M => M
             )
    port map(
      i_clk    => i_clk,
      i_rst    => i_rst,
      i_ce     => i_ce,
      o_output => w_feedback_ctrl
            );

end RTL;

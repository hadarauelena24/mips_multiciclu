----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 06:02:25 PM
-- Design Name: 
-- Module Name: top_env - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_env is
    Port ( clk : in STD_LOGIC;
       btn : in STD_LOGIC_VECTOR (4 downto 0);
       sw : in STD_LOGIC_VECTOR (15 downto 0);
       cat : out STD_LOGIC_VECTOR (6 downto 0);
       an : out STD_LOGIC_VECTOR (3 downto 0);
       led : out STD_LOGIC_VECTOR (15 downto 0));
end top_env;

architecture Behavioral of top_env is
component mips_multi is
Port (clk: in std_logic;
      enW: in std_logic;
      enR: in std_logic;
      switchout: in std_logic_vector(3 downto 0);
      pcgo: out std_logic_vector(3 downto 0);
      memgo: out std_logic_vector(4 downto 0);
      rfgo: out std_logic_vector(4 downto 0);
      alugo: out std_logic_vector(5 downto 0);
      mips_out: out std_logic_vector(31 downto 0) );
end component mips_multi;

signal enW,enR: std_logic:='0';
signal mips_out: std_logic_vector(31 downto 0):=(others=>'0');

component monoimpuls is
    Port ( input: in std_logic;
           clk: in std_logic;
           output: out std_logic);
end component monoimpuls;

component SSD is
    Port ( Digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC);
end component SSD;
signal outtemp: STD_LOGIC_VECTOR (15 downto 0):=(others=>'0');
signal alugo: std_logic_vector(5 downto 0):=(others=>'0');
begin

MPGW: monoimpuls port map (input=>btn(0),clk=>clk, output=>enW);
MPGR: monoimpuls port map (input=>btn(1),clk=>clk, output=>enR); 
MIPS: mips_multi port map(clk=>clk,enW=>enW,enR=>enR,switchout=>sw(4 downto 1),pcgo=>led(15 downto 12),memgo=>led(11 downto 7),rfgo=>led(6 downto 2),alugo=>alugo,mips_out=>mips_out);
led(1 downto 0)<=alugo(5 downto 4);
process(sw)
begin
if sw(0)='0' then
    outtemp(15 downto 0)<=mips_out(15 downto 0);
else
    outtemp(15 downto 0)<=mips_out(31 downto 16);  
end if;
end process;
sevsegdisp: SSD port map(Digit0=>outtemp(3 downto 0),Digit1=>outtemp(7 downto 4),Digit2=>outtemp(11 downto 8),Digit3=>outtemp(15 downto 12),cat=>cat,an=>an,clk=>clk);

end Behavioral;

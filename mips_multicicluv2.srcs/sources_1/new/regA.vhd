----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2023 12:01:16 AM
-- Design Name: 
-- Module Name: regA - Behavioral
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

entity regA is
    Port ( rd1 : in STD_LOGIC_VECTOR (31 downto 0);
           wa : in STD_LOGIC;
           a : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           enable_W : in STD_LOGIC;
           enable_R : in STD_LOGIC);
end regA;

architecture Behavioral of regA is
signal outtemp: STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
process(clk,enable_W,enable_R,rd1,wa)
variable outtemp: STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
if rising_edge(clk) then
    if enable_R='1' then
        outtemp:=x"00000000";
    elsif enable_W='1' then
        if wa='1' then
            outtemp:=rd1;
        end if;
    end if;
end if;
a<=outtemp;
end process;
end Behavioral;

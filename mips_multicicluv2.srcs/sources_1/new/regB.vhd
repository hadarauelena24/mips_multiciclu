----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2023 12:01:16 AM
-- Design Name: 
-- Module Name: regB - Behavioral
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

entity regB is
    Port ( clk : in STD_LOGIC;
           enable_W : in STD_LOGIC;
           enable_R : in STD_LOGIC;
           rd2 : in STD_LOGIC_VECTOR (31 downto 0);
           wb : in STD_LOGIC;
           b : out STD_LOGIC_VECTOR (31 downto 0));
end regB;

architecture Behavioral of regB is
signal outtemp: STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
process(clk,enable_W,enable_R,rd2,wb)
begin
if rising_edge(clk) then
    if enable_R='1' then
        outtemp<=x"00000000";
    elsif enable_W='1' then
        if wb='1' then
            outtemp<=rd2; 
        end if;
    end if;
end if;
end process;
b<=outtemp;
end Behavioral;

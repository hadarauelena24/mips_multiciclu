----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2023 06:41:14 PM
-- Design Name: 
-- Module Name: regALU - Behavioral
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

entity regALU is
    Port ( clk : in STD_LOGIC;
           enable_W : in STD_LOGIC;
           enable_R : in STD_LOGIC;
           enALUOut : in STD_LOGIC;
           alures : in STD_LOGIC_VECTOR (31 downto 0);
           aluoutdata : out STD_LOGIC_VECTOR (31 downto 0));
end regALU;

architecture Behavioral of regALU is
signal outtemp: STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
process(clk,enable_W,enable_R,enALUOut,alures)
begin
if rising_edge(clk) then
    if enable_R='1' then
        outtemp<=x"00000000";
    elsif enable_W='1' then
        if enALUOut='1' then
            outtemp<=alures;
        end if;
    end if;
end if;
end process;
aluoutdata<=outtemp;
end Behavioral;

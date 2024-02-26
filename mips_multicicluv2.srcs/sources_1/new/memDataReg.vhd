----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2023 11:16:59 PM
-- Design Name: 
-- Module Name: memDataReg - Behavioral
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

entity memDataReg is
    Port ( clk : in STD_LOGIC;
           enable_W:in std_logic;
           enable_R:in std_logic;
           memData : in STD_LOGIC_VECTOR (31 downto 0);
           memRegWr : in STD_LOGIC;
           dataMem : out STD_LOGIC_VECTOR (31 downto 0));
end memDataReg;

architecture Behavioral of memDataReg is
signal outtemp: STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
process(memData,memRegWr,clk,enable_W)
begin
if rising_edge(clk) then
    if enable_R='1' then
        outtemp<=x"00000000";
    elsif enable_W='1' then
        if memRegWr='1' then
            outtemp<=memData;
        end if;
    end if;
end if;
end process;
dataMem<=outtemp;
end Behavioral;

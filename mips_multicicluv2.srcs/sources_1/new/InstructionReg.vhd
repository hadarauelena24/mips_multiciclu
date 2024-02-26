----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2023 11:09:34 PM
-- Design Name: 
-- Module Name: InstructionReg - Behavioral
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

entity InstructionReg is
    Port ( clk : in STD_LOGIC;
           enable_W:in std_logic;
           enable_R: in STD_LOGIC;
           memData : in STD_LOGIC_VECTOR (31 downto 0);
           irWr : in STD_LOGIC;
           instr : out STD_LOGIC_VECTOR (31 downto 0));
end InstructionReg;

architecture Behavioral of InstructionReg is
signal outtemp: STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
process(memData,irWr,clk,enable_W,enable_R)
begin
if rising_edge(clk) then
    if enable_R='1' then
        outtemp<=x"00000000";
    elsif enable_W='1' then
        if irWr='1' then
            outtemp<=memData; 
        end if;
    end if;
end if;
end process;
instr<=outtemp;
end Behavioral;

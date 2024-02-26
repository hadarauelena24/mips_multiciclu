----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 12:44:29 PM
-- Design Name: 
-- Module Name: signext - Behavioral
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

entity signext is
    Port ( instr15_0 : in STD_LOGIC_VECTOR (15 downto 0);
           ext_imm : out STD_LOGIC_VECTOR (31 downto 0));
end signext;

architecture Behavioral of signext is

begin
process(instr15_0)
begin
if instr15_0(15)='1' then
    ext_imm<=x"FFFF"&instr15_0;
else
    ext_imm<=x"0000"&instr15_0;
end if;
end process;
end Behavioral;

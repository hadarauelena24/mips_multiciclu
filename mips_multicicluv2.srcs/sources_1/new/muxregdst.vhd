----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 12:32:32 PM
-- Design Name: 
-- Module Name: muxregdst - Behavioral
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

entity muxregdst is
    Port ( regDst : in STD_LOGIC;
           instr20_16_rt : in STD_LOGIC_VECTOR (4 downto 0);
           instr15_11_rd : in STD_LOGIC_VECTOR (4 downto 0);
           wa : out STD_LOGIC_VECTOR (4 downto 0));
end muxregdst;

architecture Behavioral of muxregdst is

begin
process(regDst,instr20_16_rt,instr15_11_rd)
begin
if regDst='1' then
    wa<=instr15_11_rd;
else
    wa<=instr20_16_rt;
end if;
end process;

end Behavioral;

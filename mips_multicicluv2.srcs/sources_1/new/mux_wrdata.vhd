----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 12:34:38 PM
-- Design Name: 
-- Module Name: mux_wrdata - Behavioral
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

entity mux_wrdata is
    Port ( mem2reg : in STD_LOGIC;
           aluoutdata : in STD_LOGIC_VECTOR (31 downto 0);
           memData_reg : in STD_LOGIC_VECTOR (31 downto 0);
           wd : out STD_LOGIC_VECTOR (31 downto 0));
end mux_wrdata;

architecture Behavioral of mux_wrdata is

begin
process(mem2reg,aluoutdata,memData_reg)
begin
if mem2reg='1' then
    wd<=memData_reg;
else
    wd<=aluoutdata;
end if;
end process;

end Behavioral;

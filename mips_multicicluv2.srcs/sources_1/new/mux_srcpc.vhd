----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 12:42:12 PM
-- Design Name: 
-- Module Name: mux_srcpc - Behavioral
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

entity mux_srcpc is
    Port ( pcsrc : in STD_LOGIC_VECTOR (1 downto 0);
           jmpAdd : in STD_LOGIC_VECTOR (31 downto 0);
           brAdd : in STD_LOGIC_VECTOR (31 downto 0);
           aluoutdata : in STD_LOGIC_VECTOR (31 downto 0);
           srcpc : out STD_LOGIC_VECTOR (31 downto 0));
end mux_srcpc;

architecture Behavioral of mux_srcpc is

begin
process(pcsrc,jmpAdd,brAdd,aluoutdata)
begin
case pcsrc is
    when "00" => srcpc <= aluoutdata;--alures
    when "01" => srcpc <= brAdd;--iesirea lui ALUout
    when "10" => srcpc <= jmpAdd;
    when others => srcpc <=x"00000000";
end case;
end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 12:30:11 PM
-- Design Name: 
-- Module Name: muxpc_mem - Behavioral
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

entity muxpc_mem is
    Port ( iord : in STD_LOGIC;
           pc : in STD_LOGIC_VECTOR (31 downto 0);
           aluoutdata : in STD_LOGIC_VECTOR (31 downto 0);
           outmuxpc_mem : out STD_LOGIC_VECTOR (31 downto 0));
end muxpc_mem;

architecture Behavioral of muxpc_mem is
signal outtemp:STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
process(iord,pc,aluoutdata)
begin
if iord='1' then
    outtemp<=aluoutdata;
else
    outtemp<=pc;
end if;
end process;
outmuxpc_mem<=outtemp;
end Behavioral;

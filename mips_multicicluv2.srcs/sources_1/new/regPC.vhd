----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2023 07:07:06 PM
-- Design Name: 
-- Module Name: regPC - Behavioral
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

entity regPC is
    Port ( clk : in STD_LOGIC;
           enable_w : in STD_LOGIC;
           enable_r : in STD_LOGIC;
           enpc : in STD_LOGIC;
           muxadrurm : in STD_LOGIC_VECTOR (31 downto 0);
           pc : out STD_LOGIC_VECTOR (31 downto 0));
end regPC;

architecture Behavioral of regPC is
signal pctemp: STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
process(clk,enable_W,enable_R,enpc,muxadrurm)
begin
if rising_edge(clk) then
    if enable_R='1' then
        pctemp<=x"00000000";
    elsif enable_W='1' then
        if enpc='1' then
            pctemp<=muxadrurm;
        end if;
    end if;
end if;
end process;
pc<=pctemp;

end Behavioral;

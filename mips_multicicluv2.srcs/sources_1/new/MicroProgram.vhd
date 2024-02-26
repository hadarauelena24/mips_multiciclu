----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2023 12:06:04 AM
-- Design Name: 
-- Module Name: MicroProgram - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MicroProgram is
    Port ( currentAddr : in STD_LOGIC_VECTOR (3 downto 0);
           PCGroup : out STD_LOGIC_VECTOR (3 downto 0);
           MEMGroup : out STD_LOGIC_VECTOR (4 downto 0);
           RFGroup : out STD_LOGIC_VECTOR (4 downto 0);
           ALUGroup : out STD_LOGIC_VECTOR (5 downto 0);
           nextState: out STD_LOGIC_VECTOR(3 downto 0));
end MicroProgram;

architecture Behavioral of MicroProgram is

type mem16_19 is array (0 to 15) of std_logic_vector(19 downto 0);
        signal microMem :mem16_19:=(B"1000_01010_00000_000010",--PCGroup_MEMGroup_RFGroup_ALUGroup
                                    B"0000_00000_00011_000111",
                                    B"0000_00000_00000_101001",
                                    B"0000_00000_11000_000000",
                                    B"0000_00000_00000_001101",
                                    B"0000_10100_00000_000000", 
                                    B"0000_01101_00000_000000",
                                    B"0000_00000_10100_000000",
                                    B"0101_00000_00000_011000",
                                    B"1010_00000_00000_000000",
                                    others=>B"0000_00000_00000_000000");
signal controlsignals: std_logic_vector(19 downto 0):=(others=>'0');
begin
process(currentAddr)
variable controlsignals:std_logic_vector(19 downto 0):=(others=>'0');
begin
controlsignals:=microMem(conv_integer(currentAddr));
PCGroup<=controlsignals(19 downto 16);
MEMGroup<=controlsignals(15 downto 11);
RFGroup<=controlsignals(10 downto 6);
ALUGroup<=controlsignals(5 downto 0);
nextState<=currentAddr;
end process;
end Behavioral;

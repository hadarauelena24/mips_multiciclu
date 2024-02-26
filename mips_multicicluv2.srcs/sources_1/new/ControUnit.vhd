----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2023 12:44:46 AM
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
    Port ( OPCODE : in STD_LOGIC_VECTOR (5 downto 0);
           clk : in STD_LOGIC;
           enW : in STD_LOGIC;
           enR : in STD_LOGIC;
           PCG : out STD_LOGIC_VECTOR (3 downto 0);
           MEMG : out STD_LOGIC_VECTOR (4 downto 0);
           RFG : out STD_LOGIC_VECTOR (4 downto 0);
           ALUG : out STD_LOGIC_VECTOR (5 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is
component MicroSequencer is
    Port ( OPCODE : in STD_LOGIC_VECTOR (5 downto 0);
           clk: in STD_LOGIC;
           enW: in STD_LOGIC;
           enR: in STD_LOGIC;
           nextState : in STD_LOGIC_VECTOR (3 downto 0);
           nextAddr : out STD_LOGIC_VECTOR (3 downto 0));
end component MicroSequencer;

component MicroProgram is
    Port ( currentAddr : in STD_LOGIC_VECTOR (3 downto 0);
           PCGroup : out STD_LOGIC_VECTOR (3 downto 0);
           MEMGroup : out STD_LOGIC_VECTOR (4 downto 0);
           RFGroup : out STD_LOGIC_VECTOR (4 downto 0);
           ALUGroup : out STD_LOGIC_VECTOR (5 downto 0);
           nextState: out STD_LOGIC_VECTOR(3 downto 0));
end component MicroProgram;

component bistD is
    Port ( clk : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (3 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0));
end component bistD;

signal nextState,tempState,addr,nextAddr: std_logic_vector(3 downto 0):="0000";
begin
MS: MicroSequencer port map(OPCODE=>OPCODE,clk=>clk,enW=>enW,enR=>enR,nextState=>nextState,nextAddr=>addr);
PC: bistD port map(clk=>clk,d=>addr,q=>nextAddr);
MP: MicroProgram port map(currentAddr=>nextAddr,PCGroup=>PCG,MEMGroup=>MEMG,RFGroup=>RFG,ALUGroup=>ALUG,nextState=>nextState);

end Behavioral;

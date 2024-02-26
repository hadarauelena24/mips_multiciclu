----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2023 10:43:25 PM
-- Design Name: 
-- Module Name: MicroSequencer - Behavioral
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

entity MicroSequencer is
    Port ( OPCODE : in STD_LOGIC_VECTOR (5 downto 0);
           clk: in STD_LOGIC;
           enW: in STD_LOGIC;
           enR: in STD_LOGIC;
           nextState : in STD_LOGIC_VECTOR (3 downto 0);
           nextAddr : out STD_LOGIC_VECTOR (3 downto 0));
end MicroSequencer;

architecture Behavioral of MicroSequencer is

begin
process(OPCODE,nextState,clk,enW)
variable cnt: std_logic_vector(3 downto 0):="0000";
begin
if enR='1' then
    nextAddr<="0000";
elsif falling_edge(clk) then
    if enW='1' then
        case nextState is
            when "0000" => nextAddr <= "0001";
            when "0001" => case OPCODE is
                               when "000000" => nextAddr <= "0010";
                               when "000001" => nextAddr <= "0100";
                               when "000010" => nextAddr <= "0100";
                               when "000011" => nextAddr <= "1000";
                               when "000100" => nextAddr <= "1001";
                               when others => nextAddr <= "1111";
                           end case;
            when "0010" => case OPCODE is
                               when "000000" => nextAddr <= "0011";
                               when others => nextAddr <= "1111";
                           end case;
            when "0011" => case OPCODE is
                              when "000000" => nextAddr <= "0000";
                              when others => nextAddr <= "1111";
                           end case;
            when "0100" => case OPCODE is
                              when "000001" => nextAddr <= "0101";
                              when "000010" => nextAddr <= "0110";
                              when others => nextAddr <= "1111";
                           end case;
            when "0101" => case OPCODE is
                              when "000001" => nextAddr <= "0000";
                              when others => nextAddr <= "1111";
                           end case;
            when "0110" => case OPCODE is
                              when "000010" => nextAddr <= "0111";
                              when others => nextAddr <= "1111";
                           end case;
            when "0111" => case OPCODE is
                              when "000010" => nextAddr <= "0000";
                              when others => nextAddr <= "1111";
                           end case;
            when "1000" => case OPCODE is
                              when "000011" => nextAddr <= "0000";
                              when others => nextAddr <= "1111";
                           end case;
            when "1001" => case OPCODE is
                              when "000100" => nextAddr <= "0000";
                              when others => nextAddr <= "1111";
                              end case;
            when others => nextAddr <= "1111";
        end case;
    end if;
end if;
end process;

end Behavioral;

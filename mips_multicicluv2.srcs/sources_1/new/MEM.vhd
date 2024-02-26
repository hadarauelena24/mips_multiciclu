----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2023 09:53:51 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM is
Port ( clk : in STD_LOGIC;
       enable_W:in std_logic;
       enable_R:in std_logic;
       wd : in STD_LOGIC_VECTOR (31 downto 0);
       address : in STD_LOGIC_VECTOR (31 downto 0);
       memWrite : in STD_LOGIC;
       memRead : in STD_LOGIC;
       memData : out STD_LOGIC_VECTOR (31 downto 0));
end MEM;

architecture Behavioral of MEM is
type memRam is array(0 to 31) of std_logic_vector(31 downto 0);
signal RAM: memRam:=(b"000000_00010_00011_00100_00000_000000",--add r4,r2,r3
                     b"000001_00001_00100_0000000000000001",--sw r4,1(r1)
                     b"000010_00001_00101_0000000000000001",--lw r5,1(r1)
                     b"000011_00100_00101_0000000000000001",--beq r4,r5,1
                     b"000000_00010_00011_00100_00000_000000",--add r4,r2,r3
                     b"000100_00000000000000000000000000",--jmp 0
                     others=>x"0000000F");
signal outtemp: STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin

    process(clk,memWrite,memRead,enable_W,enable_R,address,wd)
    begin
    if enable_R='1' then
        outtemp<=(others=>'0');
    else
        if rising_edge(clk) then
            if enable_W='1' then
                if memWrite='1' then
                    RAM(conv_integer(address(4 downto 0)))<=wd;
                end if;
            end if;
        end if;
        if memRead='1' then
            outtemp<=RAM(conv_integer(address(4 downto 0)));
        end if;
    end if;
    end process;
    memData<=outtemp;
end Behavioral;

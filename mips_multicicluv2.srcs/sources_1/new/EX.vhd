----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2023 09:49:00 PM
-- Design Name: 
-- Module Name: EX - Behavioral
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

entity EX is
Port ( pc : in STD_LOGIC_VECTOR (31 downto 0);
           a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           ext_imm : in STD_LOGIC_VECTOR (31 downto 0);
           ext_imm_sll : in STD_LOGIC_VECTOR (31 downto 0);
           sa : in STD_LOGIC_VECTOR (4 downto 0);
           func : in STD_LOGIC_VECTOR (5 downto 0);
           instr : in STD_LOGIC_VECTOR (25 downto 0);
           ALUop : in STD_LOGIC_VECTOR (1 downto 0);
           ALUsrca : in STD_LOGIC;
           ALUsrcb : in STD_LOGIC_VECTOR (1 downto 0);
           zeroALU : out STD_LOGIC;
           ALUres : out STD_LOGIC_VECTOR (31 downto 0);
           jumpAdd:out std_logic_vector(31 downto 0));
end EX;

architecture Behavioral of EX is
signal muxsrca,muxsrcb:std_logic_vector(31 downto 0);
    signal ALUctrl:std_logic_vector(2 downto 0):="000";
    signal dif:std_logic_vector(31 downto 0);
    signal outtemp: STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
    --muxa
    muxsrca<=a when ALUsrca='1' else pc;
    
    --muxb
    process(ALUsrcb,b,ext_imm,ext_imm_sll)
    begin
    case ALUsrcb is
        when "00" => muxsrcb <= b;
        when "01" => muxsrcb <= x"00000001";
        when "10" => muxsrcb <= ext_imm;
        when others => muxsrcb <= ext_imm_sll;
    end case;
    end process;
    
    --proces ALUcontrol
    process(ALUop,func,sa)
    begin
    case ALUop is
        when "00"=>ALUctrl<="000"; --pc<=pc+1
        when "01"=>ALUctrl<="001"; --sub (a-b)
        when "10"=>case func is --instr tip r
                       when "00000"=>ALUctrl<="000";
                       when "00001"=>ALUctrl<="001";
                       when "00010"=>ALUctrl<="010";
                       when "00011"=>ALUctrl<="011";
                       when "00100"=>ALUctrl<="100";
                       when "00101"=>ALUctrl<="101";
                       when "00110"=>ALUctrl<="110";
                       when others=>ALUctrl<="111";
                   end case;
        when others=>ALUctrl<="000"; --nop
    end case;
    end process;
    
    --proces ALU
    process(sa,ALUctrl,muxsrca,muxsrcb)
    begin
    dif<=muxsrca-muxsrcb;
    if dif=0 then
        zeroALU<='1';
    else
        zeroALU<='0';
    end if;
    case ALUctrl is
        when "000"=>outtemp<=muxsrca+muxsrcb; --add
        when "001"=>outtemp<=muxsrca-muxsrcb; --sub
        when "010"=>if sa="00001" then outtemp<='0'&muxsrca(31 downto 1); --srl 1
                    else outtemp<=muxsrca;
                    end if;
        when "011"=>if sa="00001" then outtemp<=muxsrca(30 downto 0)&'0'; --sll 1
                    else outtemp<=muxsrca;
                    end if;
        when "100"=>outtemp<=muxsrca and muxsrcb; --and
        when "101"=>outtemp<=muxsrca or muxsrcb; --or
        when "110"=>outtemp<=muxsrca xor muxsrcb; --xor
        when others=> if sa="00001" then --sra 1
                        if muxsrca(15)='1' then outtemp<='1'&muxsrca(31 downto 1);
                        else outtemp<='0'&muxsrca(31 downto 1);
                        end if;
                      else outtemp<=muxsrca;
                      end if;
    end case;
    end process;
    --branchAdd<=pc+ext_imm;
    ALUres<=outtemp;
    jumpAdd<=pc(31 downto 28)&"00"&instr;
end Behavioral;

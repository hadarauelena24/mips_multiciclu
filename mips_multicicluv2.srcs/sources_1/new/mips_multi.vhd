----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 01:04:24 PM
-- Design Name: 
-- Module Name: mips_multi - Behavioral
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

entity mips_multi is
Port (clk: in std_logic;
      enW: in std_logic;
      enR: in std_logic;
      switchout: in std_logic_vector(3 downto 0);
      pcgo: out std_logic_vector(3 downto 0);
      memgo: out std_logic_vector(4 downto 0);
      rfgo: out std_logic_vector(4 downto 0);
      alugo: out std_logic_vector(5 downto 0);
      mips_out: out std_logic_vector(31 downto 0) );
end mips_multi;

architecture Behavioral of mips_multi is
component regPC is
    Port ( clk : in STD_LOGIC;
           enable_w : in STD_LOGIC;
           enable_r : in STD_LOGIC;
           enpc : in STD_LOGIC;
           muxadrurm : in STD_LOGIC_VECTOR (31 downto 0);
           pc : out STD_LOGIC_VECTOR (31 downto 0));
end component regPC;

signal enpc:std_logic:='1';
signal muxadrurm,pc:std_logic_vector(31 downto 0):=(others=>'0');

component muxpc_mem is
    Port ( iord : in STD_LOGIC;
           pc : in STD_LOGIC_VECTOR (31 downto 0);
           aluoutdata : in STD_LOGIC_VECTOR (31 downto 0);
           outmuxpc_mem : out STD_LOGIC_VECTOR (31 downto 0));
end component muxpc_mem;

--signal iord: std_logic:='0';
signal aluoutdata,outmuxpc_mem: std_logic_vector(31 downto 0):=(others=>'0');

component MEM is
Port ( clk : in STD_LOGIC;
       enable_W:in std_logic;
       enable_R:in std_logic;
       wd : in STD_LOGIC_VECTOR (31 downto 0);
       address : in STD_LOGIC_VECTOR (31 downto 0);
       memWrite : in STD_LOGIC;
       memRead : in STD_LOGIC;
       memData : out STD_LOGIC_VECTOR (31 downto 0));
end component MEM;

signal wdMem,memData:std_logic_vector(31 downto 0):=(others=>'0');
--signal memWrite: std_logic:='0';
--signal memRead: std_logic:='1';

component InstructionReg is
    Port ( clk : in STD_LOGIC;
           enable_W:in std_logic;
           enable_R: in STD_LOGIC;
           memData : in STD_LOGIC_VECTOR (31 downto 0);
           irWr : in STD_LOGIC;
           instr : out STD_LOGIC_VECTOR (31 downto 0));
end component InstructionReg;

--signal irWr:std_logic:='1';
signal instr:std_logic_vector(31 downto 0):=(others=>'0');

component memDataReg is
    Port ( clk : in STD_LOGIC;
           enable_W:in std_logic;
           enable_R:in std_logic;
           memData : in STD_LOGIC_VECTOR (31 downto 0);
           memRegWr : in STD_LOGIC;
           dataMem : out STD_LOGIC_VECTOR (31 downto 0));
end component memDataReg;

--signal memRegWr: std_logic:='0';
signal dataMem: std_logic_vector(31 downto 0):=(others=>'0');

component muxregdst is
    Port ( regDst : in STD_LOGIC;
           instr20_16_rt : in STD_LOGIC_VECTOR (4 downto 0);
           instr15_11_rd : in STD_LOGIC_VECTOR (4 downto 0);
           wa : out STD_LOGIC_VECTOR (4 downto 0));
end component muxregdst;

--signal regDst: std_logic:='0';
signal wa: std_logic_vector(4 downto 0):=(others=>'0');

component mux_wrdata is
    Port ( mem2reg : in STD_LOGIC;
           aluoutdata : in STD_LOGIC_VECTOR (31 downto 0);
           memData_reg : in STD_LOGIC_VECTOR (31 downto 0);
           wd : out STD_LOGIC_VECTOR (31 downto 0));
end component mux_wrdata;

--signal mem2reg: std_logic:='0';
signal wdReg: std_logic_vector(31 downto 0):=(others=>'0');

component RF is
    Port ( RA1 : in STD_LOGIC_VECTOR (4 downto 0);
           RA2 : in STD_LOGIC_VECTOR (4 downto 0);
           WA : in STD_LOGIC_VECTOR (4 downto 0);
           WD : in STD_LOGIC_VECTOR (31 downto 0);
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           enable_w: in std_logic;
           enable_r: in std_logic;
           RegWr : in STD_LOGIC);
end component RF;
signal rd1,rd2: std_logic_vector(31 downto 0):=(others=>'0');
--signal regWr: std_logic:='0';

component regA is
    Port ( rd1 : in STD_LOGIC_VECTOR (31 downto 0);
           wa : in STD_LOGIC;
           a : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           enable_W : in STD_LOGIC;
           enable_R : in STD_LOGIC);
end component regA;

component regB is
    Port ( clk : in STD_LOGIC;
           enable_W : in STD_LOGIC;
           enable_R : in STD_LOGIC;
           rd2 : in STD_LOGIC_VECTOR (31 downto 0);
           wb : in STD_LOGIC;
           b : out STD_LOGIC_VECTOR (31 downto 0));
end component regB;

signal a,b: std_logic_vector(31 downto 0):=(others=>'0');
--signal waen,wben:std_logic:='0';
component signext is
    Port ( instr15_0 : in STD_LOGIC_VECTOR (15 downto 0);
           ext_imm : out STD_LOGIC_VECTOR (31 downto 0));
end component signext;

signal ext_imm,ext_imm_sll: std_logic_vector(31 downto 0):=(others=>'0');

--component sll2 is
--    Port ( ext_imm : in STD_LOGIC_VECTOR (31 downto 0);
--           ext_imm_sll : out STD_LOGIC_VECTOR (31 downto 0));
--end component sll2;

component EX is
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
end component EX;
signal zeroALU: std_logic:='0';
signal ALUres,jumpAdd:std_logic_vector(31 downto 0):=(others=>'0');

component ControlUnit is
    Port ( OPCODE : in STD_LOGIC_VECTOR (5 downto 0);
           clk : in STD_LOGIC;
           enW : in STD_LOGIC;
           enR : in STD_LOGIC;
           PCG : out STD_LOGIC_VECTOR (3 downto 0);
           MEMG : out STD_LOGIC_VECTOR (4 downto 0);
           RFG : out STD_LOGIC_VECTOR (4 downto 0);
           ALUG : out STD_LOGIC_VECTOR (5 downto 0));
end component ControlUnit;

signal pcg: std_logic_vector(3 downto 0):="1000";
signal memg: std_logic_vector(4 downto 0):="01010";
signal rfg: std_logic_vector(4 downto 0):="00011";
signal alug: std_logic_vector(5 downto 0):="000011";

component regALU is
    Port ( clk : in STD_LOGIC;
           enable_W : in STD_LOGIC;
           enable_R : in STD_LOGIC;
           enALUOut : in STD_LOGIC;
           alures : in STD_LOGIC_VECTOR (31 downto 0);
           aluoutdata : out STD_LOGIC_VECTOR (31 downto 0));
end component regALU;

component mux_srcpc is
    Port ( pcsrc : in STD_LOGIC_VECTOR (1 downto 0);
           jmpAdd : in STD_LOGIC_VECTOR (31 downto 0);
           brAdd : in STD_LOGIC_VECTOR (31 downto 0);
           aluoutdata : in STD_LOGIC_VECTOR (31 downto 0);
           srcpc : out STD_LOGIC_VECTOR (31 downto 0));
end component mux_srcpc;
begin
enpc<=pcg(3) or (pcg(2) and zeroALU);
program_counter: regPC port map(clk=>clk,enable_w=>enW,enable_r=>enR,enpc=>enpc,muxadrurm=>muxadrurm,pc=>pc);
instr_or_data: muxpc_mem port map(iord=>memg(2),pc=>pc,aluoutdata=>aluoutdata,outmuxpc_mem=>outmuxpc_mem);
memory: MEM port map(clk=>clk,enable_W=>enW,enable_R=>enR,wd=>b,address=>outmuxpc_mem,memWrite=>memg(4),memRead=>memg(3),memData=>memData);
instruction_register: InstructionReg port map(clk=>clk,enable_W=>enW,enable_R=>enR,memData=>memData,irWr=>memg(1),instr=>instr);
memory_data_register: memDataReg port map(clk=>clk,enable_W=>enW,enable_R=>enR,memData=>memData,memRegWr=>memg(0),dataMem=>dataMem);
UC: ControlUnit port map(OPCODE=>instr(31 downto 26),clk=>clk,enW=>enW,enR=>enR,PCG=>pcg,MEMG=>memg,RFG=>rfg,ALUG=>alug);
mux_reg_dst: muxregdst port map(regDst=>rfg(3),instr20_16_rt=>instr(20 downto 16),instr15_11_rd=>instr(15 downto 11),wa=>wa);
mux_wr_data: mux_wrdata port map(mem2reg=>rfg(2),aluoutdata=>aluoutdata,memData_reg=>dataMem,wd=>wdReg);
register_file: RF port map(RA1=>instr(25 downto 21),RA2=>instr(20 downto 16),WA=>wa,WD=>wdReg,RD1=>rd1,RD2=>rd2,clk=>clk,enable_w=>enW,enable_R=>enR,RegWr=>rfg(4));
registruA: regA port map(rd1=>rd1,wa=>rfg(1),a=>a,clk=>clk,enable_W=>enW,enable_R=>enR);
registruB: regB port map(clk=>clk,enable_W=>enW,enable_R=>enR,rd2=>rd2,wb=>rfg(0),b=>b);
sign_extend: signext port map(instr15_0=>instr(15 downto 0),ext_imm=>ext_imm);
--shift_logical_left_2: sll2 port map(ext_imm=>ext_imm,ext_imm_sll=>ext_imm_sll);
execution: EX port map(pc=>pc,a=>a,b=>b,ext_imm=>ext_imm,ext_imm_sll=>ext_imm,sa=>instr(10 downto 6),func=>instr(5 downto 0),instr=>instr(25 downto 0),ALUop=>alug(5 downto 4),ALUsrca=>alug(3),ALUsrcb=>alug(2 downto 1),zeroALU=>zeroALU,ALUres=>ALUres,jumpAdd=>jumpAdd);
registruALU: regALU port map(clk=>clk,enable_W=>enW,enable_R=>enR,enALUOut=>alug(0),alures=>ALUres,aluoutdata=>aluoutdata);
mux_pc_source: mux_srcpc port map(pcsrc=>pcg(1 downto 0),jmpAdd=>jumpAdd,brAdd=>aluoutdata,aluoutdata=>ALUres,srcpc=>muxadrurm);
process(switchout)
variable tempout:STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
case switchout is
    when "0000" => tempout := pc;
    when "0001" => tempout := outmuxpc_mem;
    when "0010" => tempout := memData;
    when "0011" => tempout := instr;
    when "0100" => tempout := dataMem;
    when "0101" => tempout := "000000000000000000000000000"&wa;
    when "0110" => tempout := wdReg;
    when "0111" => tempout := a;
    when "1000" => tempout := b;
    when "1001" => tempout := ALUres;
    when "1010" => tempout := aluoutdata;
    when "1011" => tempout := "0000000000000000000000000000000"&zeroALU;
    when others => tempout := (others=>'0');
--    when "1100" => tempout := dataMem;
--    when "1101" => tempout := a;
--    when "1110" => tempout := b;
--    when "1111" => tempout := aluoutdata;
end case;
mips_out<=tempout;
end process;
pcgo<=pcg;
memgo<=memg;
rfgo<=rfg;
alugo<=alug;
end Behavioral;

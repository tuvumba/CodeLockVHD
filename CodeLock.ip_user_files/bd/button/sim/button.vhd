--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
--Date        : Fri Apr 21 00:31:49 2023
--Host        : DESKTOP-TH8J4U8 running 64-bit major release  (build 9200)
--Command     : generate_target button.bd
--Design      : button
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity button is
  port (
    clk : in STD_LOGIC;
    d : in STD_LOGIC;
    hrana : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of button : entity is "button,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=button,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=4,numReposBlks=4,numNonXlnxBlks=4,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of button : entity is "button.hwdef";
end button;

architecture STRUCTURE of button is
  component button_dff_0_0 is
  port (
    d : in STD_LOGIC;
    clk : in STD_LOGIC;
    q : out STD_LOGIC
  );
  end component button_dff_0_0;
  component button_inv_0_0 is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC
  );
  end component button_inv_0_0;
  component button_and_0_0 is
  port (
    I0 : in STD_LOGIC;
    I1 : in STD_LOGIC;
    O : out STD_LOGIC
  );
  end component button_and_0_0;
  component button_debounce_0_1 is
  port (
    clk : in STD_LOGIC;
    tl_in : in STD_LOGIC;
    tl_out : out STD_LOGIC
  );
  end component button_debounce_0_1;
  signal and_0_O : STD_LOGIC;
  signal clk_1 : STD_LOGIC;
  signal d_1 : STD_LOGIC;
  signal debounce_0_tl_out : STD_LOGIC;
  signal dff_0_q : STD_LOGIC;
  signal inv_0_O : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of hrana : signal is "xilinx.com:signal:data:1.0 DATA.HRANA DATA";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of hrana : signal is "XIL_INTERFACENAME DATA.HRANA, LAYERED_METADATA undef";
begin
  clk_1 <= clk;
  d_1 <= d;
  hrana <= and_0_O;
and_0: component button_and_0_0
     port map (
      I0 => debounce_0_tl_out,
      I1 => inv_0_O,
      O => and_0_O
    );
debounce_0: component button_debounce_0_1
     port map (
      clk => clk_1,
      tl_in => d_1,
      tl_out => debounce_0_tl_out
    );
dff_0: component button_dff_0_0
     port map (
      clk => clk_1,
      d => debounce_0_tl_out,
      q => dff_0_q
    );
inv_0: component button_inv_0_0
     port map (
      I => dff_0_q,
      O => inv_0_O
    );
end STRUCTURE;

--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
--Date        : Fri Apr 21 00:31:49 2023
--Host        : DESKTOP-TH8J4U8 running 64-bit major release  (build 9200)
--Command     : generate_target button_wrapper.bd
--Design      : button_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity button_wrapper is
  port (
    clk : in STD_LOGIC;
    d : in STD_LOGIC;
    hrana : out STD_LOGIC
  );
end button_wrapper;

architecture STRUCTURE of button_wrapper is
  component button is
  port (
    hrana : out STD_LOGIC;
    clk : in STD_LOGIC;
    d : in STD_LOGIC
  );
  end component button;
begin
button_i: component button
     port map (
      clk => clk,
      d => d,
      hrana => hrana
    );
end STRUCTURE;

library IEEE;
use IEEE.std_logic_1164.all;

library xil_defaultlib;
use xil_defaultlib.all;

entity lockTest_vhdl is
   port (
      led0     :  out std_logic;
      led1     :  out std_logic;
      resetLED :  out std_logic;
      unlock   :  out std_logic
   );
end entity lockTest_vhdl;

architecture Behavioral of lockTest_vhdl is
	component automata_vhdl
		port (
			a      :  in  std_logic;
			b      :  in  std_logic;
			c      :  in  std_logic;
			clk    :  in  std_logic;
			raw_a  :  in  std_logic;
			raw_b  :  in  std_logic;
			raw_c  :  in  std_logic;
			reset  :  in  std_logic;
			led0   :  out std_logic;
			led1   :  out std_logic;
			unlock :  out std_logic
		);
	end component;

	component code_lock_test
		port (
			Lock  :  in  std_logic;
			A     :  out std_logic;
			B     :  out std_logic;
			C     :  out std_logic;
			Clock :  out std_logic;
			Reset :  out std_logic
		);
	end component;



      signal automata_vhdl_0_led0   :    std_logic;          
      signal automata_vhdl_0_led1   :    std_logic;          
      signal automata_vhdl_0_unlock :    std_logic;          
      signal code_lock_test_0_A     :    std_logic;          
      signal code_lock_test_0_B     :    std_logic;          
      signal code_lock_test_0_C     :    std_logic;          
      signal code_lock_test_0_Clock :    std_logic;          
      signal code_lock_test_0_Reset :    std_logic;          
      signal gnd_0_O                :    std_logic;          
begin
	led0 <= automata_vhdl_0_led0;
	led1 <= automata_vhdl_0_led1;
	resetLED <= code_lock_test_0_Reset;
	unlock <= automata_vhdl_0_unlock;


	-- automata_vhdl_0
	inst_automata_vhdl_0 : automata_vhdl
		port map (
			a      =>  code_lock_test_0_A,
			b      =>  code_lock_test_0_B,
			c      =>  code_lock_test_0_C,
			clk    =>  code_lock_test_0_Clock,
			raw_a  =>  gnd_0_O,
			raw_b  =>  gnd_0_O,
			raw_c  =>  gnd_0_O,
			reset  =>  code_lock_test_0_Reset,
			led0   =>  automata_vhdl_0_led0,
			led1   =>  automata_vhdl_0_led1,
			unlock =>  automata_vhdl_0_unlock
		);

	-- code_lock_test_0
	inst_code_lock_test_0 : code_lock_test
		port map (
			Lock  =>  automata_vhdl_0_unlock,
			A     =>  code_lock_test_0_A,
			B     =>  code_lock_test_0_B,
			C     =>  code_lock_test_0_C,
			Clock =>  code_lock_test_0_Clock,
			Reset =>  code_lock_test_0_Reset
		);

	-- gnd_0
	gnd_0_O <= '0';

end Behavioral;

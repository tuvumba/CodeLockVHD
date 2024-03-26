library IEEE;
use IEEE.std_logic_1164.all;

library xil_defaultlib;
use xil_defaultlib.all;

entity codeLock_vhdl is
   port (
      btn_a  :  in  std_logic;
      btn_b  :  in  std_logic;
      btn_c  :  in  std_logic;
      clk    :  in  std_logic;
      reset  :  in  std_logic;
      led0   :  out std_logic;
      led1   :  out std_logic;
      unlock :  out std_logic
   );
end entity codeLock_vhdl;

architecture Behavioral of codeLock_vhdl is
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

	component button_vhdl
		port (
			clk   :  in  std_logic;
			d     :  in  std_logic;
			hrana :  out std_logic
		);
	end component;



      signal automata_vhdl_0_led0   :    std_logic;          
      signal automata_vhdl_0_led1   :    std_logic;          
      signal automata_vhdl_0_unlock :    std_logic;          
      signal btn_a_1                :    std_logic;          
      signal btn_b_1                :    std_logic;          
      signal btn_c_1                :    std_logic;          
      signal button_vhdl_0_hrana    :    std_logic;          
      signal button_vhdl_1_hrana    :    std_logic;          
      signal button_vhdl_2_hrana    :    std_logic;          
      signal clk_1                  :    std_logic;          
      signal reset_1                :    std_logic;          
begin
	btn_a_1 <= btn_a;
	btn_b_1 <= btn_b;
	btn_c_1 <= btn_c;
	clk_1 <= clk;
	reset_1 <= reset;
	led0 <= automata_vhdl_0_led0;
	led1 <= automata_vhdl_0_led1;
	unlock <= automata_vhdl_0_unlock;


	-- automata_vhdl_0
	inst_automata_vhdl_0 : automata_vhdl
		port map (
			a      =>  button_vhdl_0_hrana,
			b      =>  button_vhdl_1_hrana,
			c      =>  button_vhdl_2_hrana,
			clk    =>  clk_1 ,
			raw_a  =>  btn_a_1,
			raw_b  =>  btn_b_1,
			raw_c  =>  btn_c_1,
			reset  =>  reset_1,
			led0   =>  automata_vhdl_0_led0,
			led1   =>  automata_vhdl_0_led1,
			unlock =>  automata_vhdl_0_unlock
		);

	-- button_vhdl_0
	inst_button_vhdl_0 : button_vhdl
		port map (
			clk   =>  clk_1,
			d     =>  btn_a_1,
			hrana =>  button_vhdl_0_hrana
		);

	-- button_vhdl_1
	inst_button_vhdl_1 : button_vhdl
		port map (
			clk   =>  clk_1,
			d     =>  btn_b_1,
			hrana =>  button_vhdl_1_hrana
		);

	-- button_vhdl_2
	inst_button_vhdl_2 : button_vhdl
		port map (
			clk   =>  clk_1,
			d     =>  btn_c_1,
			hrana =>  button_vhdl_2_hrana
		);

end Behavioral;

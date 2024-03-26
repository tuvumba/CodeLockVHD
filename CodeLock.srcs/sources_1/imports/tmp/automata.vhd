library IEEE;
use IEEE.std_logic_1164.all;

library xil_defaultlib;
use xil_defaultlib.all;

entity automata_vhdl is
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
end entity automata_vhdl;

architecture Behavioral of automata_vhdl is
	component next_state_logic
		port (
			a    :  in  std_logic;
			b    :  in  std_logic;
			c    :  in  std_logic;
			q0   :  in  std_logic;
			q1   :  in  std_logic;
			qout :  in  std_logic;
			d0   :  out std_logic;
			d1   :  out std_logic;
			dout :  out std_logic
		);
	end component;

	component debounce
		generic (
			width: integer := 22
		);
		port (
			clk    : in  std_logic;
			tl_in  : in  std_logic;
			tl_out : out std_logic
		);
	end component;


      signal a_1                     :    std_logic;           
      signal and_0_O                 :    std_logic;           
      signal b_1                     :    std_logic;           
      signal c_1                     :    std_logic;           
      signal clk_1                   :    std_logic;           
      signal debounce_0_tl_out       :    std_logic;           
      signal debounce_1_tl_out       :    std_logic;           
      signal debounce_2_tl_out       :    std_logic;           
      signal dff_0_q                 :    std_logic;           
      signal dff_1_q                 :    std_logic;           
      signal dff_2_q                 :    std_logic;           
      signal next_state_logic_0_d0   :    std_logic;           
      signal next_state_logic_0_d1   :    std_logic;           
      signal next_state_logic_0_dout :    std_logic;           
      signal or_0_O                  :    std_logic;           
      signal or_1_O                  :    std_logic;           
      signal raw_a_1                 :    std_logic;           
      signal raw_b_1                 :    std_logic;           
      signal raw_c_1                 :    std_logic;           
      signal reset_1                 :    std_logic;           
      signal xor_0_O                 :    std_logic;           
begin
	a_1 <= a;
	b_1 <= b;
	c_1 <= c;
	clk_1 <= clk;
	raw_a_1 <= raw_a;
	raw_b_1 <= raw_b;
	raw_c_1 <= raw_c;
	reset_1 <= reset;
	led0 <= dff_0_q;
	led1 <= dff_1_q;
	unlock <= dff_2_q;


	-- and_0
	and_0_O <= xor_0_O and or_1_O;

	-- debounce_0
	debounce_0 : debounce
		generic map (
			width => 22
		)
		port map (
			clk	=> clk_1,
			tl_in	=> raw_a_1,
			tl_out	=> debounce_0_tl_out
		);

	-- debounce_1
	debounce_1 : debounce
		generic map (
			width => 22
		)
		port map (
			clk	=> clk_1,
			tl_in	=> raw_b_1,
			tl_out	=> debounce_1_tl_out
		);

	-- debounce_2
	debounce_2 : debounce
		generic map (
			width => 22
		)
		port map (
			clk	=> clk_1,
			tl_in	=> raw_c_1,
			tl_out	=> debounce_2_tl_out
		);

	-- dff_0
	process (clk_1)
	begin
		if rising_edge(clk_1) then
			if or_0_O = '1' then
				dff_0_q <= '0';
			else
				dff_0_q <= next_state_logic_0_d0;
			end if;
		end if;
	end process;

	-- dff_1
	process (clk_1)
	begin
		if rising_edge(clk_1) then
			if or_0_O = '1' then
				dff_1_q <= '0';
			else
				dff_1_q <= next_state_logic_0_d1;
			end if;
		end if;
	end process;

	-- dff_2
	process (clk_1)
	begin
		if rising_edge(clk_1) then
			if or_0_O = '1' then
				dff_2_q <= '0';
			else
				dff_2_q <= next_state_logic_0_dout;
			end if;
		end if;
	end process;

	-- next_state_logic_0
	inst_next_state_logic_0 : next_state_logic
		port map (
			a    =>  a_1 ,
			b    =>  b_1 ,
			c    =>  c_1 ,
			q0   =>  dff_0_q,
			q1   =>  dff_1_q,
			qout =>  dff_2_q,
			d0   =>  next_state_logic_0_d0,
			d1   =>  next_state_logic_0_d1,
			dout =>  next_state_logic_0_dout
		);

	-- or_0
	or_0_O <= and_0_O or reset_1;

	-- or_1
	or_1_O <= debounce_0_tl_out or debounce_1_tl_out or debounce_2_tl_out;

	-- xor_0
	xor_0_O <= not(debounce_0_tl_out xor debounce_1_tl_out xor debounce_2_tl_out);

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity debounce is
    generic (
		width: integer := 22 -- 100 MHz clock -> 4 - simulation (90 ns); 22 - synthesis (ca. 20 ms)
	);
    port (
		clk : in STD_LOGIC;
        tl_in : in STD_LOGIC;
        tl_out : out STD_LOGIC
	);
end entity debounce;

architecture Behavioral of debounce is

signal cnt       : std_logic_vector(width-1 downto 0) := (others => '0');
signal reset, ce : std_logic := '0';
signal tl_prev   : std_logic := '0';


begin

    counter: process(clk) begin
        if rising_edge(clk) then 
            if (reset = '1') then
                cnt <= (others => '0');
            elsif (ce = '1') then
                cnt <= cnt + 1;
            end if;
        end if;
    end process;

    process(clk) begin
        if rising_edge(clk) then
            if (tl_prev /= tl_in) then
                reset <= '1';
            else 
                reset <= '0';
            end if;
        end if;
    end process;
                
    process(clk) begin
        if rising_edge(clk) then
            if (reset = '1') then
                tl_prev <= tl_in;
            end if;
        end if;
    end process;
                
    process(clk) begin
        if rising_edge(clk) then
            if ((cnt(width-1) = '1') and (cnt(0) = '0')) then
                tl_out <= tl_prev;
            end if;
        end if;
    end process;
                

    ce <= '0' when ((cnt(width-1) = '1') and (cnt(0) = '1'))
                else '1';

end Behavioral;


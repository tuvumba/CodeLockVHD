library IEEE;
use IEEE.std_logic_1164.all;

library xil_defaultlib;
use xil_defaultlib.all;

entity button_vhdl is
   port (
      clk   :  in  std_logic;
      d     :  in  std_logic;
      hrana :  out std_logic
   );
end entity button_vhdl;

architecture Behavioral of button_vhdl is
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


      signal and_0_O           :    std_logic;     
      signal clk_1             :    std_logic;     
      signal d_1               :    std_logic;     
      signal debounce_0_tl_out :    std_logic;     
      signal dff_0_q           :    std_logic;     
      signal inv_0_O           :    std_logic;     
begin
	clk_1 <= clk;
	d_1 <= d;
	hrana <= and_0_O;


	-- and_0
	and_0_O <= debounce_0_tl_out and inv_0_O;

	-- debounce_0
	debounce_0 : debounce
		generic map (
			width => 22
		)
		port map (
			clk	=> clk_1,
			tl_in	=> d_1,
			tl_out	=> debounce_0_tl_out
		);

	-- dff_0
	process (clk_1)
	begin
		if rising_edge(clk_1) then
			dff_0_q <= debounce_0_tl_out;
		end if;
	end process;

	-- inv_0
	inv_0_O <= not(dff_0_q);

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


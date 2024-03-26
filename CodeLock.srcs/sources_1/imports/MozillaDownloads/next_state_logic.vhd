library IEEE;
use IEEE.std_logic_1164.all;

entity next_state_logic is
    port(
        a : in  std_logic;
        b : in  std_logic;
        c : in  std_logic;
        q0 : in std_logic;
        q1 : in std_logic;
        qout : in std_logic;
        d0 : out std_logic;
        d1 : out std_logic;
        dout : out std_logic
    );
end next_state_logic;

architecture behavioral of next_state_logic is
begin

-- you can use the following operators:
-- ----------------------------------
-- | operator |   example           |
-- ----------------------------------
-- |    and   | a and b and c       |
-- |    or    | a or b or (c and d) |
-- |    not   | not a               |
-- ----------------------------------
-- there is no priority of operators. be sure to use brackets!
-- example:
--   given: f(a, b, c) = a * #b * #c + a * b
--   in VHDL: f <= (a and (not b) and (not c)) or (a and b)

-- ve vyrazech pouzivejte nasledujici operatory:
-- ----------------------------------
-- | operator | priklad pouziti     |
-- ----------------------------------
-- |    and   | a and b and c       |
-- |    or    | a or b or (c and d) |
-- |    not   | not a               |
-- ----------------------------------
-- pouzivejte zavorky!
-- priklad:
--   zadani: f(a, b, c) = a * #b * #c + a * b
--   ve VHDL: f <= (a and (not b) and (not c)) or (a and b)

    d0 <= (a and q0 and (not q1)) or (c and (not q0) and q1) or ((not a) and (not b) and (not c) and q0);
    d1 <= (a and (not q0) and (not q1)) or (a and q0 and (not q1)) or ((not a) and (not b) and (not c) and q1);
    dout <= (b and q1 and q0) or ((not a) and (not b) and (not c) and qout);

end;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2020 13:18:34
-- Design Name: 
-- Module Name: Clock_Divider - Behavioral
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

entity Clock_Divider is
    Port ( CLK_I : in STD_LOGIC;
           CLK_O : out STD_LOGIC;
           CLK_O_36 : out STD_LOGIC);
end Clock_Divider;

architecture Behavioral of Clock_Divider is
--fOR 15KHZ*20
SIGNAL clk_divided : STD_LOGIC := '0';
SIGNAL clk_counter : integer := 1;
--FOR 36HZ
SIGNAL clk_divided_36 : STD_LOGIC := '0';
SIGNAL clk_counter_36 : integer := 1;
begin


clock_divider: PROCESS ( clk_I)
BEGIN
    IF(rising_edge(clk_I)) THEN
        IF clk_counter = 167 THEN
            clk_divided <= not clk_divided;
            clk_counter <= 1;
        ELSE
            clk_counter <= clk_counter + 1;
        END IF;
    END IF;
    CLK_O <= clk_divided;
END PROCESS;
clock_divider_36: PROCESS ( clk_I)
BEGIN
    IF(rising_edge(clk_I)) THEN
        IF clk_counter_36 = 1388889 THEN
            clk_divided_36 <= not clk_divided_36;
            clk_counter_36 <= 1;
        ELSE
            clk_counter_36 <= clk_counter_36 + 1;
        END IF;
    END IF;
    CLK_O_36 <= clk_divided_36;
END PROCESS;


end Behavioral;

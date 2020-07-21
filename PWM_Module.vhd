----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2020 20:17:15
-- Design Name: 
-- Module Name: PWM_Module - Behavioral
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
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWM_Module is
    Port ( clock_15khz : in STD_LOGIC;
           PWM : out STD_LOGIC);
end PWM_Module;

architecture Behavioral of PWM_Module is
signal counter : integer := 1; 
signal PWM_m : std_logic := '1'; 

begin
PWM <= PWM_m;
process(clock_15khz)
begin
    if(rising_edge(clock_15khz))then
    counter <= counter + 1;
        if (counter = 2)then
           PWM_m <= '0';
        end if;    
        if (counter = 1)then
           PWM_m <= '1';
        end if;       
        if (counter = 20)then
           PWM_m <= '0';
           counter <= 1;
        end if;  
    end if;
end process;


end Behavioral;

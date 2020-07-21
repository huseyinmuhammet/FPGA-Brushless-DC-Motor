----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2020 16:14:38
-- Design Name: 
-- Module Name: HallSensor - Behavioral
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

entity HallSensor is
  Port (error_led  : out STD_LOGIC;
        PWM : in STD_LOGIC;
        start : in STD_LOGIC;
        hall_data: in STD_LOGIC_VECTOR(2 downto 0);
        clk_300khz : in STD_LOGIC ;
        EN1 : out STD_LOGIC;
        IN1 : out STD_LOGIC;
        EN2 : out STD_LOGIC;
        IN2 : out STD_LOGIC;
        EN3 : out STD_LOGIC;
        IN3 : out STD_LOGIC);
end HallSensor;

architecture Behavioral of HallSensor is

SIGNAL clk_counter: integer := 1;
SIGNAL clk_36hz: std_logic := '0';
SIGNAL temp_hall: std_logic_vector(2 downto 0);


SIGNAL EN1_I :  STD_LOGIC;
SIGNAL        IN1_I :  STD_LOGIC;
SIGNAL        EN2_I : STD_LOGIC;
SIGNAL        IN2_I :  STD_LOGIC;
SIGNAL       EN3_I :  STD_LOGIC;
SIGNAL        IN3_I :  STD_LOGIC;

SIGNAL EN1_C :  STD_LOGIC;
SIGNAL        IN1_C :  STD_LOGIC;
SIGNAL        EN2_C : STD_LOGIC;
SIGNAL        IN2_C :  STD_LOGIC;
SIGNAL       EN3_C :  STD_LOGIC;
SIGNAL        IN3_C :  STD_LOGIC;

signal counter: integer := 1;
signal counter2: integer := 1;
signal counter3: integer := 1;
begin

process (CLK_300khz)
begin
if (start = '1')then
    
    if (rising_edge(CLK_300khz))then
    if(counter3 < 7)then
       if(counter = 1)then
            IN1_I <= PWM;
            IN2_I <= '0'; 
            IN3_I <= '0'; 
            EN1_I <= '1';
            EN2_I <= '1';
            EN3_I <= '0';
            counter2 <= counter2 + 1;
            if(counter2 = 8485)then    
                counter <= counter +1;
                counter2 <= 1;
            end if;
        end if;
        if(counter = 2)then
            IN1_I <= '0';
            IN2_I <= '0'; 
            IN3_I <= PWM; 
            EN1_I <= '1';
            EN2_I <= '0';
            EN3_I <= '1';
            counter2 <= counter2 + 1;
            if(counter2 = 8485)then    
                counter <= counter +1;
                counter2 <= 1;
            end if;
        end if;
        if(counter = 3)then
            IN1_I <= '0';
            IN2_I <= '0'; 
            IN3_I <= PWM; 
            EN1_I <= '0';
            EN2_I <= '1';
            EN3_I <= '1';
            counter2 <= counter2 + 1;
            if(counter2 = 8485)then    
                counter <= counter +1;
                counter2 <= 1;
            end if;
        end if;
        if(counter = 4)then
            IN1_I <= '0';
            IN2_I <= PWM; 
            IN3_I <= '0'; 
            EN1_I <= '0';
            EN2_I <= '1';
            EN3_I <= '1';
            counter2 <= counter2 + 1;
            if(counter2 = 8485)then    
                counter <= counter +1;
                counter2 <= 1;
            end if;
        end if;
        if(counter = 5)then
            IN1_I <= PWM;
            IN2_I <= '0'; 
            IN3_I <= '0'; 
            EN1_I <= '1';
            EN2_I <= '0';
            EN3_I <= '1';
            counter2 <= counter2 + 1;
            if(counter2 = 8485)then    
                counter <= counter +1;
                counter2 <= 1;
            end if;
        end if;
        if(counter = 6)then
            IN1_I <= '0';
            IN2_I <= PWM; 
            IN3_I <= '0'; 
            EN1_I <= '1';
            EN2_I <= '1';
            EN3_I <= '0';
            counter2 <= counter2 + 1;
            if(counter2 = 8485)then    
                counter <= 1;
                counter2 <= 1;
                counter3 <= counter3 + 1;                        
            end if;
            end if;
       end if;     
       
    end if;     
end if;
end process;

--clock divider
process(clk_300khz)
begin 
 IF(rising_edge(clk_300khz)) THEN
        IF clk_counter = 4167 THEN
            clk_36hz <= not clk_36hz;
            clk_counter <= 1;
        ELSE
            clk_counter <= clk_counter + 1;
        END IF;
    END IF;
end process;

process(clk_36hz)
begin 
    if(start='1')then
    if (rising_edge(clk_36hz))then
        temp_hall <= hall_data;
    end if;
    end if;
end process;

process(clk_300khz)
begin 
   if(start = '1')then
    if(rising_edge(clk_300khz))then
        case temp_hall is
            when "000" =>
                IN1_C <= '0';
                EN1_C <= '0';
                IN2_C <= '0';
                EN2_C <= '0';
                IN3_C <= '0';
                EN3_C <= '0';
                error_led <= '1';  
            when "001" => 
                IN1_C <= PWM;
                EN1_C <= '1';
                IN2_C <= '0';
                EN2_C <= '1';
                IN3_C <= '0';
                EN3_C <= '0'; 
                error_led <= '0';
            when "010" => 
                IN1_C <= '0';
                EN1_C <= '1';
                IN2_C <= '0';
                EN2_C <= '0';
                IN3_C <= PWM;
                EN3_C <= '1';
                error_led <= '0';
            when "011" => 
                IN1_C <= '0';
                EN1_C <= '0';
                IN2_C <= '0';
                EN2_C <= '1';
                IN3_C <= PWM;
                EN3_C <= '1';
                error_led <= '0';
            when "100" =>
                IN1_C <= '0';
                EN1_C <= '0';
                IN2_C <= PWM;
                EN2_C <= '1';
                IN3_C <= '0';
                EN3_C <= '1';
                 error_led <= '0';
            when "101" => 
                IN1_C <= PWM;
                EN1_C <= '1';
                IN2_C <= '0';
                EN2_C <= '0';
                IN3_C <= '0';
                EN3_C <= '1';
               error_led <= '0';
            when "110" => 
                IN1_C <= '0';
                EN1_C <= '1';
                IN2_C <= PWM;
                EN2_C <= '1';
                IN3_C <= '0';
                EN3_C <= '0';
                error_led <= '0';
            when "111" => 
                IN1_C <= '0';
                EN1_C <= '0';
                IN2_C <= '0';
                EN2_C <= '0';
                IN3_C <= '0';
                EN3_C <= '0';
                error_led <= '1';
            when others => 
                IN1_C <= '0';
                EN1_C <= '0';
                IN2_C <= '0';
                EN2_C <= '0';
                IN3_C <= '0';
                EN3_C <= '0';
               
    end case;
    end if;
    end if;
end process;

process(clk_300khz)
begin
   if(rising_edge(clk_300khz))then
    if(start = '1')then
    if (counter3 < 7)then
         IN1 <=IN1_I;
         EN1 <= EN1_I;
         IN2 <= IN2_I;
         EN2 <=  EN2_I;
         IN3 <= IN3_I;
         EN3 <= EN3_I;
    else
        IN1 <=IN1_C;
         EN1 <= EN1_C;
         IN2 <= IN2_C;
         EN2 <=  EN2_C;
         IN3 <= IN3_C;
         EN3 <= EN3_C;
    end if;
    end if;
    end if;
end process;

end Behavioral;

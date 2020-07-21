----------------------------------------------------------------------------------
-- Company: Student
-- Engineer: Hüseyin Görgülü
-- 
-- Create Date: 01.05.2020 23:04:45
-- Design Name: Designing Brushless DC Motor
-- Module Name: FSM_Motor - Behavioral
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

entity FSM_Motor is
    Port ( hall_data : in STD_LOGIC_vector(2 downto 0);	    --Input data coming from Hall Effect Sensor
           error_led  : out STD_LOGIC;						--For debugging
           CLK_300khz : in STD_LOGIC;						--Clock frequency 300khz 
           clk100mhz : in STD_LOGIC;						--Clock frequency 100mhz
           data_seven : out STD_LOGIC_VECTOR(15 downto 0);	--For seven segment display
           PWM : IN STD_LOGIC;								--1/20 to arrange the voltage of motor
           START1 : IN STD_LOGIC;							--It starts to motor initially 
           start2 : in STD_LOGIC;							--It starts hall effects sensor so motor turns smoothly
           rev : in STD_LOGIC;           					--This determines whether the motor turns backward or forward
           EN1 : out STD_LOGIC;
           IN1 : out STD_LOGIC;
           EN2 : out STD_LOGIC;
           IN2 : out STD_LOGIC;
           EN3 : out STD_LOGIC;
           IN3 : out STD_LOGIC
           );
end FSM_Motor;

architecture Behavioral of FSM_Motor is
 
SIGNAL temp_hall: std_logic_vector(2 downto 0);
SIGNAL EN1_C :  STD_LOGIC;
SIGNAL IN1_C :  STD_LOGIC;
SIGNAL EN2_C : STD_LOGIC;
SIGNAL IN2_C :  STD_LOGIC;
SIGNAL EN3_C :  STD_LOGIC;
SIGNAL IN3_C :  STD_LOGIC;
SIGNAL EN1_I :  STD_LOGIC;
SIGNAL IN1_I :  STD_LOGIC;
SIGNAL EN2_I : STD_LOGIC;
SIGNAL IN2_I :  STD_LOGIC;
SIGNAL EN3_I :  STD_LOGIC;
SIGNAL IN3_I :  STD_LOGIC;

SIGNAL EN1_OC :  STD_LOGIC;
SIGNAL IN1_OC :  STD_LOGIC;
SIGNAL EN2_OC : STD_LOGIC;
SIGNAL IN2_OC :  STD_LOGIC;
SIGNAL EN3_OC :  STD_LOGIC;
SIGNAL IN3_OC :  STD_LOGIC;
SIGNAL EN1_OI :  STD_LOGIC;
SIGNAL IN1_OI :  STD_LOGIC;
SIGNAL EN2_OI : STD_LOGIC;
SIGNAL IN2_OI :  STD_LOGIC;
SIGNAL EN3_OI :  STD_LOGIC;
SIGNAL IN3_OI :  STD_LOGIC;

SIGNAL clk_counter: integer := 1;
SIGNAL clk_36hz: std_logic := '0';
SIGNAL counter: integer := 1;
SIGNAL counter2: integer := 1;
SIGNAL counter_1: integer :=1;
SIGNAL counter_2: integer :=0;
SIGNAL start_show: std_logic:='0';
SIGNAL rev_counter: integer := 1;
SIGNAL rev_opposite_counter: integer :=1;
SIGNAL tempseven : std_logic_vector(15 downto 0) := (others => '0'); 

begin

--This process enables motor to turn when reverse direction or direct direction  
process (CLK_36HZ,CLK_300khz)
begin
    if (rising_edge(CLK_300khz))then
        if(rev = '0')then
            if (start1 = '1')then
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
            if(counter = 3)then
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
            if(counter = 4)then
                IN1_I <= '0';
                IN2_I <= PWM; 
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
            if(counter = 5)then
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
            if(counter = 6)then
                IN1_I <= '0';
                IN2_I <= '0'; 
                IN3_I <= PWM; 
                EN1_I <= '0';
                EN2_I <= '1';
                EN3_I <= '1';
                counter2 <= counter2 + 1;
                if(counter2 = 8485)then    
                    counter <= 1;
                    counter2 <= 1;
                end if;
            end if;     
        end if;           
        else
            if (start1 = '1')then
                if(counter = 1)then
                        IN1_OI <= '0';
                        IN2_OI <= '0'; 
                        IN3_OI <= PWM; 
                        EN1_OI <= '0';
                        EN2_OI <= '1';
                        EN3_OI <= '1';
						counter2 <= counter2 + 1;
						if(counter2 = 8485)then    
							counter <= counter +1;
							counter2 <= 1;
						end if;
                end if;
                if(counter = 2)then
                    IN1_OI <= '0';
                    IN2_OI <= '0'; 
                    IN3_OI <= PWM; 
                    EN1_OI <= '1';
                    EN2_OI <= '0';
                    EN3_OI <= '1';
                    counter2 <= counter2 + 1;
                    if(counter2 = 8485)then    
                        counter <= counter +1;
                        counter2 <= 1;
                    end if;
                end if;
				if(counter = 3)then
					IN1_OI <= '0';
					IN2_OI <= PWM; 
					IN3_OI <= '0'; 
					EN1_OI <= '1';
					EN2_OI <= '1';
					EN3_OI <= '0';
					counter2 <= counter2 + 1;
					if(counter2 = 8485)then    
						counter <= counter +1;
						counter2 <= 1;
					end if;
				end if;
				if(counter = 4)then
					IN1_OI <= '0';
					IN2_OI <= PWM; 
					IN3_OI <= '0'; 
					EN1_OI <= '0';
					EN2_OI <= '1';
					EN3_OI <= '1';
					counter2 <= counter2 + 1;
					if(counter2 = 8485)then    
						counter <= counter +1;
						counter2 <= 1;
					end if;
				end if;
				if(counter = 5)then
                    IN1_OI <= PWM;
                    IN2_OI <= '0'; 
                    IN3_OI <= '0'; 
                    EN1_OI <= '1';
                    EN2_OI <= '0';
                    EN3_OI <= '1';
					counter2 <= counter2 + 1;
					if(counter2 = 8485)then    
						counter <= counter +1;
						counter2 <= 1;
					end if;
				end if;
				if(counter = 6)then
                    IN1_OI <= PWM;
                    IN2_OI <= '0'; 
                    IN3_OI <= '0'; 
                    EN1_OI <= '1';
                    EN2_OI <= '1';
                    EN3_OI <= '0';
					counter2 <= counter2 + 1;
					if(counter2 = 8485)then    
						counter <= 1;
						counter2 <= 1;
					end if;
				end if;     
			end if;
        end if;
    end if;           
end process;

--clock divider 300khz to 36hz
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

--This process determines the speed of motor by checking hall data and refress it with every 1 second
process(clk_300khz,counter_2)

begin 
    if (rising_edge(clk_300khz))then
    if(start2='1')then
        temp_hall <= hall_data;
        if(counter_1 <300000)then--1 second
            if(hall_data = "001")then
               counter_2 <= counter_2 + 1; 
            end if;
            counter_1 <= counter_1 + 1;                            
        elsif(counter_1 = 300000)then
                if(hall_data = "001")then
                    counter_2 <= counter_2 + 1; 
                end if;
                counter_1 <= counter_1 +1;                
                if counter_2 >= 57500 then
                    tempseven <= "0000000001110101";--75rpm      
                elsif  counter_2 >=53750 then
                    tempseven <= "0000000010000000";--80rpm
                elsif counter_2 >=51250 then
                    tempseven <= "0000000010000101";--85rpm
                elsif  counter_2 >=48750 then
                    tempseven <= "0000000010010000";--90rpm         
                elsif counter_2 >=46250 then
                    tempseven <= "0000000010010101";--95rpm
                elsif counter_2 >=43750 then
                    tempseven <= "0000000100000000";--100rpm
                elsif counter_2 >=41250 then
                    tempseven <= "0000000100000101";--105rpm
                elsif counter_2 >=40000 then
                    tempseven <= "0000000100010000";--110rpm
                elsif counter_2 >=38500 then
                    tempseven <= "0000000100010101";--115rpm
                elsif  counter_2 >=37000 then
                    tempseven <= "0000000100100000";--120rpm
                elsif counter_2 >=35000 then
                    tempseven <= "0000000100100101";--125rpm   
                elsif counter_2 >=34000 then
                    tempseven <= "0000000100110000";--130rpm
                elsif counter_2 >=33000 then
                    tempseven <= "0000000100110101";--135rpm
                elsif counter_2 >=32000 then
                    tempseven <= "0000000101000000";--140rpm
                elsif counter_2 >=30500 then
                    tempseven <= "0000000101000101";--145rpm
                elsif counter_2 >=29500 then
                    tempseven <= "0000000101010000";--150rpm 
                elsif  counter_2 >=28500 then
                    tempseven <= "0000000101010101";--155rpm
                elsif  counter_2 >=27500 then
                    tempseven <= "0000000101100000";--160rpm 
                elsif counter_2 >=26500 then
                    tempseven <= "0000000101100101";--165rpm
                elsif counter_2 >=26000 then
                    tempseven <= "0000000101110000";--170rpm
                elsif counter_2 >=25500 then
					tempseven <= "0000000101110101";--175rpm
                elsif counter_2 >=24500 then
                    tempseven <= "0000000110000000";--180rpm
                elsif counter_2 >=24000 then
                    tempseven <= "0000000100100101";--185rpm
                elsif counter_2 >=23500 then
                    tempseven <= "0000000110010000";--190rpm                                                             
                elsif counter_2 >=22750 then
                    tempseven <= "0000000110010101";--195rpm 
                elsif counter_2 >=22250then
                    tempseven <= "0000001000000000";--200rpm
                elsif counter_2 >=21000then
                    tempseven <= "0000001000010000";--210rpm
                elsif counter_2 >=20000then
                    tempseven <= "0000001000100000";--220rpm 
                elsif counter_2 >=19000then
                    tempseven <= "0000001000110000";--230rpm
                elsif counter_2 >=18500then
                    tempseven <= "0000001001000000";--240rpm
                elsif counter_2 >=18000then
                    tempseven <= "0000001001010000";--250rpm
                elsif counter_2 >=17000then
                    tempseven <= "0000001001100000";--260rpm
                elsif counter_2 >=16500then
                    tempseven <= "0000001011100000";--270rpm           
                elsif counter_2 >=16000 then
                    tempseven <= "0000001010000000";--280rpm 
                elsif counter_2 >=15300 then
                    tempseven <= "0000001010010000";--290rpm
                elsif counter_2 >=14700then
                    tempseven <= "0000001100000000";--300rpm  
                elsif counter_2 >=13500then
                    tempseven <= "0000001100100000";--320rpm 
                elsif counter_2 >=13000then
                    tempseven <= "0000001101000000";--340rpm 
                elsif counter_2 >=11500then
                    tempseven <= "0000001110000000";--380rpm
                elsif counter_2 >=10000then
                    tempseven <= "0000001100100000";--420rpm 
                elsif counter_2 >= 9500then
                    tempseven <= "0000001101100000";--460rpm                           
                else
                    tempseven <= "1111111111111111";--I didnt specified yet
                end if;                 
        else    
                counter_1 <= 1;
                counter_2 <= 0;
        end if;
    end if;
    end if;
end process;

--Hall effect turns 
process(clk_300khz)
begin 
    if(rising_edge(clk_300khz))then
		if(start2 = '1')then
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
		else
			error_led <= '0';
		end if;
    end if;
end process;
--MAtching
process(clk_300khz)
begin
if(rising_edge(clk_300khz))then
    if(start1 = '1')then
        if(rev = '0')then      
            if(rev_opposite_counter > 300000)then
                rev_counter <= 1;
                if(start2 = '1')then
                    IN1 <=IN1_C;
                    EN1 <= EN1_C;
                    IN2 <= IN2_C;
                    EN2 <=  EN2_C;
                    IN3 <= IN3_C;
                    EN3 <= EN3_C;
                    data_seven <= tempseven;--90RPM
                else
                    IN1 <=IN1_I;
                    EN1 <= EN1_I;
                    IN2 <= IN2_I;
                    EN2 <=  EN2_I;
                    IN3 <= IN3_I;
                    EN3 <= EN3_I;
                    data_seven <= "0000000010010000";--90RPM
                end if;    
            else
                rev_opposite_counter <= rev_opposite_counter +1;
                IN1 <= '0';
                EN1 <= '0';
                IN2 <= '0';
                EN2 <= '0';
                IN3 <= '0';
                EN3 <= '0';          
                data_seven <= "0000000000000000";--90RPM
            end if;
        else        
            if (rev_counter > 300000)then
                rev_opposite_counter <= 1;
                if(start2 = '1')then
                    IN1 <=IN1_C;
                    EN1 <= EN1_C;
                    IN2 <= IN2_C;
                    EN2 <=  EN2_C;
                    IN3 <= IN3_C;
                    EN3 <= EN3_C;
                    data_seven <= tempseven;--90RPM
                else
                    IN1 <=IN1_OI;
                    EN1 <= EN1_OI;
                    IN2 <= IN2_OI;
                    EN2 <=  EN2_OI;
                    IN3 <= IN3_OI;
                    EN3 <= EN3_OI;
                    data_seven <= "0000000010010000";--90RPM
                end if;
            else
                rev_counter <= rev_counter +1;        
                IN1 <= '0';
                EN1 <= '0';
                IN2 <= '0';
                EN2 <= '0';
                IN3 <= '0';
                EN3 <= '0';          
                data_seven <= "0000000000000000";--90RPM           
            end if;     
        end if;           
    else
        data_seven <= "0000000000000000";--90RPM
    end if;
end if;
end process;

end Behavioral;
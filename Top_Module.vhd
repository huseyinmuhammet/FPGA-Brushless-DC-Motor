----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2020 13:21:01
-- Design Name: 
-- Module Name: Top_Module - Behavioral
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
 use IEEE.numeric_bit.all;
        use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_Module is
    Port (
          -- hall_data_out : out STD_LOGIC_VECTOR(2 downto 0);
           rev : in STD_LOGIC;
           hall_data_in : in STD_LOGIC_VECTOR(2 downto 0);
           LED_out : out STD_LOGIC_VECTOR (6 downto 0);-- Cathode patterns of 7-segment display
           Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
           reset: in STD_LOGIC;
           CLK : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR(3 DOWNTO 0);
           SW : in STD_LOGIC_VECTOR(9 DOWNTO 0);
           EN1 : out STD_LOGIC;
           IN1 : out STD_LOGIC;
           EN2 : out STD_LOGIC;
           IN2 : out STD_LOGIC;
           EN3 : out STD_LOGIC;
           IN3 : out STD_LOGIC);
           
end Top_Module;

architecture Behavioral of Top_Module is

component Clock_Divider is
    Port ( CLK_I : in STD_LOGIC;
           CLK_O : out STD_LOGIC;
           CLK_O_36 : out STD_LOGIC);
end component;
component PWM_Module is
    Port ( clock_15khz : in STD_LOGIC;
           PWM : out STD_LOGIC);
end component;

component FSM_Motor is
    Port ( error_led  : out STD_LOGIC;
           data_seven : out STD_LOGIC_VECTOR(15 downto 0);
           CLK_300khz : IN STD_LOGIC;
           PWM : IN STD_LOGIC;
           START1 : IN STD_LOGIC;
          clk100mhz : in STD_LOGIC;
           start2 : in STD_LOGIC;
           hall_data : in STD_LOGIC_vector(2 downto 0);
           rev : in STD_LOGIC;
           EN1 : out STD_LOGIC;
           IN1 : out STD_LOGIC;
           EN2 : out STD_LOGIC;
           IN2 : out STD_LOGIC;
           EN3 : out STD_LOGIC;
           IN3 : out STD_LOGIC
           );
end component;

component seven_segment_display is
    Port ( data_seven : in STD_LOGIC_VECTOR(15 downto 0);
           clock_100Mhz : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
           reset : in STD_LOGIC; -- reset
           Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
           LED_out : out STD_LOGIC_VECTOR (6 downto 0));-- Cathode patterns of 7-segment display
end component;
--Seven segment signal
SIGNAL data_seven : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

-- Clock Signals
SIGNAL clk_divided_15khz : STD_LOGIC;
SIGNAL clk_t : STD_LOGIC;
SIGNAL PWM_o : STD_LOGIC;
SIGNAL clk_divided_36HZ : STD_LOGIC;

--
SIGNAL EN1_M :  STD_LOGIC;
SIGNAL EN2_M :  STD_LOGIC;
SIGNAL EN3_M :  STD_LOGIC;
SIGNAL IN1_M :  STD_LOGIC;
SIGNAL IN2_M :  STD_LOGIC;
SIGNAL IN3_M :  STD_LOGIC;

--SIGNAL EN1_H :  STD_LOGIC;
--SIGNAL EN2_H :  STD_LOGIC;
--SIGNAL EN3_H :  STD_LOGIC;
--SIGNAL IN1_H :  STD_LOGIC;
--SIGNAL IN2_H :  STD_LOGIC;
--SIGNAL IN3_H :  STD_LOGIC;
--SIGNAL motorstart :  STD_LOGIC;
--SIGNAL hallstart :  STD_LOGIC;
SIGNAL counter : integer:=1;
SIGNAL counter2 : integer:=1;
begin


--process(clk_divided_15khz)
--begin 
--    if (rising_edge(clk_divided_15khz))then

    
--        if(counter = 1)then
--           hall_data_out <= "001";
--            counter2 <= counter2 + 1;
--            if(counter2 = 7576)then    
--                counter <= counter +1;
--                counter2 <= 1;
--            end if;
--        end if;
--        if(counter = 2)then
--            hall_data_out <= "010";
--            counter2 <= counter2 + 1;
--            if(counter2 = 7576)then    
--                counter <= counter +1;
--                counter2 <= 1;
--            end if;
--        end if;
--        if(counter = 3)then
--           hall_data_out <= "011";
--            counter2 <= counter2 + 1;
--            if(counter2 = 7576)then    
--                counter <= counter +1;
--                counter2 <= 1;
--            end if;
--        end if;
--        if(counter = 4)then
--            hall_data_out <= "100";
--            counter2 <= counter2 + 1;
--            if(counter2 = 7576)then    
--                counter <= counter +1;
--                counter2 <= 1;
--            end if;
--        end if;
--        if(counter = 5)then
--            hall_data_out <= "101";
--            counter2 <= counter2 + 1;
--            if(counter2 = 7576)then    
--                counter <= counter +1;
--                counter2 <= 1;
--            end if;
--        end if;
--        if(counter = 6)then
--           hall_data_out <= "110";
--            counter2 <= counter2 + 1;
--            if(counter2 = 7576)then    
--                counter <= 1;
--                counter2 <= 1;
--            end if;
--        end if;     
--    end if;
    

--end process;







 EN1 <= EN1_M;
 IN1 <= IN1_M;
 EN2 <= EN2_M;
 IN2 <= IN2_M;
 EN3 <= EN3_M;
 IN3 <= IN3_M;


clk_divide: Clock_Divider
    port map(
        CLK_I => CLK,
        CLK_O => clk_divided_15khz,
        CLK_O_36 => clk_divided_36HZ
    );


Pwm_portmap: PWM_Module
    port map(
        clock_15khz => clk_divided_15khz,
        PWM => PWM_o
    );
    
    Motor_Normal: FSM_Motor
    port map(
           rev => rev,
           data_seven => data_seven,
           CLK_300khz => clk_divided_15khz,
           PWM => PWM_o,
           START1 => SW(0),
          clk100mhz => CLK,
           hall_data => hall_data_in,
           error_led => LED(0),
           start2 => SW(8),
           EN1 => EN1_M,
           IN1 => IN1_M,
           EN2 => EN2_M,
           IN2 => IN2_M,
           EN3 => EN3_M,
           IN3 => IN3_M
    );
    seven_seg: seven_segment_display
    port map(
           data_seven => data_seven,
           clock_100Mhz => CLK,
           reset => reset, 
           Anode_Activate => Anode_Activate,
           LED_out => LED_out 
    );
--    Hall: HallSensor
--    port map(
--        error_led => LED(0), 
--        PWM => PWM_o,
--        hall_data => hall_data_in,
--        start => hallstart,
--        clk_300khz => clk_divided_15khz,
--        EN1 => EN1_H,
--        IN1 => IN1_H,
--        EN2 => EN2_H,
--        IN2 => IN2_H,
--        EN3 => EN3_H,
--        IN3 => IN3_H
--    );
end Behavioral;

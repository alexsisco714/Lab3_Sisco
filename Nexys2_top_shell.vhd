----------------------------------------------------------------------------------
-- Company: USAFA
-- Engineer: Alex Sisco
-- 
-- Create Date:    21:26 03/10/2014
-- Module Name:    Nexys2_Lab3top - Behavioral 
-- Target Devices: Nexys2 Project Board
-- Tool versions: 
-- Description: This file is a shell for implementing designs on a NEXYS 2 board
-- 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Nexys2_top_shell is
    Port ( 	clk_50m : in STD_LOGIC;
				btn : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
				switch : in STD_LOGIC_VECTOR (7 DOWNTO 0);
				SSEG_AN : out STD_LOGIC_VECTOR (3 DOWNTO 0);
				SSEG : out STD_LOGIC_VECTOR (7 DOWNTO 0);
				LED : out STD_LOGIC_VECTOR (7 DOWNTO 0));
end Nexys2_top_shell;

architecture Behavioral of Nexys2_top_shell is

---------------------------------------------------------------------------------------
--This component converts a nibble to a value that can be viewed on a 7-segment display
--Similar in function to a 7448 BCD to 7-seg decoder
--Inputs: 4-bit vector called "nibble"
--Outputs: 8-bit vector "sseg" used for driving a single 7-segment display
---------------------------------------------------------------------------------------
	COMPONENT nibble_to_sseg
	PORT(
		nibble : IN std_logic_vector(3 downto 0);          
		sseg : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

---------------------------------------------------------------------------------------------
--This component manages the logic for displaying values on the NEXYS 2 7-segment displays
--Inputs: system clock, synchronous reset, 4 8-bit vectors from 4 instances of nibble_to_sseg
--Outputs: 7-segment display select signal (4-bit) called "sel", 
--         8-bit signal called "sseg" containing 7-segment data routed off-chip
---------------------------------------------------------------------------------------------
	COMPONENT nexys2_sseg
	GENERIC ( CLOCK_IN_HZ : integer );
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		sseg0 : IN std_logic_vector(7 downto 0);
		sseg1 : IN std_logic_vector(7 downto 0);
		sseg2 : IN std_logic_vector(7 downto 0);
		sseg3 : IN std_logic_vector(7 downto 0);          
		sel : OUT std_logic_vector(3 downto 0);
		sseg : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

-------------------------------------------------------------------------------------
--This component divides the system clock into a bunch of slower clock speeds
--Input: system clock 
--Output: 27-bit clockbus. Reference module for the relative clock speeds of each bit
--			 assuming system clock is 50MHz
-------------------------------------------------------------------------------------
	COMPONENT Clock_Divider
	PORT(
		clk : IN std_logic;          
		clockbus : OUT std_logic_vector(26 downto 0)
		);
	END COMPONENT;

-------------------------------------------------------------------------------------
--Below are declarations for signals that wire-up this top-level module.
-------------------------------------------------------------------------------------

signal nibble0, nibble1, nibble2, nibble3 : std_logic_vector(3 downto 0);
signal sseg0_sig, sseg1_sig, sseg2_sig, sseg3_sig : std_logic_vector(7 downto 0);
signal ClockBus_sig : STD_LOGIC_VECTOR (26 downto 0);


--------------------------------------------------------------------------------------
--Insert your design's component declaration below	
--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Moore Elevator Controller
--Input: System Clock, reset, stop, up/down
--Output: floor
-------------------------------------------------------------------------------------
COMPONENT MooreElevatorController_Shell
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		stop : IN std_logic;
		desiredFloor : IN std_logic_vector(3 downto 0);
		desiredFloorOUT : OUT std_logic_vector(3 downto 0);
		requestedFloor : IN std_logic_vector(3 downto 0);
		requestedFloorOUT : OUT std_logic_vector(3 downto 0);
		up_down : OUT std_logic_vector(1 downto 0);          
		floorA : OUT std_logic_vector(3 downto 0);
		floorB : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

--------------------------------------------------------------------------------------
--Insert any required signal declarations below
--------------------------------------------------------------------------------------
--signal digit2:std_logic_vector(3 downto 0);
signal upDown:std_logic_vector(1 downto 0);


begin 
		LED(0) <= CLOCKBUS_SIG(26) when upDown = "01" else CLOCKBUS_SIG(23) when upDown="00" else '0';
		LED(1) <= CLOCKBUS_SIG(25) when upDown = "01" else CLOCKBUS_SIG(24) when upDown="00" else '0';
		LED(2) <= CLOCKBUS_SIG(24) when upDown = "01" else CLOCKBUS_SIG(25) when upDown="00" else '0';
		LED(3) <= CLOCKBUS_SIG(23) when upDown = "01" else CLOCKBUS_SIG(26) when upDown="00" else '0';
		LED(4) <= CLOCKBUS_SIG(26) when upDown = "01" else CLOCKBUS_SIG(23) when upDown="00" else '0';
		LED(5) <= CLOCKBUS_SIG(25) when upDown = "01" else CLOCKBUS_SIG(24) when upDown="00" else '0';
		LED(6) <= CLOCKBUS_SIG(24) when upDown = "01" else CLOCKBUS_SIG(25) when upDown="00" else '0';
		LED(7) <= CLOCKBUS_SIG(23) when upDown = "01" else CLOCKBUS_SIG(26) when upDown="00" else '0';
		

--------------------------------------------------------------------------------------------	
--This code instantiates the Clock Divider. Reference the Clock Divider Module for more info
--------------------------------------------------------------------------------------------
	Clock_Divider_Label: Clock_Divider PORT MAP(
		clk => clk_50m,
		clockbus => ClockBus_sig
	);

--------------------------------------------------------------------------------------	
--Code below drives the function of the 7-segment displays. 
--Function: To display a value on 7-segment display #0, set the signal "nibble0" to 
--				the value you wish to display
--				To display a value on 7-segment display #1, set the signal "nibble1" to 
--				the value you wish to display...and so on
--Note: You must set each "nibble" signal to a value. 
--		  Example: if you are not using 7-seg display #3 set nibble3 to "0000"
--------------------------------------------------------------------------------------

--nibble0 <= 
--nibble1 <= "0000";
--nibble2 <= "0000";
--nibble3 <= "0000";

--This code converts a nibble to a value that can be displayed on 7-segment display #0
	sseg0: nibble_to_sseg PORT MAP(
		nibble => nibble0,
		sseg => sseg0_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #1
	sseg1: nibble_to_sseg PORT MAP(
		nibble => nibble1,
		sseg => sseg1_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #2
	sseg2: nibble_to_sseg PORT MAP(
		nibble => nibble2,
		sseg => sseg2_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #3
	sseg3: nibble_to_sseg PORT MAP(
		nibble => nibble3,
		sseg => sseg3_sig
	);
	
--This module is responsible for managing the 7-segment displays, you don't need to do anything here
	nexys2_sseg_label: nexys2_sseg 
	generic map ( CLOCK_IN_HZ => 50E6 )
	PORT MAP(
		clk => clk_50m,
		reset => '0',
		sseg0 => sseg0_sig,
		sseg1 => sseg1_sig,
		sseg2 => sseg2_sig,
		sseg3 => sseg3_sig,
		sel => SSEG_AN,
		sseg => SSEG
	);

-----------------------------------------------------------------------------
--Instantiate the design you wish to implement below and start wiring it up!:
-----------------------------------------------------------------------------
 Moore1: MooreElevatorController_Shell PORT MAP(
		clk => ClockBus_sig(25),
		reset => btn(3),
		stop => btn(0),
		desiredFloor => switch(7 downto 4),
		desiredFloorOUT => nibble2,
		requestedFloor => switch(3 downto 0),
		requestedFloorOUT => nibble3,
		up_down => upDown,
		floorA => nibble0,
		floorB => nibble1
	);

--	Mealy1: MealyElevatorController_Shell PORT MAP(
--		clk => ClockBus_sig(25),
--		reset => btn(3),
--		stop => btn(1),
--		up_down => switch(0),
--		floor => nibble0,
--		nextfloor => nibble3
--	);

end Behavioral;


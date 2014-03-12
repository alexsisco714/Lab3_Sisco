----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Alex Sisco
-- 
-- Create Date:    	19:00:00 03/06/2014 
-- Design Name:		CE3
-- Module Name:    	MooreElevatorController_Shell - Behavioral 
-- Description: 		Shell for completing CE3
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MooreElevatorController_Shell is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
			  desiredFloor : in STD_LOGIC_VECTOR(3 downto 0);
			  desiredFloorOUT : out STD_LOGIC_VECTOR(3 downto 0);
           up_down : out  STD_LOGIC_Vector(1 downto 0);
			  floorA : out  STD_LOGIC_VECTOR (3 downto 0);
			  floorB : out STD_LOGIC_VECTOR (3 downto 0)
			  );
end MooreElevatorController_Shell;

architecture Behavioral of MooreElevatorController_Shell is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic 
type floor_state_type is (floor0, floor1, floor2, floor3, floor4, floor5, floor6, floor7, floor8, floor11, floor13, floor17, floor19);

--Here you create a variable "floor_state" that can take on the values
--defined above. Neat-o!
signal floorA_state : floor_state_type;
signal floorB_state : floor_state_type;

begin
---------------------------------------------
--Below you will code your next-state process
---------------------------------------------

--This line will set up a process that is sensitive to the clock
floor_state_machine: process(clk)
variable floor: std_logic_vector(3 downto 0);
variable floorAcurrent: std_logic_vector(3 downto 0);
variable floorBcurrent: std_logic_vector(3 downto 0);
--variable distanceFromFloorA: std_logic_vector(3 downto 0);
--variable distanceFromFloorB: std_logic_vector(3 downto 0);
begin

	--clk'event and clk='1' is VHDL-speak for a rising edge
	if clk'event and clk='1' then
		--reset is active high and will return the elevator to floor1
		--Question: is reset synchronous or asynchronous?
		if reset='1' then
			--floor_state <= floor1;
			floorA_state <= floor0;
			floorAcurrent:="0000";
			floorB_state <= floor7;
			floorBcurrent:="0111";
		--now we will code our next-state logic
		else
			case floorA_state is
				--when our current state is floor1
				when floor0 =>
					floor := "0000";
					--distanceFromFloorA:=
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					
					up_down <= "01";
					floorA_state <= floor1;
					floorAcurrent:="0001";
					
					else
					up_down <= "10";
						floorA_state <= floor0;
					end if;
				--when our current state is floor2
				when floor1 => 
					floor := "0001";

					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						floorA_state <= floor2;
						floorAcurrent:="0010";
					--if up_down is set to "go down" and stop is set to 
					--"don't stop" which floor do we want to go to?
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorA_state <= floor0;
						floorAcurrent:="0000";
					--otherwise we're going to stay at floor2
					else
					up_down <= "10";
						floorA_state <= floor1;
					end if;
				
				when floor2 =>
					floor := "0010";
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						floorA_state <= floor3;
						floorAcurrent:="0011";
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorA_state <= floor1;	
						floorAcurrent:="0001";
					else
					up_down <= "10";
						floorA_state <= floor2;	
					end if;
				when floor3 =>
 
					floor := "0011";
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						floorA_state <= floor4;
						floorAcurrent:="0100";
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorA_state <= floor2;	
						floorAcurrent:="0010";
					else
					up_down <= "10";
						floorA_state <= floor3;	
					end if;
				when floor4 =>
				
					floor := "0100";
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						floorA_state <= floor5;
						floorAcurrent:="0101";
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
						up_down <= "00";
						floorA_state <= floor3;
						floorAcurrent:="0011";
					else
					up_down <= "10";
						floorA_state <= floor4;	
					end if;
				when floor5 =>
				
					floor := "0101";
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						floorA_state <= floor6;
						floorAcurrent:="0110";
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorA_state <= floor4;	
						floorAcurrent:="0100";
					else
					up_down <= "10";
						floorA_state <= floor5;	
					end if;
				when floor6 =>
				
					floor := "0110";
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then
						up_down <= "01";
						floorA_state <= floor7;
						floorAcurrent:="0111";
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorA_state <= floor5;
						floorAcurrent:="0101";
					else
					up_down <= "10";
						floorA_state <= floor6;	
					end if;
				when floor7 =>
				
					floor := "0111";
					if (floor>desiredFloor and abs(desiredfloor-floorAcurrent)<abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorA_state <= floor6;
							floorAcurrent:="0110";
					else 
					up_down <= "10";
						floorA_state <= floor7;	
						
					end if;

				when others =>
					floorA_state <= floor0;
					floorAcurrent:="0000";
			end case;
			case floorB_state is
				--when our current state is floor1
				when floor0 =>
					floor := "0000";
					
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						--floor2 right?? This makes sense!
						floorB_state <= floor1;
						floorBcurrent:="0001";
					--otherwise we're going to stay at floor1
					else
					up_down <= "10";
						floorB_state <= floor0;
					end if;
				--when our current state is floor2
				when floor1 => 
					floor := "0001";

					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						floorB_state <= floor2;
							floorBcurrent:="0011";
					--if up_down is set to "go down" and stop is set to 
					--"don't stop" which floor do we want to go to?
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorB_state <= floor0;
						floorBcurrent:="0000";
					--otherwise we're going to stay at floor2
					else
					up_down <= "10";
						floorB_state <= floor1;
					end if;
				
				when floor2 =>
					floor := "0010";
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						floorB_state <= floor3;
						floorBcurrent:="0011";
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorB_state <= floor1;	
						floorBcurrent:="0001";
					else
					up_down <= "10";
						floorB_state <= floor2;	
					end if;
				when floor3 =>
 
					floor := "0011";
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						floorB_state <= floor4;
						floorBcurrent:="0100";
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorB_state <= floor2;
						floorBcurrent:="0010";						
					else
					up_down <= "10";
						floorB_state <= floor3;	
					end if;
				when floor4 =>
				
					floor := "0100";
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						floorB_state <= floor5;
						floorBcurrent:="0101";
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
						up_down <= "00";
						floorB_state <= floor3;
						floorBcurrent:="0011";
					else
					up_down <= "10";
						floorB_state <= floor4;	
					end if;
				when floor5 =>
				
					floor := "0101";
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "01";
						floorB_state <= floor6;
						floorBcurrent:="0110";
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorB_state <= floor4;	
						floorBcurrent:="0100";
					else
					up_down <= "10";
						floorB_state <= floor5;	
					end if;
				when floor6 =>
				
					floor := "0110";
					if (floor<desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then
						up_down <= "01";
						floorB_state <= floor7;
						floorBcurrent:="0111";
					elsif (floor>desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorB_state <= floor5;
						floorBcurrent:="0101";
					else
					up_down <= "10";
						floorB_state <= floor6;	
					end if;
				when floor7 =>
				
					floor := "0111";
					if (floor>desiredFloor and abs(desiredfloor-floorAcurrent)>=abs(desiredFloor-floorBcurrent)) then 
					up_down <= "00";
						floorB_state <= floor6;
							floorBcurrent:="0110";
					else 
					up_down <= "10";
						floorB_state <= floor7;	
					end if;

				when others =>
					floorB_state <= floor7;
					floorBcurrent:="0111";
			end case;
		end if;
	end if;
end process;

-- Here you define your output logic. Finish the statements below
floorA <= "0000" when (floorA_state = floor0) else
			"0001" when (floorA_state = floor1) else
			"0010" when (floorA_state = floor2) else
			"0011" when (floorA_state = floor3) else
			"0100" when (floorA_state = floor4) else
			"0101" when (floorA_state = floor5) else
			"0110" when (floorA_state = floor6) else
			"0111" when (floorA_state = floor7) else
			"0010";
floorB <= "0000" when (floorB_state = floor0) else
			"0001" when (floorB_state = floor1) else
			"0010" when (floorB_state = floor2) else
			"0011" when (floorB_state = floor3) else
			"0100" when (floorB_state = floor4) else
			"0101" when (floorB_state = floor5) else
			"0110" when (floorB_state = floor6) else
			"0111" when (floorB_state = floor7) else
			"0010";
desiredFloorOUT<=desiredFloor;
end Behavioral;


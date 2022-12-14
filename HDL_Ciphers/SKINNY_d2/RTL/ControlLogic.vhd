--
-- -----------------------------------------------------------------
-- COMPANY : Ruhr University Bochum
-- AUTHOR  : Aein Rezaei Shahmirzadi (aein.rezaeishahmirzadi@rub.de)
-- DOCUMENT: "Low-Latency and Low-Randomness Second-Order Masked Cubic Functions", TCHES 2023, Issue 1.
-- -----------------------------------------------------------------
--
-- Copyright c 2021, Aein Rezaei Shahmirzadi
--
-- All rights reserved.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTERS BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- INCLUDING NEGLIGENCE OR OTHERWISE ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-- Please see LICENSE and README for license and further instructions.
--

-- IMPORTS
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- ENTITY
----------------------------------------------------------------------------------
ENTITY ControlLogic IS
	PORT ( CLK			: IN	STD_LOGIC;
			 -- CONTROL PORTS --------------------------------
		  	 RESET		: IN  STD_LOGIC;
			 KEY_EN		: OUT STD_LOGIC;
		    DONE			: OUT STD_LOGIC;
			 -- CONST PORT -----------------------------------
          ROUND_CST	: OUT STD_LOGIC_VECTOR (5 DOWNTO 0));
END ControlLogic;



-- ARCHITECTURE : ROUND
----------------------------------------------------------------------------------
ARCHITECTURE Round OF ControlLogic IS

	-- SIGNALS --------------------------------------------------------------------
	SIGNAL STATE, UPDATE : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL SHIFT         : STD_LOGIC_VECTOR(1 DOWNTO 0);
	
BEGIN

	-- STATE ----------------------------------------------------------------------
	REG : PROCESS(CLK) BEGIN
		IF RISING_EDGE(CLK) THEN
			IF (RESET = '1') THEN
				STATE <= (OTHERS => '0');
				SHIFT <= "01";
			ELSE
				IF (SHIFT(1) = '1') THEN
					STATE <= UPDATE;
				END IF;
				
				SHIFT <= SHIFT(0) & SHIFT(1);
			END IF;
		END IF;
	END PROCESS;
	-------------------------------------------------------------------------------

	-- UPDATE FUNCTION ------------------------------------------------------------
	UPDATE <= STATE(4 DOWNTO 0) & (STATE(5) XNOR STATE(4));

	-- CONSTANT -------------------------------------------------------------------
	ROUND_CST <= UPDATE when (RESET = '0') else "000001" ;
	KEY_EN	<= SHIFT(1) OR RESET;

	-- DONE SIGNAL ----------------------------------------------------------------
	DONE <= '1' WHEN (UPDATE = "111000") ELSE '0';

END Round;

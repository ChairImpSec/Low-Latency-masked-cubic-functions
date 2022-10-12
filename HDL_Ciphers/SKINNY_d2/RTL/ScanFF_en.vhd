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
ENTITY ScanFF_en IS
	GENERIC (SIZE : INTEGER);
	PORT ( CLK	: IN 	STD_LOGIC;
          SE 	: IN 	STD_LOGIC;
			 EN   : IN  STD_LOGIC;
          D  	: IN 	STD_LOGIC_VECTOR((SIZE - 1) DOWNTO 0);
          DS	: IN 	STD_LOGIC_VECTOR((SIZE - 1) DOWNTO 0);
          Q 	: OUT STD_LOGIC_VECTOR((SIZE - 1) DOWNTO 0));
END ScanFF_en;



-- ARCHITECTURE : STRUCTURAL
----------------------------------------------------------------------------------
ARCHITECTURE Structural OF ScanFF_en IS

	-- COMPONENTS -----------------------------------------------------------------
	COMPONENT dflipfloplw_en IS
	PORT ( CLK  : IN  STD_LOGIC;
			 SEL	: IN  STD_LOGIC;
			 EN	: IN  STD_LOGIC;
			 D0   : IN  STD_LOGIC;
			 D1   : IN  STD_LOGIC;
			 Q    : OUT STD_LOGIC);
	END COMPONENT;
	-------------------------------------------------------------------------------

BEGIN

	GEN : FOR I IN 0 TO (SIZE - 1) GENERATE
		SFF : dflipfloplw_en PORT MAP (CLK, SE, EN, D(I), DS(I), Q(I));
	END GENERATE;

END Structural;
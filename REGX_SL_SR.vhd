library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REGX_SL_SR is

	generic
	(
		size : natural := 16;
		default_value: natural:=0
	);

	port 
	(
		clk		: in std_logic;
		ld	      : in std_logic;
		data_in	: in std_logic_vector(size-1 downto 0);
		sr			: in std_logic;
		ir			: in std_logic;
		sl			: in std_logic;
		il			: in std_logic;
		inc		: in std_logic;
		dec		: in std_logic;
		cl			: in std_logic;
		data_out	: out std_logic_vector(size-1 downto 0)
	);

end entity;

architecture rtl of REGX_SL_SR is
	signal data,data_next:std_logic_vector(size-1 downto 0):=std_logic_vector(to_unsigned( default_value, size));
begin
	data_out<=data;
	process (clk)
	begin
		if (rising_edge(clk)) then
				data<=data_next;
		end if;
	end process;

	process (ld, inc, dec, cl, sl, sr, il, ir, data_in, data)
	begin
		if (cl='1') then
			data_next<=(others=>'0');
		elsif (ld ='1') then
			data_next<=data_in;
		elsif (sr ='1') then
			data_next<= ir&data(size-1 downto 1);
		elsif (sl ='1') then
			data_next<= data(size-2 downto 0)&il;
		elsif (inc ='1') then
			data_next<=std_logic_vector(to_unsigned(to_integer(unsigned( data )) + 1, size));
		elsif (dec ='1') then
			data_next<=std_logic_vector(to_unsigned(to_integer(unsigned( data )) - 1, size));
		end if;
	end process;

end rtl;

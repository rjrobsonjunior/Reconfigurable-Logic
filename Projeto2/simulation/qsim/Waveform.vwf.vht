-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "09/02/2025 18:42:15"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Projeto2Aritim
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Projeto2Aritim_vhd_vec_tst IS
END Projeto2Aritim_vhd_vec_tst;
ARCHITECTURE Projeto2Aritim_arch OF Projeto2Aritim_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL aclr : STD_LOGIC;
SIGNAL clock : STD_LOGIC;
SIGNAL out_mem : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL rms : STD_LOGIC_VECTOR(15 DOWNTO 0);
COMPONENT Projeto2Aritim
	PORT (
	aclr : IN STD_LOGIC;
	clock : IN STD_LOGIC;
	out_mem : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	rms : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : Projeto2Aritim
	PORT MAP (
-- list connections between master ports and signals
	aclr => aclr,
	clock => clock,
	out_mem => out_mem,
	rms => rms
	);

-- clock
t_prcs_clock: PROCESS
BEGIN
LOOP
	clock <= '0';
	WAIT FOR 5000 ps;
	clock <= '1';
	WAIT FOR 5000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clock;

-- aclr
t_prcs_aclr: PROCESS
BEGIN
	aclr <= '0';
	WAIT FOR 240000 ps;
	aclr <= '1';
	WAIT FOR 20000 ps;
	aclr <= '0';
WAIT;
END PROCESS t_prcs_aclr;
END Projeto2Aritim_arch;

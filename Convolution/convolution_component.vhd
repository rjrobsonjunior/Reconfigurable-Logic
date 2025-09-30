library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Convolucao_Sequencial is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;

        load_x  : in  std_logic;  -- pulso para carregar valor de x_in
        load_h  : in  std_logic;  -- pulso para carregar valor de h_in
        x_in    : in  std_logic_vector(7 downto 0);
        h_in    : in  std_logic_vector(7 downto 0);

        start   : in  std_logic;  -- inicia convolução após carregar os vetores
        done    : out std_logic;  -- indica quando terminou

        y_index : in  std_logic_vector(8 downto 0); -- endereço (0..511)
        y_out   : out std_logic_vector(31 downto 0) -- saída única
    );
end Convolucao_Sequencial;

architecture Behavioral of Convolucao_Sequencial is

    -- Memórias internas
    type vec256 is array(0 to 255) of signed(7 downto 0);
    type vec512 is array(0 to 511) of signed(31 downto 0);

    signal x_mem : vec256 := (others => (others => '0'));
    signal h_mem : vec256 := (others => (others => '0'));
    signal y_mem : vec512 := (others => (others => '0'));

    -- índices de carregamento
    signal idx_x : integer range 0 to 255 := 0;
    signal idx_h : integer range 0 to 255 := 0;

    -- índices para convolução
    signal i, j : integer range 0 to 255 := 0;

    type state_type is (IDLE, LOAD, COMPUTE, DONE_s);
    signal state : state_type := IDLE;

signal done_int : std_logic := '0';

begin

    -- Máquina de estados principal
    process(clk, reset)
    begin
        if reset = '1' then
            idx_x <= 0;
            idx_h <= 0;
            i <= 0;
            j <= 0;
            y_mem <= (others => (others => '0'));
            state <= IDLE;
            done_int <= '0';

        elsif rising_edge(clk) then
            case state is

                when IDLE =>
                    done_int <= '0';
                    if start = '1' then
                        idx_x <= 0;
                        idx_h <= 0;
                        i <= 0;
                        j <= 0;
                        y_mem <= (others => (others => '0'));
                        state <= LOAD;
                    end if;

                when LOAD =>
                    if load_x = '1' and idx_x < 256 then
                        x_mem(idx_x) <= signed(x_in);
                        idx_x <= idx_x + 1;
                    elsif load_h = '1' and idx_h < 256 then
                        h_mem(idx_h) <= signed(h_in);
                        idx_h <= idx_h + 1;
                    end if;

                    if idx_x = 256 and idx_h = 256 then
                        i <= 0;
                        j <= 0;
                        state <= COMPUTE;
                    end if;

                when COMPUTE =>
                    if i <= 255 then
                        if j <= 255 then
                            y_mem(i+j) <= y_mem(i+j) + resize(x_mem(i), 16) * resize(h_mem(j), 16);
                            j <= j + 1;
                        else
                            j <= 0;
                            i <= i + 1;
                        end if;
                    else
                        state <= DONE_s;
                    end if;

                when DONE_s =>
                    done_int <= '1';
                    if start = '1' then
                        state <= LOAD;
                        idx_x <= 0;
                        idx_h <= 0;
                        i <= 0;
                        j <= 0;
                        y_mem <= (others => (others => '0'));
                        done_int  <= '0';
                    end if;

            end case;
        end if;
    end process;

    -- saída endereçável
    y_out <= std_logic_vector(y_mem(to_integer(unsigned(y_index))));
    done  <= done_int;

end Behavioral;
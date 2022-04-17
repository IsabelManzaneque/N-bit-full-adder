
------------------------------------------------------------------
-- Circuito Sumador de dos números de N bit
-- Entity y architecture 
-- Fichero: sum_Nbit.vdh

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity
entity sum_Nbit is 
  generic (n                         : integer := 4);  -- caso por defecto es 4
  port (desbordamiento, cero, signo  : out std_logic;
        res                          : out signed (n-1 downto 0); 
        a, b                         : in signed (n-1 downto 0);  
        cin                          : in std_logic);  
end entity sum_Nbit;

-- Architecture
architecture comp_sum_Nbit of sum_Nbit is  
  signal resultado     :  signed (n-1 downto 0);
  signal resOperacion  :  std_logic;
  signal rebose        :  std_logic;  
 
begin  
   
   -- Señales internas 
   resultado      <=   a + b + ("0"&cin);                  
   resOperacion   <=   '0' when unsigned(resultado) = 0 -- resOperación es 0 cuando el resultado 
                       else '1';                        -- de la suma es 0 en otro caso, será 1
   rebose         <=   (not a(n-1) and not b(n-1) and resultado(n-1)) 
                        or (a(n-1) and b(n-1) and not resultado(n-1));
   
   -- Señales de salida
   res            <=   resultado;
   desbordamiento <=   rebose;
   cero           <=   not resOperacion and not rebose;   
   signo          <=   resultado(n-1) xor rebose;

end architecture comp_sum_Nbit;
----------------------------------------------------------------
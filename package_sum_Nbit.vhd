-----------------------------------------------------------------
-- Package para la función to_string
-- Fichero: package_sum_Nbit.vdh

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package package_sum_Nbit is
   function to_string ( a: std_logic_vector) return string;
end package package_sum_Nbit;

package body package_sum_Nbit is

   function to_string ( a: std_logic_vector) return string is
     variable b : string (1 to a'length) := (others => NUL);
     variable str : integer := 1; 
   begin
     for i in a'range loop
         b(str) := std_logic'image(a((i)))(2);
         str := str+1;
     end loop;
     return b;
   end function;

end package body package_sum_Nbit;
-----------------------------------------------------------------

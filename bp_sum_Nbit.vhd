-----------------------------------------------------------------
-- Banco de pruebas del circuito Sumador de dos número de N bit
-- Banco de pruebas
-- Fichero: bp_sum_Nbit.vdh

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.package_sum_Nbit.all;

-- Entity 
entity bp_sum_Nbit is  
  generic (n : integer := 4);
end entity bp_sum_Nbit;

-- Architecture
architecture bp_sum_Nbit of bp_sum_Nbit is
  
   -- Señales para conectar el UUT
   signal desbordamiento, cero, signo   : std_logic;             
   signal res                           : signed (n-1 downto 0); 
   signal a, b                          : signed (n-1 downto 0);   
   signal cin                           : signed (1 downto 0);  
   
   -- Componente que se va a probar
   component sum_Nbit is 
     generic (n                         : integer := 4); 
     port (desbordamiento, cero, signo  : out std_logic;
           res                          : out signed (n-1 downto 0); 
           a, b                         : in signed (n-1 downto 0);  
           cin                          : in std_logic);
   end component sum_Nbit;

-- Unidad de pruebas 
begin  
   --Instanciar y conectar UUT
   uut : component sum_Nbit port map
         (desbordamiento, cero, signo, res, a, b, cin(0));   

   -- Crear vector de test y comprobar salidas del UUT
   vec_test : process is
     variable res_esperado            : signed (n-1 downto 0);    -- Resultado esperado de la suma
     variable desbordamiento_esperado : std_logic;                -- Desbordamiento esperado de la suma
     variable cero_esperado           : std_logic;                -- Senal cero esperada de la sema
     variable signo_esperado          : std_logic;                -- signo esperado de la suma
     variable error_count             : integer := 0;             -- Contador de errores
     variable resOperacion            : std_logic;                -- Resultado de la suma
     variable suma_parcial            : unsigned (n-1 downto 0);  -- suma de los primeros 0 a n-2 bits
     variable carry_out               : std_logic;                -- carry out de la suma

   begin
     -- Se generan los posibles valores de entrada 
     for numero1 in 0 to 2**n-1 loop
       for numero2 in 0 to 2**n-1 loop
         for carry_in in 0 to 1 loop
      	   
           -- Se asignan valores de entrada a la UUT
           a   <= to_signed(numero1,n);
           b   <= to_signed(numero2,n);
           cin <= to_signed(carry_in,2);         
           wait for 1 ns; 

           -- Cálculo de los valores esperados                     
           res_esperado   := to_signed(carry_in,n) + to_signed(numero1,n) + to_signed( numero2 ,n);                  
   
           suma_parcial   := "0" & to_unsigned(carry_in,n-1) + to_unsigned(numero1,n-1) + to_unsigned( numero2 ,n-1); -- calcula suma parcial
           carry_out      := (a(n-1) and b(n-1)) or (a(n-1) and suma_parcial(n-1)) or (b(n-1) and suma_parcial(n-1)); -- calcula carry_out
           desbordamiento_esperado := carry_out xor suma_parcial(n-1);                                                -- calcula el desbordamiento      
           
           signo_esperado := res_esperado(n-1) xor desbordamiento_esperado ;

           if ( unsigned(res_esperado) = 0) then 
               resOperacion := '0';
           else 
               resOperacion := '1';
           end if; 

           cero_esperado  := not resOperacion and not desbordamiento_esperado;      
           
           -- Se muestran los resultados obtenidos en la iteración
           report "res esperado - " & (to_string(std_logic_vector(res_esperado))) & 
                  "  res UUT - " & (to_string(std_logic_vector(res))) &
                  "  desborda esperado - " &std_logic' image (desbordamiento_esperado) &
                  "  desborda UUT - " & std_logic' image (desbordamiento) &
                  "  signo esperado - " & std_logic' image (signo_esperado)&
                  "  signo UUT - " & std_logic' image (signo) &
                  "  cero esperado - " & std_logic' image (cero_esperado) &
                  "  cero UUT - " & std_logic' image (cero); 
            
           -- Si se detecta un error, se informa al usuario y aumenta el contador          
           if (res_esperado /=  res ) or (desbordamiento_esperado /= desbordamiento) 
               or (signo_esperado /= signo) or (cero_esperado /= cero) then
               error_count := error_count + 1;
               report "Se ha encontrado un error. Total de errores: " & integer' image(error_count);     
           end if;
         
         end loop;
       end loop;
     end loop;
     -- Se informa del total de errores y termina la simulación
     report "Test terminado con " & integer' image(error_count) &  " errores.";     
     wait; 
   end process vec_test;
end architecture bp_sum_Nbit;
------------------------------------------------------------------
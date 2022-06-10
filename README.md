# N-bit-full-adder

Circuito combinacional que realiza la suma con acarreo de entrada de dos número binarios con signo.

## Contenido
* [Descripción](#descripción)
* [Recursos](#recursos)


## Descripción

Código VHDL de un circuito combinacional que realiza la suma con acarreo de entrada de dos número binarios con signo (representados en complemento a 2) y además proporciona tres señales de salida que informan de si ha habido desbordamiento en la suma, si el resultado es cero y el signo que debiera tener el resultado.

El circuito tiene las siguientes señales de entrada: los operandos de n bits a y b y una señal de acarreo de entrada un bit llamada cin.

El circuito tiene las siguientes señales de salida: el resultado de n bits res y las señales de 1 bit desbordamiento, cero y signo. Las señales de salida tienen el siguiente comportamiento:
- El valor de la señal desbordamiento es '1' solo si la operación de suma produce desbordamiento; en cualquier otro caso su valor es '0'. 
- El valor de la señal cero es '1' solo si el resultado de la operación tiene valor cero y, además, no existe desbordamiento. En cualquier otro caso su valor es '0'.
- El valor de la señal signo es el mismo bit de signo del resultado de la suma solo si no existe desbordamiento; en caso de existir desbordamiento, el signo es
el inverso al resultado de la suma.

El diseño del circuito se compone de la entity y la architecture que describe el comportamiento del circuito combinacional empleando solo sentencias concurrentes. Además, se programa un banco de pruebas que testea todas las posibles entradas del circuito.

## Recursos
El proyecto se ha desarrollado usando:
* ModelSim 2021.1

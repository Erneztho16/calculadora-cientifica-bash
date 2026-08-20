#  Calculadora Científica en Bash

Calculadora científica desarrollada en **Bash para Linux**, como proyecto académico para demostrar el uso de programación de scripts, operaciones matemáticas, validaciones, modularización y pruebas automáticas.

---

##  Descripción

Este proyecto consiste en una calculadora científica ejecutada desde la terminal de Linux.

La aplicación permite realizar diferentes operaciones matemáticas mediante un menú interactivo, incluyendo operaciones básicas, funciones trigonométricas, logaritmos, potencias, raíces, factoriales, porcentajes y constantes matemáticas.

El proyecto está desarrollado utilizando **Bash** y la herramienta **bc** para realizar cálculos numéricos con alta precisión.

---

##  Características

- Interfaz interactiva desde la terminal.
- Operaciones matemáticas básicas.
- Potencias y raíces.
- Funciones trigonométricas.
- Funciones trigonométricas inversas.
- Logaritmos.
- Factorial.
- Porcentajes.
- Valor absoluto.
- Constantes matemáticas.
- Conversión entre grados y radianes.
- Historial de operaciones.
- Validación de entradas.
- Manejo de errores matemáticos.
- Resultados con precisión configurable.
- Pruebas automáticas.
- Código organizado en módulos.

---

##  Operaciones disponibles

### Operaciones básicas

- Suma
- Resta
- Multiplicación
- División

### Potencias y raíces

- Potencias
- Raíz cuadrada
- Raíz cúbica
- Raíces mediante exponentes

### Trigonometría

- Seno
- Coseno
- Tangente
- Arcoseno
- Arcocoseno
- Arcotangente

### Logaritmos

- Logaritmo natural `ln`
- Logaritmo base 10
- Logaritmo en cualquier base

### Operaciones especiales

- Factorial
- Porcentaje
- Valor absoluto

### Resolución de expresiones

La calculadora permite resolver expresiones matemáticas combinadas utilizando diferentes operadores y funciones científicas en una misma expresión.

Ejemplos:


- (2+3)*4.
- 3/4+5/6.
- sqrt(144)+5^2.
- sin(30)*10.
- sin(30)*(3/4+5/6).
- cos(60)+sqrt(25).

# La resolución de expresiones permite utilizar:

- + Suma.
- - Resta.
- * Multiplicación.
- / División.
- ^ Potencia.
- ( ) Paréntesis.
- sqrt() Raíz cuadrada.
- sin() Seno.
- cos() Coseno.
- tan() Tangente.
- ln() Logaritmo natural.
- log10() Logaritmo base 10.
- pi Constante π.
- e Constante de Euler.

### Constantes matemáticas

- π (Pi)
- e (Número de Euler)

---

##  Validaciones

La calculadora incorpora validaciones para evitar operaciones matemáticamente inválidas.

Algunos ejemplos:

- División entre cero.
- Logaritmos de números menores o iguales que cero.
- Bases de logaritmos inválidas.
- Raíces cuadradas de números negativos.
- Entradas no numéricas.
- Opciones inválidas en los menús.

---

## Modo angular

Las funciones trigonométricas trabajan utilizando grados:

[DEG]
Esto permite introducir valores como: sin(30)
y obtener aproximadamente: 0.5


## Precisión

Los cálculos internos utilizan bc -l con una escala configurable.

Actualmente se utiliza:ESCALA=30

Esto permite realizar cálculos con una precisión interna de hasta 30 posiciones decimales.

Los resultados mostrados al usuario se formatean para facilitar su lectura.

Pruebas automáticas

El proyecto incluye un sistema de pruebas ubicado en:

tests/test_calculadora.sh

Para ejecutar las pruebas:

./tests/test_calculadora.sh

## Actualmente el proyecto cuenta con:

19 pruebas realizadas
19 pruebas exitosas
0 pruebas con error

Resultado:

## TODAS LAS PRUEBAS FUERON EXITOSAS

Las pruebas incluyen:

Operaciones básicas.
Potencias.
Raíces.
Logaritmos.
Factorial.
Porcentajes.
Valor absoluto.
Constantes matemáticas.
Validaciones de errores.

#  Estructura del proyecto

Calculadora-cientifica-bash/
│
├── calculadora.sh
│
├── data/
│   └── .gitkeep
│
├── lib/
│   ├── historial.sh
│   ├── interfaz.sh
│   ├── matematicas.sh
│   ├── trigonometria.sh
│   └── validaciones.sh
│
├── tests/
│   └── test_calculadora.sh
│
├── .gitignore
└── README.md



calculadora.sh es el archivo principal que inicia la aplicación y controla el flujo general de la calculadora.

lib/matematicas.sh

Contiene las funciones relacionadas con operaciones matemáticas.

lib/trigonometria.sh

Contiene las funciones trigonométricas y el manejo del modo angular.

lib/validaciones.sh

Contiene las validaciones utilizadas para controlar las entradas del usuario y evitar operaciones inválidas.

lib/historial.sh

Gestiona el almacenamiento y consulta del historial de operaciones.

lib/interfaz.sh

Contiene elementos relacionados con la presentación de los menús y la interfaz de la aplicación.

tests/test_calculadora.sh

Contiene las pruebas automáticas del proyecto.

## Requisitos

Para ejecutar el proyecto se necesita:

Linux
Bash
bc

Puedes comprobar Bash con:

bash --version

Y comprobar bc con:

bc --version

Si bc no está instalado sigue los siguientes pasos:
primero escribe  sudo apt update  y luego, sudo apt install bc y solo queda esperar que se instale.

# Para clonar el repositorio:

git clone https://github.com/Erneztho16/calculadora-cientifica-bash.git

Entrar al directorio:

cd Calculadora-cientifica-bash

Dar permisos de ejecución:

chmod +x calculadora.sh
chmod +x tests/test_calculadora.sh

#Ejecución

Para iniciar la calculadora:

./calculadora.sh
Ejecutar pruebas

Para ejecutar las pruebas automáticas:

./tests/test_calculadora.sh

# Tecnologías utilizadas

Bash
Linux
GNU bc
Git
GitHub

 Objetivo académico

El objetivo del proyecto es aplicar conocimientos de programación en Bash y Linux mediante el desarrollo de una aplicación científica modular, incorporando:

Programación de scripts.
Funciones.
Modularización.
Validación de datos.
Manejo de errores.
Procesamiento numérico.
Archivos.
Pruebas automáticas.
Control de versiones con Git.

Autores

Ernesto Gonzalez.

Pablo Jacinto.

Proyecto académico desarrollado en Bash para Linux.

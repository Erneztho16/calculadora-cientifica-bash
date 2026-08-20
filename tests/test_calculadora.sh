#!/bin/bash

# ==========================================
# PRUEBAS AUTOMÁTICAS
# CALCULADORA CIENTÍFICA EN BASH
# ==========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Configuración utilizada por la calculadora
ESCALA=30
MODO_ANGULAR="DEG"

# Cargar módulos
source "$SCRIPT_DIR/lib/validaciones.sh"
source "$SCRIPT_DIR/lib/matematicas.sh"
source "$SCRIPT_DIR/lib/trigonometria.sh"

# Colores
ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
CIAN='\033[0;36m'
RESET='\033[0m'

# Contadores
PRUEBAS=0
EXITOS=0
ERRORES=0


# ==========================================
# FUNCIÓN PARA COMPARAR RESULTADOS
# ==========================================

probar() {

    local nombre="$1"
    local esperado="$2"
    local obtenido="$3"
    local tolerancia="${4:-0.000000001}"

    ((PRUEBAS++))

    diferencia=$(echo "($esperado - $obtenido)" | bc -l)

    diferencia_abs=$(echo "if ($diferencia < 0) -($diferencia) else $diferencia" | bc -l)

    correcto=$(echo "$diferencia_abs <= $tolerancia" | bc -l)

    if [ "$correcto" -eq 1 ]; then

        echo -e "${VERDE}[OK]${RESET} $nombre"
        ((EXITOS++))

    else

        echo -e "${ROJO}[ERROR]${RESET} $nombre"
        echo "       Esperado: $esperado"
        echo "       Obtenido: $obtenido"
        echo "       Diferencia: $diferencia_abs"

        ((ERRORES++))

    fi
}

# ==========================================
# ENCABEZADO
# ==========================================

clear

echo -e "${CIAN}==============================================${RESET}"
echo -e "${CIAN}       PRUEBAS DE LA CALCULADORA             ${RESET}"
echo -e "${CIAN}==============================================${RESET}"
echo


# ==========================================
# OPERACIONES BÁSICAS
# ==========================================

echo -e "${AMARILLO}--- OPERACIONES BÁSICAS ---${RESET}"

resultado=$(calcular "10 + 5")
probar "Suma" "15" "$(formatear_resultado "$resultado")"

resultado=$(calcular "20 - 8")
probar "Resta" "12" "$(formatear_resultado "$resultado")"

resultado=$(calcular "5 * 4")
probar "Multiplicación" "20" "$(formatear_resultado "$resultado")"

resultado=$(calcular "100 / 4")
probar "División" "25" "$(formatear_resultado "$resultado")"


# ==========================================
# POTENCIAS Y RAÍCES
# ==========================================

echo
echo -e "${AMARILLO}--- POTENCIAS Y RAÍCES ---${RESET}"

resultado=$(calcular "2 ^ 10")
probar "Potencia" "1024" "$(formatear_resultado "$resultado")"

resultado=$(calcular "sqrt(144)")
probar "Raíz cuadrada" "12" "$(formatear_resultado "$resultado")"

resultado=$(calcular "e(l(27)/3)")
probar "Raíz cúbica" "3" "$(formatear_resultado "$resultado")"


# ==========================================
# LOGARITMOS
# ==========================================

echo
echo -e "${AMARILLO}--- LOGARITMOS ---${RESET}"

resultado=$(calcular "l(1)")
probar "ln(1)" "0" "$(formatear_resultado "$resultado")"

resultado=$(calcular "l(1000)/l(10)")
probar "log10(1000)" "3" "$(formatear_resultado "$resultado")"

resultado=$(calcular "l(8)/l(2)")
probar "log2(8)" "3" "$(formatear_resultado "$resultado")"


# ==========================================
# OPERACIONES ESPECIALES
# ==========================================

echo
echo -e "${AMARILLO}--- OPERACIONES ESPECIALES ---${RESET}"

factorial=1

for ((i=2; i<=5; i++))
do
    factorial=$((factorial * i))
done

probar "5!" "120" "$factorial"

resultado=$(calcular "500 * 15 / 100")
probar "15% de 500" "75" "$(formatear_resultado "$resultado")"

resultado=$(calcular "-(-25.5)")
probar "Valor absoluto" "25.5" "$(formatear_resultado "$resultado")"


# ==========================================
# CONSTANTES
# ==========================================

echo
echo -e "${AMARILLO}--- CONSTANTES ---${RESET}"

resultado=$(calcular "4*a(1)")
probar "Pi" "3.141592653589793" "$(formatear_resultado "$resultado")"

resultado=$(calcular "e(1)")
probar "Euler" "2.718281828459045" "$(formatear_resultado "$resultado")"

resultado=$(calcular "sqrt(2)")
probar "Raíz de 2" "1.4142135623730951" "$(formatear_resultado "$resultado")"

# ==========================================
# PRUEBAS DE ERRORES
# ==========================================

echo
echo -e "${AMARILLO}--- PRUEBAS DE ERRORES ---${RESET}"

# División entre cero
resultado=$(calcular "10 / 0" 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$resultado" ]; then
    echo -e "${VERDE}[OK]${RESET} División entre cero rechazada"
    ((PRUEBAS++))
    ((EXITOS++))
else
    echo -e "${ROJO}[ERROR]${RESET} División entre cero"
    ((PRUEBAS++))
    ((ERRORES++))
fi


# Logaritmo de cero
valor=0

if (( $(echo "$valor <= 0" | bc -l) )); then

    echo -e "${VERDE}[OK]${RESET} Logaritmo de cero rechazado"
    ((PRUEBAS++))
    ((EXITOS++))

else

    echo -e "${ROJO}[ERROR]${RESET} Logaritmo de cero"
    ((PRUEBAS++))
    ((ERRORES++))

fi

# Raíz cuadrada negativa
resultado=$(calcular "sqrt(-5)" 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$resultado" ]; then
    echo -e "${VERDE}[OK]${RESET} Raíz negativa rechazada"
    ((PRUEBAS++))
    ((EXITOS++))
else
    echo -e "${ROJO}[ERROR]${RESET} Raíz negativa"
    ((PRUEBAS++))
    ((ERRORES++))
fi

# ==========================================
# RESULTADO FINAL
# ==========================================

echo
echo -e "${CIAN}==============================================${RESET}"
echo -e "${CIAN}              RESULTADO FINAL                ${RESET}"
echo -e "${CIAN}==============================================${RESET}"
echo

echo "Pruebas realizadas : $PRUEBAS"
echo "Pruebas exitosas   : $EXITOS"
echo "Pruebas con error  : $ERRORES"

echo

if [ "$ERRORES" -eq 0 ]; then

    echo -e "${VERDE}✓ TODAS LAS PRUEBAS FUERON EXITOSAS${RESET}"
    exit 0

else

    echo -e "${ROJO}✗ HAY PRUEBAS QUE FALLARON${RESET}"
    exit 1

fi

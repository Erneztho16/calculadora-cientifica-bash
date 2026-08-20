#!/bin/bash

# ==========================================
# CONVERTIR FUNCIONES CIENTÍFICAS
# ==========================================

convertir_expresion() {

    local expresion="$1"
    local angulo
    local radianes
    local valor

    # ==========================================
    # CONSTANTES
    # ==========================================

    expresion=$(echo "$expresion" | sed 's/\bpi\b/4*a(1)/g')
    expresion=$(echo "$expresion" | sed 's/\be\b/e(1)/g')


    # ==========================================
    # RAÍCES
    # ==========================================

    # sqrt(numero)
    while [[ "$expresion" =~ sqrt\(([0-9.]+)\) ]]
    do
        valor="${BASH_REMATCH[1]}"
        expresion="${expresion/${BASH_REMATCH[0]}/sqrt($valor)}"
        break
    done


    # ==========================================
    # LOGARITMOS
    # ==========================================

    while [[ "$expresion" =~ ln\(([0-9.]+)\) ]]
    do
        valor="${BASH_REMATCH[1]}"
        expresion="${expresion/${BASH_REMATCH[0]}/l($valor)}"
    done

    while [[ "$expresion" =~ log10\(([0-9.]+)\) ]]
    do
        valor="${BASH_REMATCH[1]}"
        expresion="${expresion/${BASH_REMATCH[0]}/l($valor)/l(10)}"
    done


    # ==========================================
    # SENO
    # ==========================================

    while [[ "$expresion" =~ sin\(([0-9.+-]+)\) ]]
    do
        angulo="${BASH_REMATCH[1]}"
        radianes=$(a_radianes "$angulo")

        expresion="${expresion/${BASH_REMATCH[0]}/s($radianes)}"
    done


    # ==========================================
    # COSENO
    # ==========================================

    while [[ "$expresion" =~ cos\(([0-9.+-]+)\) ]]
    do
        angulo="${BASH_REMATCH[1]}"
        radianes=$(a_radianes "$angulo")

        expresion="${expresion/${BASH_REMATCH[0]}/c($radianes)}"
    done


    # ==========================================
    # TANGENTE
    # ==========================================

    while [[ "$expresion" =~ tan\(([0-9.+-]+)\) ]]
    do
        angulo="${BASH_REMATCH[1]}"
        radianes=$(a_radianes "$angulo")

        expresion="${expresion/${BASH_REMATCH[0]}/s($radianes)/c($radianes)}"
    done


    echo "$expresion"
}


# ==========================================
# RESOLVER EXPRESIÓN
# ==========================================

resolver_expresion() {

    clear

    echo -e "${CIAN}==============================================${RESET}"
    echo -e "${CIAN}          RESOLVER EXPRESIÓN                 ${RESET}"
    echo -e "${CIAN}==============================================${RESET}"
    echo

    echo "Operadores:"
    echo "  +  Suma"
    echo "  -  Resta"
    echo "  *  Multiplicación"
    echo "  /  División"
    echo "  ^  Potencia"
    echo "  ( ) Paréntesis"
    echo

    echo "Funciones:"
    echo "  sqrt(x)    Raíz cuadrada"
    echo "  sin(x)     Seno"
    echo "  cos(x)     Coseno"
    echo "  tan(x)     Tangente"
    echo "  ln(x)      Logaritmo natural"
    echo "  log10(x)   Logaritmo base 10"
    echo "  pi         Constante PI"
    echo "  e          Constante Euler"
    echo

    read -p "Ingrese la expresión: " expresion

    if [ -z "$expresion" ]; then
        echo
        echo -e "${ROJO}Error: no se ingresó ninguna expresión.${RESET}"
        read -p "Presione ENTER para continuar..."
        return
    fi

    expresion_convertida=$(convertir_expresion "$expresion")

    resultado=$(calcular "$expresion_convertida")
    codigo=$?

    if [ $codigo -ne 0 ] || [ -z "$resultado" ]; then

        echo
        echo -e "${ROJO}Error: expresión matemática inválida.${RESET}"

    else

        resultado_formateado=$(formatear_resultado "$resultado")

        echo
        echo -e "${VERDE}Expresión:${RESET} $expresion"
        echo -e "${VERDE}Resultado:${RESET} $resultado_formateado"

        guardar_historial "$expresion = $resultado_formateado"
    fi

    echo
    read -p "Presione ENTER para continuar..."
}

#!/bin/bash

# ==========================================
# INTERFAZ DE LA CALCULADORA
# ==========================================

mostrar_encabezado() {

    clear

    echo -e "${CIAN}==============================================${RESET}"
    echo -e "${CIAN}       CALCULADORA CIENTÍFICA EN BASH         ${RESET}"
    echo -e "${CIAN}==============================================${RESET}"
    echo
    echo -e "Modo angular: ${AMARILLO}$MODO_ANGULAR${RESET}"
    echo
}


mostrar_menu() {

    echo "1) Operaciones básicas"
    echo "2) Potencias y raíces"
    echo "3) Logaritmos"
    echo "4) Funciones trigonométricas"
    echo "5) Factorial y operaciones especiales"
    echo "6) Constantes matemáticas"
    echo "7) Modo angular [$MODO_ANGULAR]"
    echo "8) Historial"
    echo "9) Salir"
    echo
}



# ==========================================
# CONFIGURAR MODO ANGULAR
# ==========================================

configurar_modo_angular() {

    while true
    do
        clear

        echo -e "${CIAN}==============================================${RESET}"
        echo -e "${CIAN}            MODO ANGULAR                      ${RESET}"
        echo -e "${CIAN}==============================================${RESET}"
        echo
        echo "Modo actual: $MODO_ANGULAR"
        echo
        echo "1) DEG - Grados"
        echo "2) RAD - Radianes"
        echo "3) Volver"
        echo

        read -p "Seleccione una opción: " opcion

        case $opcion in

            1)
                MODO_ANGULAR="DEG"

                echo
                echo -e "${VERDE}Modo cambiado a DEG (grados).${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;

            2)
                MODO_ANGULAR="RAD"

                echo
                echo -e "${VERDE}Modo cambiado a RAD (radianes).${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;

            3)
                return
                ;;

            *)
                echo
                echo -e "${ROJO}Opción no válida.${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;

        esac
    done
}


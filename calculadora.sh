#!/bin/bash

# ==========================================
# CARGAR MÓDULOS
# ==========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/validaciones.sh"
source "$SCRIPT_DIR/lib/matematicas.sh"
source "$SCRIPT_DIR/lib/trigonometria.sh"
source "$SCRIPT_DIR/lib/interfaz.sh"
source "$SCRIPT_DIR/lib/historial.sh"
source "$SCRIPT_DIR/lib/expresiones.sh"


# Precisión interna
ESCALA=30

# Modo angular
MODO_ANGULAR="DEG"

# ==========================================
# CALCULADORA CIENTÍFICA EN BASH
# ==========================================

# Colores
ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
AZUL='\033[0;34m'
CIAN='\033[0;36m'
RESET='\033[0m'


# Programa principal
while true
do
    mostrar_encabezado
    mostrar_menu

    read -p "Ingrese una opción: " opcion

    case $opcion in

        1)
           operaciones_basicas
           ;;

        2)
            potencias_raices
            ;;

        3)
            logaritmos
            ;;

        4)
            trigonometria
            ;;


        5)
            operaciones_especiales
            ;;

        6)
            constantes_matematicas
            ;;

        7)
            configurar_modo_angular
            ;;

        8)
            historial
            ;;

        9)
            resolver_expresion
            ;;
            
        10)
            echo
            echo -e "${VERDE}Gracias por utilizar la calculadora.${RESET}"
            exit 0
            ;;
            
        *)
            echo
            echo -e "${ROJO}Opción no válida.${RESET}"
            read -p "Presione ENTER para continuar..."
            ;;

    esac
done

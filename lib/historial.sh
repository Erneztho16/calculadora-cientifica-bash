#!/bin/bash

# ==========================================
# CONFIGURACIÓN DEL HISTORIAL
# ==========================================

ARCHIVO_HISTORIAL="$(cd "$(dirname "${BASH_SOURCE[0]}")/../data" && pwd)/historial.txt"


# ==========================================
# GUARDAR OPERACIÓN
# ==========================================

guardar_historial() {

    local operacion="$1"

    echo "$operacion" >> "$ARCHIVO_HISTORIAL"
}


# ==========================================
# MOSTRAR HISTORIAL
# ==========================================

mostrar_historial() {

    clear

    echo -e "${CIAN}==============================================${RESET}"
    echo -e "${CIAN}                 HISTORIAL                   ${RESET}"
    echo -e "${CIAN}==============================================${RESET}"
    echo

    if [ ! -s "$ARCHIVO_HISTORIAL" ]; then

        echo -e "${AMARILLO}No hay operaciones registradas.${RESET}"

    else

        nl -w2 -s'. ' "$ARCHIVO_HISTORIAL"

    fi

    echo
    read -p "Presione ENTER para continuar..."
}


# ==========================================
# LIMPIAR HISTORIAL
# ==========================================

limpiar_historial() {

    clear

    echo -e "${CIAN}==============================================${RESET}"
    echo -e "${CIAN}             LIMPIAR HISTORIAL               ${RESET}"
    echo -e "${CIAN}==============================================${RESET}"
    echo

    if [ ! -s "$ARCHIVO_HISTORIAL" ]; then

        echo -e "${AMARILLO}El historial ya está vacío.${RESET}"

    else

        read -p "¿Está seguro de eliminar todo el historial? [s/N]: " confirmar

        case "$confirmar" in

            s|S)

                > "$ARCHIVO_HISTORIAL"

                echo
                echo -e "${VERDE}Historial eliminado correctamente.${RESET}"
                ;;

            *)

                echo
                echo -e "${AMARILLO}Operación cancelada.${RESET}"
                ;;

        esac

    fi

    echo
    read -p "Presione ENTER para continuar..."
}


# ==========================================
# MENÚ DEL HISTORIAL
# ==========================================

historial() {

    while true
    do
        clear

        echo -e "${CIAN}==============================================${RESET}"
        echo -e "${CIAN}                  HISTORIAL                  ${RESET}"
        echo -e "${CIAN}==============================================${RESET}"
        echo
        echo "1) Ver historial"
        echo "2) Limpiar historial"
        echo "3) Volver al menú principal"
        echo

        read -p "Seleccione una opción: " opcion

        case $opcion in

            1)
                mostrar_historial
                ;;

            2)
                limpiar_historial
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

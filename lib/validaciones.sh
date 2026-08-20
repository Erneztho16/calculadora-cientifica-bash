#!/bin/bash

# ==========================================
# VALIDACIONES
# ==========================================

validar_numero() {

    local numero="$1"

    if [[ "$numero" =~ ^-?([0-9]+([.][0-9]*)?|[.][0-9]+)$ ]]; then
        return 0
    else
        return 1
    fi
}


validar_entero() {

    local numero="$1"

    if [[ "$numero" =~ ^-?[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}


pedir_numero() {

    local mensaje="$1"
    local numero

    while true
    do
        read -p "$mensaje" numero

        if validar_numero "$numero"; then
            echo "$numero"
            return 0
        fi

        echo
        echo -e "${ROJO}Error: debe ingresar un número válido.${RESET}"
        echo
    done
}


pedir_entero() {

    local mensaje="$1"
    local numero

    while true
    do
        read -p "$mensaje" numero

        if validar_entero "$numero"; then
            echo "$numero"
            return 0
        fi

        echo
        echo -e "${ROJO}Error: debe ingresar un número entero.${RESET}"
        echo
    done
}

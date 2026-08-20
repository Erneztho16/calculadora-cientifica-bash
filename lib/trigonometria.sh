#!/bin/bash

# ==========================================
# FUNCIONES TRIGONOMÉTRICAS
# ==========================================

# Convertir a radianes
a_radianes() {

    local angulo="$1"

    if [ "$MODO_ANGULAR" = "DEG" ]; then

        calcular "$angulo * 4*a(1)/180"

    else

        echo "$angulo"

    fi
}


# Convertir a grados
a_grados() {

    local angulo="$1"

    if [ "$MODO_ANGULAR" = "DEG" ]; then

        calcular "$angulo * 180/(4*a(1))"

    else

        echo "$angulo"

    fi
}


# ==========================================
# TRIGONOMETRÍA
# ==========================================

trigonometria() {

    while true
    do
        clear

        echo -e "${CIAN}==============================================${RESET}"
        echo -e "${CIAN}          FUNCIONES TRIGONOMÉTRICAS            ${RESET}"
        echo -e "${CIAN}==============================================${RESET}"
        echo
        echo -e "Modo angular actual: ${AMARILLO}$MODO_ANGULAR${RESET}"
        echo
        echo "1) Seno"
        echo "2) Coseno"
        echo "3) Tangente"
        echo "4) Arco seno"
        echo "5) Arco coseno"
        echo "6) Arco tangente"
        echo "7) Volver al menú principal"
        echo

        read -p "Seleccione una opción: " opcion

        case $opcion in

            1)
                angulo=$(pedir_numero "Ingrese el ángulo: ")

                radianes=$(a_radianes "$angulo")

                resultado=$(calcular "s($radianes)")

                if [ $? -ne 0 ]; then

                    echo
                    echo -e "${ROJO}Error: no se pudo calcular el seno.${RESET}"

                else

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "sin($angulo) [$MODO_ANGULAR] = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}sin($angulo) = $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            2)
                angulo=$(pedir_numero "Ingrese el ángulo: ")

                radianes=$(a_radianes "$angulo")

                resultado=$(calcular "c($radianes)")

                if [ $? -ne 0 ]; then

                    echo
                    echo -e "${ROJO}Error: no se pudo calcular el coseno.${RESET}"

                else

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "cos($angulo) [$MODO_ANGULAR] = $resultado_formateado"
                    echo
                    echo -e "${VERDE}cos($angulo) = $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            3)
                angulo=$(pedir_numero "Ingrese el ángulo: ")

                radianes=$(a_radianes "$angulo")

                coseno=$(calcular "c($radianes)")

                if [ $? -ne 0 ]; then

                    echo
                    echo -e "${ROJO}Error: no se pudo calcular la tangente.${RESET}"

                elif (( $(echo "sqrt($coseno^2) < 0.0000000001" | bc -l) )); then

                    echo
                    echo -e "${ROJO}Error: la tangente no está definida para este ángulo.${RESET}"

                else

                    resultado=$(calcular "s($radianes)/c($radianes)")

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "tan($angulo) [$MODO_ANGULAR] = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}tan($angulo) = $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            4)
                numero=$(pedir_numero "Ingrese el valor: ")

                if (( $(echo "$numero < -1 || $numero > 1" | bc -l) )); then

                     echo
                     echo -e "${ROJO}Error: el arco seno requiere un valor entre -1 y 1.${RESET}"

                elif (( $(echo "$numero == 1" | bc -l) )); then

                     resultado="1.5707963267948966"

                     resultado_formateado=$(formatear_resultado "$(a_grados "$resultado")")

                     echo
                     echo -e "${VERDE}arcsin($numero) = $resultado_formateado°${RESET}"

                elif (( $(echo "$numero == -1" | bc -l) )); then

                     resultado="-1.5707963267948966"

                     resultado_formateado=$(formatear_resultado "$(a_grados "$resultado")")

                     echo
                     echo -e "${VERDE}arcsin($numero) = $resultado_formateado°${RESET}"

                else

                    resultado=$(calcular "a($numero/sqrt(1-($numero^2)))")

                    resultado_formateado=$(formatear_resultado "$(a_grados "$resultado")")
                    guardar_historial "asin($valor) [$MODO_ANGULAR] = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}arcsin($numero) = $resultado_formateado°${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            5)
                 numero=$(pedir_numero "Ingrese el valor: ")

                 if (( $(echo "$numero < -1 || $numero > 1" | bc -l) )); then

                     echo
                     echo -e "${ROJO}Error: el arco coseno requiere un valor entre -1 y 1.${RESET}"

                 else

                     resultado=$(calcular "a(sqrt(1-($numero^2))/$numero)")

                 if (( $(echo "$numero == 0" | bc -l) )); then
                     resultado=$(calcular "4*a(1)/2")
                 fi

                     resultado_formateado=$(formatear_resultado "$(a_grados "$resultado")")
                     guardar_historial "acos($valor) [$MODO_ANGULAR] = $resultado_formateado"
                     
                     echo
                     echo -e "${VERDE}arccos($numero) = $resultado_formateado°${RESET}"

                 fi

                 read -p "Presione ENTER para continuar..."
                 ;;


            6)
                numero=$(pedir_numero "Ingrese el valor: ")

                resultado=$(calcular "a($numero)")

                if [ $? -ne 0 ]; then

                    echo
                    echo -e "${ROJO}Error: no se pudo calcular el arco tangente.${RESET}"

                else

                    resultado_formateado=$(formatear_resultado "$(a_grados "$resultado")")
                    guardar_historial "atan($valor) [$MODO_ANGULAR] = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}arctan($numero) = $resultado_formateado°${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            7)
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

#!/bin/bash

# ==========================================
# FUNCIONES MATEMÁTICAS
# ==========================================

calcular() {

    local expresion="$1"
    local resultado

    resultado=$(echo "scale=$ESCALA; $expresion" | bc -l 2>/dev/null)

    if [ $? -ne 0 ] || [ -z "$resultado" ]; then
        return 1
    fi

    # Rechazar resultados infinitos o no numéricos
    case "$resultado" in
        *inf*|*Inf*|*INF*|*nan*|*NaN*|*NAN*)
            return 1
            ;;
    esac

    echo "$resultado"
}


formatear_resultado() {

    printf "%.10f\n" "$1" | sed 's/0*$//;s/\.$//'
}


# ==========================================
# OPERACIONES BÁSICAS
# ==========================================

operaciones_basicas() {

    while true
    do
        clear

        echo -e "${CIAN}==============================================${RESET}"
        echo -e "${CIAN}          OPERACIONES BÁSICAS                 ${RESET}"
        echo -e "${CIAN}==============================================${RESET}"
        echo
        echo "1) Suma"
        echo "2) Resta"
        echo "3) Multiplicación"
        echo "4) División"
        echo "5) Volver al menú principal"
        echo

        read -p "Seleccione una opción: " operacion

        case $operacion in

            1)
                num1=$(pedir_numero "Ingrese el primer número: ")
                num2=$(pedir_numero "Ingrese el segundo número: ")

                resultado=$(calcular "$num1 + $num2")

                resultado_formateado=$(formatear_resultado "$resultado")
                guardar_historial "$num1 + $num2 = $resultado_formateado" 
                
                echo
                echo -e "${VERDE}Resultado: $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;

            2)
                num1=$(pedir_numero "Ingrese el primer número: ")
                num2=$(pedir_numero "Ingrese el segundo número: ")

                resultado=$(calcular "$num1 - $num2")

                resultado_formateado=$(formatear_resultado "$resultado")
                guardar_historial "$num1 - $num2 = $resultado_formateado"
                
                echo
                echo -e "${VERDE}Resultado: $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;

            3)
                num1=$(pedir_numero "Ingrese el primer número: ")
                num2=$(pedir_numero "Ingrese el segundo número: ")

                resultado=$(calcular "$num1 * $num2")

                resultado_formateado=$(formatear_resultado "$resultado")
                guardar_historial "$num1 * $num2 = $resultado_formateado"
                
                echo
                echo -e "${VERDE}Resultado: $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;

            4)
                num1=$(pedir_numero "Ingrese el dividendo: ")
                num2=$(pedir_numero "Ingrese el divisor: ")

                if [ "$num2" == "0" ]; then

                    echo
                    echo -e "${ROJO}Error: no se puede dividir entre cero.${RESET}"

                else

                    resultado=$(calcular "$num1 / $num2")

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "$num1 / $num2 = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}Resultado: $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;

            5)
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

# ==========================================
# POTENCIAS Y RAÍCES
# ==========================================

potencias_raices() {

    while true
    do
        clear

        echo -e "${CIAN}==============================================${RESET}"
        echo -e "${CIAN}             POTENCIAS Y RAÍCES               ${RESET}"
        echo -e "${CIAN}==============================================${RESET}"
        echo
        echo "1) Potencia"
        echo "2) Raíz cuadrada"
        echo "3) Raíz cúbica"
        echo "4) Raíz enésima"
        echo "5) Volver al menú principal"
        echo

        read -p "Seleccione una opción: " opcion

        case $opcion in

            1)
                base=$(pedir_numero "Ingrese la base: ")
                exponente=$(pedir_numero "Ingrese el exponente: ")

                resultado=$(calcular "$base ^ $exponente")

                if [ $? -ne 0 ]; then

                    echo
                    echo -e "${ROJO}Error: no se pudo calcular la potencia.${RESET}"

                else

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "$base ^ $exponente = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}$base ^ $exponente = $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            2)
                numero=$(pedir_numero "Ingrese el número: ")

                if (( $(echo "$numero < 0" | bc -l) )); then

                    echo
                    echo -e "${ROJO}Error: no existe una raíz cuadrada real de un número negativo.${RESET}"

                else

                    resultado=$(calcular "sqrt($numero)")

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "√$numero = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}√$numero = $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            3)
                numero=$(pedir_numero "Ingrese el número: ")

                resultado=$(calcular "e(l($numero)/3)")

                if [ $? -ne 0 ]; then

                    echo
                    echo -e "${ROJO}Error: no se pudo calcular la raíz cúbica.${RESET}"

                else

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "∛$numero = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}∛$numero = $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            4)
                numero=$(pedir_numero "Ingrese el número: ")
                indice=$(pedir_numero "Ingrese el índice de la raíz: ")

                if [ "$indice" == "0" ]; then

                    echo
                    echo -e "${ROJO}Error: el índice no puede ser cero.${RESET}"

                elif (( $(echo "$numero < 0 && $indice % 2 == 0" | bc -l) )); then

                    echo
                    echo -e "${ROJO}Error: no existe una raíz par real de un número negativo.${RESET}"

                else

                    resultado=$(calcular "e(l($numero)/$indice)")

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "Raíz $indice de $numero = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}Raíz $indice de $numero = $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            5)
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

# ==========================================
# LOGARITMOS
# ==========================================

logaritmos() {

    while true
    do
        clear

        echo -e "${CIAN}==============================================${RESET}"
        echo -e "${CIAN}                 LOGARITMOS                   ${RESET}"
        echo -e "${CIAN}==============================================${RESET}"
        echo
        echo "1) Logaritmo natural (ln)"
        echo "2) Logaritmo base 10"
        echo "3) Logaritmo en cualquier base"
        echo "4) Volver al menú principal"
        echo

        read -p "Seleccione una opción: " opcion

        case $opcion in

            1)
                numero=$(pedir_numero "Ingrese el número: ")

                if (( $(echo "$numero <= 0" | bc -l) )); then

                    echo
                    echo -e "${ROJO}Error: el logaritmo natural requiere un número mayor que cero.${RESET}"

                else

                    resultado=$(calcular "l($numero)")

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "ln($numero) = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}ln($numero) = $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            2)
                numero=$(pedir_numero "Ingrese el número: ")

                if (( $(echo "$numero <= 0" | bc -l) )); then

                    echo
                    echo -e "${ROJO}Error: el logaritmo requiere un número mayor que cero.${RESET}"

                else

                    resultado=$(calcular "l($numero)/l(10)")

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "log10($numero) = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}log10($numero) = $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            3)
                numero=$(pedir_numero "Ingrese el número: ")
                base=$(pedir_numero "Ingrese la base: ")

                if (( $(echo "$numero <= 0" | bc -l) )); then

                    echo
                    echo -e "${ROJO}Error: el número debe ser mayor que cero.${RESET}"

                elif (( $(echo "$base <= 0" | bc -l) )); then

                    echo
                    echo -e "${ROJO}Error: la base debe ser mayor que cero.${RESET}"

                elif (( $(echo "$base == 1" | bc -l) )); then

                    echo
                    echo -e "${ROJO}Error: la base no puede ser 1.${RESET}"

                else

                    resultado=$(calcular "l($numero)/l($base)")

                    resultado_formateado=$(formatear_resultado "$resultado")
                    guardar_historial "log base $base de $numero = $resultado_formateado"
                    
                    echo
                    echo -e "${VERDE}log base $base de $numero = $resultado_formateado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            4)
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

# ==========================================
# OPERACIONES ESPECIALES
# ==========================================

operaciones_especiales() {

    while true
    do
        clear

        echo -e "${CIAN}==============================================${RESET}"
        echo -e "${CIAN}          OPERACIONES ESPECIALES               ${RESET}"
        echo -e "${CIAN}==============================================${RESET}"
        echo
        echo "1) Factorial"
        echo "2) Porcentaje"
        echo "3) Valor absoluto"
        echo "4) Volver al menú principal"
        echo

        read -p "Seleccione una opción: " opcion

        case $opcion in

            1)
                numero=$(pedir_entero "Ingrese un número entero: ")

                if [ "$numero" -lt 0 ]; then

                    echo
                    echo -e "${ROJO}Error: el factorial no está definido para números negativos.${RESET}"

                else

                    resultado=1

                    for ((i=2; i<=numero; i++))
                    do
                        resultado=$((resultado * i))
                    done
                    guardar_historial "$numero! = $resultado"
                    
                    echo
                    echo -e "${VERDE}$numero! = $resultado${RESET}"

                fi

                read -p "Presione ENTER para continuar..."
                ;;


            2)
                numero=$(pedir_numero "Ingrese el número: ")
                porcentaje=$(pedir_numero "Ingrese el porcentaje: ")

                resultado=$(calcular "$numero * $porcentaje / 100")

                resultado_formateado=$(formatear_resultado "$resultado")
                guardar_historial "$porcentaje% de $numero = $resultado_formateado"
                
                echo
                echo -e "${VERDE}$porcentaje% de $numero = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            3)
                numero=$(pedir_numero "Ingrese el número: ")

                if (( $(echo "$numero < 0" | bc -l) )); then

                    resultado=$(calcular "-($numero)")

                else

                    resultado="$numero"

                fi

                resultado_formateado=$(formatear_resultado "$resultado")
                guardar_historial "|$numero| = $resultado_formateado"
                
                echo
                echo -e "${VERDE}|$numero| = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            4)
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

# ==========================================
# CONSTANTES MATEMÁTICAS
# ==========================================

constantes_matematicas() {

    while true
    do
        clear

        echo -e "${CIAN}==============================================${RESET}"
        echo -e "${CIAN}          CONSTANTES MATEMÁTICAS              ${RESET}"
        echo -e "${CIAN}==============================================${RESET}"
        echo
        echo "1) Pi (π)"
        echo "2) Número de Euler (e)"
        echo "3) Número áureo (φ)"
        echo "4) Raíz de 2"
        echo "5) Raíz de 3"
        echo "6) Raíz de 5"
        echo "7) Volver al menú principal"
        echo

        read -p "Seleccione una opción: " opcion

        case $opcion in

            1)
                resultado=$(calcular "4*a(1)")
                resultado_formateado=$(formatear_resultado "$resultado")
                guardar_historial "π = $resultado_formateado"
                
                echo
                echo -e "${VERDE}π = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            2)
                resultado=$(calcular "e(1)")
                resultado_formateado=$(formatear_resultado "$resultado")
                guardar_historial "e = $resultado_formateado"
                
                echo
                echo -e "${VERDE}e = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            3)
                resultado=$(calcular "(1+sqrt(5))/2")
                resultado_formateado=$(formatear_resultado "$resultado")

                echo
                echo -e "${VERDE}φ = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            4)
                resultado=$(calcular "sqrt(2)")
                resultado_formateado=$(formatear_resultado "$resultado")

                echo
                echo -e "${VERDE}√2 = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            5)
                resultado=$(calcular "sqrt(3)")
                resultado_formateado=$(formatear_resultado "$resultado")

                echo
                echo -e "${VERDE}√3 = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            6)
                resultado=$(calcular "sqrt(5)")
                resultado_formateado=$(formatear_resultado "$resultado")

                echo
                echo -e "${VERDE}√5 = $resultado_formateado${RESET}"

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

# ==========================================
# CONSTANTES MATEMÁTICAS
# ==========================================

constantes_matematicas() {

    while true
    do
        clear

        echo -e "${CIAN}==============================================${RESET}"
        echo -e "${CIAN}          CONSTANTES MATEMÁTICAS              ${RESET}"
        echo -e "${CIAN}==============================================${RESET}"
        echo
        echo "1) Pi (π)"
        echo "2) Número de Euler (e)"
        echo "3) Número áureo (φ)"
        echo "4) Raíz de 2"
        echo "5) Raíz de 3"
        echo "6) Raíz de 5"
        echo "7) Volver al menú principal"
        echo

        read -p "Seleccione una opción: " opcion

        case $opcion in

            1)
                resultado=$(calcular "4*a(1)")
                resultado_formateado=$(formatear_resultado "$resultado")

                echo
                echo -e "${VERDE}π = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            2)
                resultado=$(calcular "e(1)")
                resultado_formateado=$(formatear_resultado "$resultado")

                echo
                echo -e "${VERDE}e = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            3)
                resultado=$(calcular "(1+sqrt(5))/2")
                resultado_formateado=$(formatear_resultado "$resultado")

                echo
                echo -e "${VERDE}φ = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            4)
                resultado=$(calcular "sqrt(2)")
                resultado_formateado=$(formatear_resultado "$resultado")

                echo
                echo -e "${VERDE}√2 = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            5)
                resultado=$(calcular "sqrt(3)")
                resultado_formateado=$(formatear_resultado "$resultado")

                echo
                echo -e "${VERDE}√3 = $resultado_formateado${RESET}"

                read -p "Presione ENTER para continuar..."
                ;;


            6)
                resultado=$(calcular "sqrt(5)")
                resultado_formateado=$(formatear_resultado "$resultado")

                echo
                echo -e "${VERDE}√5 = $resultado_formateado${RESET}"

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

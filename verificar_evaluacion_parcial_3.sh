#!/bin/bash

# ================================
# 🌟 Sección interactiva
# ================================
echo "===== Registro del Estudiante ====="
read -p "👤 Ingrese su nombre completo: " nombre
read -p "📅 Ingrese la fecha de hoy (YYYY-MM-DD): " fecha
read -p "🧝 Ingrese una frase de 5 palabras relacionada con Game of Thrones: " frase

palabras=$(echo "$frase" | wc -w)

if [ "$palabras" -ne 5 ]; then
  echo "❌ La frase debe contener exactamente 5 palabras. Intente nuevamente."
  exit 1
fi

echo ""
echo "📋 Estudiante: $nombre"
echo "🕒 Fecha de ejecución: $fecha (UTC)"
echo "🧙 Frase: \"$frase\""
echo "===================================="
sleep 2

# ================================
# 🔍 Evaluación automática
# ================================
total=0
aprobacion=60

# Parte 1: Estructura y permisos
echo -e "\n1. Verificando estructura y permisos..."
if [ -d "/respaldos" ] && [ -d "/respaldos/documentos" ]; then
  permisos_respaldos=$(stat -c "%a" /respaldos)
  permisos_documentos=$(stat -c "%a" /respaldos/documentos)
  if [ "$permisos_respaldos" == "752" ] && [ "$permisos_documentos" == "760" ]; then
    echo "✅ Estructura y permisos correctos."
    total=$((total + 20))
  else
    echo "❌ Permisos incorrectos."
  fi
else
  echo "❌ Directorios no encontrados."
fi

# Parte 2: Usuario y propiedad
echo -e "\n2. Verificando usuario y propiedad..."
if id "estebanlazo" &>/dev/null; then
  owner=$(stat -c "%U" /respaldos)
  if [ "$owner" == "estebanlazo" ]; then
    echo "✅ Usuario creado y propiedad asignada."
    total=$((total + 20))
  else
    echo "❌ Propiedad no asignada correctamente."
  fi
else
  echo "❌ Usuario estebanlazo no existe."
fi

# Parte 3: Archivo misdatos.txt
echo -e "\n3. Verificando archivo misdatos.txt..."
if [ -f "/respaldos/documentos/misdatos.txt" ]; then
  contenido=$(cat /respaldos/documentos/misdatos.txt)
  if [ -n "$contenido" ]; then
    echo "✅ Archivo misdatos.txt con contenido."
    total=$((total + 20))
  else
    echo "❌ Archivo misdatos.txt vacío."
  fi
else
  echo "❌ Archivo misdatos.txt no existe."
fi

# Parte 4: Cron funcionando (espera 1 minuto)
echo -e "\n4. Verificando cron y mensaje.txt (esperando 65 segundos)..."
sleep 65
if grep -q "Hola, este es un msj automático" /respaldos/documentos/mensaje.txt; then
  echo "✅ Cron ejecutó correctamente el script."
  total=$((total + 20))
else
  echo "❌ Cron no ejecutó el script como se esperaba."
fi

# Parte 5: Script remoto descargado
echo -e "\n5. Verificando script remoto..."
if [ -x "/respaldos/documentos/verificar_evaluacion_parcial_3.sh" ]; then
  echo "✅ Script descargado y tiene permisos de ejecución."
  total=$((total + 20))
else
  echo "❌ Script no encontrado o no ejecutable."
fi

# ================================
# 🎯 Resultado final
# ================================
echo -e "\n===================================="
echo "🧮 Puntaje total obtenido: $total / 100"
if [ "$total" -ge "$aprobacion" ]; then
  echo "🎉 ¡APROBADO! Nota igual o mayor a $aprobacion%."
else
  echo "❌ NO APROBADO. Nota inferior a $aprobacion%."
fi
echo "===================================="

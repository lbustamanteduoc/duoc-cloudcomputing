#!/bin/bash

echo "🧪 Verificación de configuración del laboratorio Linux"
echo "-------------------------------------------------------"

# Paso a) Verificar ubicación del directorio / (implícito, omitido)

# Paso b) y c)
echo -e "\n📁 Verificando existencia y permisos de /respaldos..."
if [ -d /respaldos ]; then
    perms=$(stat -c "%a" /respaldos)
    echo "✓ /respaldos existe - Permisos: $perms"
    [[ "$perms" == "752" ]] || echo "⚠️ Permisos incorrectos en /respaldos (esperado: 752)"
else
    echo "❌ /respaldos no existe"
fi

# Paso d) y e)
echo -e "\n📁 Verificando /respaldos/documentos..."
if [ -d /respaldos/documentos ]; then
    perms=$(stat -c "%a" /respaldos/documentos)
    echo "✓ /respaldos/documentos existe - Permisos: $perms"
    [[ "$perms" == "760" ]] || echo "⚠️ Permisos incorrectos en /respaldos/documentos (esperado: 760)"
else
    echo "❌ /respaldos/documentos no existe"
fi

# Paso f)
echo -e "\n🔎 Listado de directorios:"
ls -ld /respaldos /respaldos/documentos

# Paso g)
echo -e "\n🌲 Mostrando estructura de directorios con tree:"
if command -v tree >/dev/null 2>&1; then
    tree /respaldos
else
    echo "⚠️ El comando 'tree' no está instalado. Ejecuta: sudo yum install tree"
fi

# Paso h)
echo -e "\n👤 Verificando existencia del usuario Informatica..."
if id Informatica >/dev/null 2>&1; then
    echo "✓ Usuario Informatica existe"
else
    echo "❌ Usuario Informatica no existe"
fi

# Paso i)
echo -e "\n📂 Verificando propietario de /respaldos..."
owner=$(stat -c "%U" /respaldos)
echo "✓ Propietario de /respaldos: $owner"
[[ "$owner" == "Informatica" ]] || echo "⚠️ El propietario debería ser Informatica"

# Paso j, k, l)
echo -e "\n📄 Verificando archivos misdatos.txt y mensaje.txt..."
if [ -f /respaldos/documentos/misdatos.txt ]; then
    echo "✓ misdatos.txt encontrado. Contenido:"
    cat /respaldos/documentos/misdatos.txt
else
    echo "❌ misdatos.txt no encontrado"
fi

if [ -f /respaldos/documentos/mensaje.txt ]; then
    echo "✓ mensaje.txt encontrado. Contenido:"
    cat /respaldos/documentos/mensaje.txt
else
    echo "❌ mensaje.txt no encontrado"
fi

# Paso m)
echo -e "\n📦 Verificando instalación de cronie..."
if rpm -q cronie >/dev/null 2>&1; then
    echo "✓ cronie está instalado"
else
    echo "❌ cronie no está instalado"
fi

# Paso n)
echo -e "\n🔄 Verificando estado del servicio crond..."
if systemctl is-active --quiet crond; then
    echo "✓ crond está activo"
else
    echo "❌ crond no está activo"
fi

# Paso o) Verificar crontab contiene escribir_msg.sh
echo -e "\n📅 Verificando si la tarea de cron está registrada..."
if crontab -l | grep -q escribir_msg.sh; then
    echo "✓ Tarea programada con escribir_msg.sh encontrada en crontab"
else
    echo "❌ No se encontró escribir_msg.sh en el crontab del usuario actual"
fi

echo -e "\n✅ Verificación completada"

#!/bin/bash

echo "🔍 Verificando entorno de laboratorio..."

# Verificar directorio
echo -n "1. Directorio /home/duoclinux existe: "
[ -d /home/duoclinux ] && echo "✅" || echo "❌"

# Verificar archivo test.txt
echo -n "2. Archivo test.txt existe: "
[ -f /home/duoclinux/test.txt ] && echo "✅" || echo "❌"

# Verificar permisos de test.txt
echo -n "3. test.txt tiene permisos 600: "
perm=$(stat -c "%a" /home/duoclinux/test.txt 2>/dev/null)
[ "$perm" == "600" ] && echo "✅" || echo "❌ ($perm)"

# Verificar propietario de test.txt
echo -n "4. test.txt pertenece a pepito: "
owner=$(stat -c "%U" /home/duoclinux/test.txt 2>/dev/null)
[ "$owner" == "pepito" ] && echo "✅" || echo "❌ ($owner)"

# Verificar usuarios
for user in pepito juanito pedrito; do
  echo -n "5. Usuario $user existe: "
  id "$user" &>/dev/null && echo "✅" || echo "❌"
done

# Verificar grupos
for group in duocgrupo duocsb; do
  echo -n "6. Grupo $group existe: "
  getent group "$group" &>/dev/null && echo "✅" || echo "❌"
done

# Verificar pertenencia a grupos
echo -n "7. pepito en grupo duocgrupo: "
id pepito | grep -q duocgrupo && echo "✅" || echo "❌"

echo -n "8. juanito en grupo duocgrupo: "
id juanito | grep -q duocgrupo && echo "✅" || echo "❌"

echo -n "9. pedrito en grupo duocsb: "
id pedrito | grep -q duocsb && echo "✅" || echo "❌"

echo -n "10. juanito con grupo principal duocsb: "
[ "$(id -gn juanito)" == "duocsb" ] && echo "✅" || echo "❌"

# Verificar archivo creado por juanito
echo -n "11. Archivo text2.txt creado: "
[ -f /home/juanito/text2.txt ] && echo "✅" || echo "❌"

echo "✅ Verificación finalizada."

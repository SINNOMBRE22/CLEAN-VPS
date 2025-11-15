# 🔥 LIMPIADOR VPS PRO v2.0

**Script profesional de limpieza para servidores VPS - Escrito en Bash**

![Bash](https://img.shields.io/badge/Language-Bash-4EAA25?style=for-the-badge&logo=gnu-bash)
![Version](https://img.shields.io/badge/Version-2.0-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

---

## 📋 Descripción

**CLEAN-VPS** es un script profesional de limpieza para servidores virtuales privados (VPS). Permite eliminar archivos basura, caché, registros antiguos y optimizar el almacenamiento sin afectar datos importantes.

Incluye **12 opciones de limpieza diferentes** con interfaz interactiva, colores vibrantes y estadísticas en tiempo real del sistema.

---

## ✨ Características Principales

### 🧹 12 Opciones de Limpieza

1. **Limpiar caché de APT** - Elimina archivos .deb descargados
2. **Eliminar registros antiguos** - Borra logs mayores a 30 días
3. **Limpiar archivos temporales** - Limpia /tmp y /var/tmp
4. **Limpiar papelera de usuarios** - Vacía papeleras de usuarios
5. **Limpiar caché Python y pip** - Elimina __pycache__ y caché pip
6. **Optimizar diarios del sistema** - Optimiza journalctl
7. **Eliminar paquetes no utilizados** - Limpia paquetes huérfanos
8. **Limpiar caché DNS** - Reinicia systemd-resolved
9. **Analizar archivos grandes** - Busca archivos >100MB
10. **Buscar archivos duplicados** - Detecta duplicados con md5sum
11. **Limpiar sesiones SSH** - Limpia caché SSH
12. **LIMPIEZA COMPLETA** - Ejecuta todas las opciones

### 🎨 Interfaz Profesional

- ✅ Banner ASCII art personalizado
- ✅ Colores épicos (Magenta, Cyan, Azul Oscuro, Lima, Naranja)
- ✅ Información del sistema en tiempo real
- ✅ Estadísticas de almacenamiento (RAM, SWAP, Disco)
- ✅ Menú interactivo fácil de usar
- ✅ Separadores decorativos profesionales

### 🔒 Seguridad

- ✅ Modo vista previa (sin cambios reales)
- ✅ Confirmación antes de limpieza completa
- ✅ Sin eliminación de datos del usuario
- ✅ Protección contra eliminación accidental
- ✅ Respeta permisos de archivos

### 📊 Funcionalidad Real

- ✅ Calcula espacio realmente liberado
- ✅ Busca archivos reales >100MB
- ✅ Detecta archivos duplicados
- ✅ Muestra resultados precisos
- ✅ Estadísticas exactas de limpieza

---

## 🚀 Instalación Rápida

### Requisitos

- **Linux/Debian/Ubuntu**
- **Permisos de root (sudo)**
- **Bash 4.0+**

### Pasos de Instalación

1. **Clonar el repositorio:**
```bash
git clone https://github.com/SINNOMBRE22/CLEAN-VPS.git
cd CLEAN-VPS
```

2. **Dar permisos de ejecución:**
```bash
chmod +x limpieza.sh
```

3. **Ejecutar el script:**
```bash
sudo ./limpieza.sh
```

---

## 📖 Guía de Uso

### Menú Principal

Al ejecutar el script verás el menú interactivo:

```
   ___  _________ __      ________  _____   ________  ________
  / _ \/ ___/ __ \/ |     / / ____/ / ___/  / ____/ / / / ____/
 / / / \__ \/ /_/ / | /| / / __/   \__ \   / /   / / / / __/   
/ /_/ ___/ ___/ / _, _/ / /___  ___/ /  / /___/ /_/ / /___   
\____//____/_/ |_|_|__/|_/_____/  /____/   \____/\____/_____/   

        ⚡ Script Profesional de Limpieza VPS ⚡

╭────────────────────────────────────────────────────────────
│ 🧹 OPCIONES DE LIMPIEZA
├────────────────────────────────────────────────────────────
│ [1]  Limpiar caché de APT
│ [2]  Eliminar registros antiguos
│ [3]  Limpiar archivos temporales
│ [4]  Limpiar papelera de usuarios
│ [5]  Limpiar caché Python y pip
│ [6]  Optimizar diarios del sistema
│ [7]  Eliminar paquetes no utilizados
│ [8]  Limpiar caché DNS
│ [9]  Analizar archivos grandes
│ [10] Buscar archivos duplicados
│ [11] Limpiar sesiones SSH
│ [12] ⚡ LIMPIEZA COMPLETA
│ [0]  ❌ Salir del script
╰────────────────────────────────────────────────────────────

Selecciona una opcion [0-12]:
```

### Ejemplos de Uso

#### Limpiar caché de APT
```bash
sudo ./limpieza.sh
# Selecciona: 1
# Resultado: Caché APT analizado - Vista previa
```

#### Analizar archivos grandes
```bash
sudo ./limpieza.sh
# Selecciona: 9
# Resultado: Muestra top 10 archivos >100MB
```

#### Limpieza Completa
```bash
sudo ./limpieza.sh
# Selecciona: 12
# Confirma: s
# Resultado: Ejecuta TODAS las limpiezas reales
```

#### Salir del script
```bash
# Selecciona: 0
# O presiona: Ctrl+C
```

---

## 📊 Información Mostrada

El script muestra en tiempo real:

```
📊 INFORMACIÓN DEL SISTEMA
├────────────────────────────────────────
│ 👤 Usuario: root
│ 🖥️  Servidor: ubuntu-vps-01
│ ⏱️  Uptime: 45 días 12 horas
│ 📅 Fecha/Hora: 2025-11-15 07:30:30 UTC
│ 🔧 Kernel: 5.15.0-84-generic

💾 ESTADO DE ALMACENAMIENTO
├────────────────────────────────────────
│ 📍 Partición Raíz (/):
│    Total: 100GB | Usado: 45GB | Disponible: 55GB | Uso: 45%
│ 🔄 SWAP:
│    Total: 2GB | Usado: 128MB | Libre: 1.8GB
│ 💿 RAM:
│    Total: 16GB | Usado: 8GB | Libre: 8GB | Disponible: 10GB
```

---

## 🛠️ Estructura del Proyecto

```
CLEAN-VPS/
├── limpieza.sh          # Script principal (Bash)
├── README.md            # Documentación
├── LICENSE              # Licencia MIT
└── .gitignore          # Archivos ignorados
```

---

## 🎯 Casos de Uso

### 1. Optimizar VPS nuevo
```bash
sudo ./limpieza.sh
# Ejecuta opción 12 para limpieza completa
```

### 2. Liberar espacio rápidamente
```bash
sudo ./limpieza.sh
# Opción 1: Caché APT
# Opción 2: Logs antiguos
# Opción 3: Archivos temporales
```

### 3. Encontrar archivos grandes
```bash
sudo ./limpieza.sh
# Selecciona opción 9
# Ver archivos mayores a 100MB
```

### 4. Detectar duplicados
```bash
sudo ./limpieza.sh
# Selecciona opción 10
# Buscar archivos duplicados en /home
```

---

## 📈 Resultados Típicos

### Después de Limpieza Completa:

```
✅ Operaciones realizadas: 11
✅ Espacio liberado: 1.5GB

Desglose:
- APT cache: 250MB
- Logs antiguos: 500MB
- Temp files: 150MB
- Python cache: 75MB
- Journals: 100MB
- Otros: 175MB
```

---

## 🔒 Seguridad y Consideraciones

### ¿Es seguro?
✅ **Completamente seguro**. Las opciones 1-11 muestran vista previa sin cambios reales.

### ¿Qué se elimina?
- ✅ Caché (APT, pip, DNS)
- ✅ Logs antiguos (>30 días)
- ✅ Archivos temporales
- ✅ Papeleras vacías
- ✅ Paquetes huérfanos

### ¿Qué NO se elimina?
- ❌ Bases de datos del usuario
- ❌ Proyectos o código fuente
- ❌ Archivos importantes del sistema
- ❌ Datos de aplicaciones activas

---

## ❓ Preguntas Frecuentes

### ¿Necesito permisos de root?
Sí, el script requiere `sudo` para ejecutar comandos de limpieza del sistema.

### ¿Puedo ejecutar esto en producción?
Sí, es seguro. Recomendamos hacer una copia de seguridad primero.

### ¿Cuánto tiempo toma?
Entre 2-5 minutos dependiendo del tamaño de tu VPS.

### ¿Qué distros soporta?
- ✅ Ubuntu (18.04+)
- ✅ Debian (9+)
- ✅ Linux Mint
- ✅ Otras distros basadas en Debian

### ¿Usa Python?
No, es **100% Bash puro**. Sin dependencias externas.

---

## 🐛 Solución de Problemas

### Error: "Este script requiere permisos de root"
```bash
sudo ./limpieza.sh
```

### El script no tiene permisos
```bash
chmod +x limpieza.sh
```

### No se ven los colores
Tu terminal no soporta ANSI 256 colors. Prueba con otra terminal.

### El script no ejecuta
Verifica que tengas bash instalado:
```bash
which bash
```

---

## 📞 Contacto y Soporte

**Creador:** SINNOMBRE22  
**Contacto:** 5215629885039  
**GitHub:** [@SINNOMBRE22](https://github.com/SINNOMBRE22)

Para reportar bugs o sugerir mejoras, abre un [issue](https://github.com/SINNOMBRE22/CLEAN-VPS/issues).

---

## 📄 Licencia

Este proyecto está bajo la licencia **MIT**. 

```
MIT License

Copyright (c) 2025 SINNOMBRE22

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 🌟 Reconocimientos

Gracias a todos los usuarios que usan este script. ¡Tus comentarios nos ayudan a mejorar!

---

**Hecho con ❤️ por SINNOMBRE22**

⭐ Si te gusta el proyecto, ¡dame una estrella en GitHub!

🔗 [GitHub Repository](https://github.com/SINNOMBRE22/CLEAN-VPS)

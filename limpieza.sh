#!/bin/bash

################################################################################
#                          🔥 LIMPIADOR VPS PRO v2.0 🔥                       #
#                                                                              #
# Script profesional para limpiar VPS de forma segura y potente               #
# Autor: SINNOMBRE22                                                          #
# Fecha: 2025-11-15 07:11:50                                                  #
# Descripción: Herramienta avanzada de limpieza con estadísticas              #
################################################################################

# ============================================================================
# 🎨 COLORES Y ESTILOS
# ============================================================================
BOLD='\033[1m'
UNDERLINE='\033[4m'

# Colores vibrantes
DARK_BLUE='\033[38;5;17m'
MAGENTA='\033[38;5;201m'
CYAN='\033[38;5;51m'
LIME='\033[38;5;46m'
ORANGE='\033[38;5;208m'
RED='\033[38;5;196m'
PURPLE='\033[38;5;135m'
PINK='\033[38;5;219m'
YELLOW='\033[38;5;226m'

NC='\033[0m' # Reset

# ============================================================================
# 📊 VARIABLES GLOBALES
# ============================================================================
TOTAL_FREED=0
TOTAL_ITEMS=0
DRY_RUN=true
TIMESTAMP=$(date '+%Y-%m-%d_%H:%M:%S')
LOG_FILE="/tmp/limpiador_vps_${TIMESTAMP}.log"

# ============================================================================
# 🛠️ FUNCIONES AUXILIARES
# ============================================================================

# Convertir bytes a formato legible
humanize() {
    local bytes=$1
    if [ -z "$bytes" ] || [ "$bytes" -eq 0 ]; then
        echo "0B"
        return
    fi
    
    if [ "$bytes" -lt 1024 ]; then
        echo "${bytes}B"
    elif [ "$bytes" -lt $((1024*1024)) ]; then
        echo "$((bytes / 1024))KB"
    elif [ "$bytes" -lt $((1024*1024*1024)) ]; then
        echo "$((bytes / 1024 / 1024))MB"
    else
        echo "$((bytes / 1024 / 1024 / 1024))GB"
    fi
}

# Función de logging
log() {
    local message="$1"
    echo -e "$message"
}

# Línea decorativa
separator() {
    echo -e "${DARK_BLUE}╭────────────────────────────────────────────────────────────${NC}"
}

sub_separator() {
    echo -e "${DARK_BLUE}├────────────────────────────────────────────────────────────${NC}"
}

end_separator() {
    echo -e "${DARK_BLUE}╰────────────────────────────────────────────────────────────${NC}"
}

# Banner épico y profesional
show_banner() {
    clear
    echo ""
    echo -e "${MAGENTA}${BOLD}"
    cat << "EOF"
   ___  _________ __      ________  _____   ________  ________
  / _ \/ ___/ __ \/ |     / / ____/ / ___/  / ____/ / / / ____/
 / / / \__ \/ /_/ / | /| / / __/   \__ \   / /   / / / / __/   
/ /_/ ___/ ___/ / _, _/ / /___  ___/ /  / /___/ /_/ / /___   
\____//____/_/ |_|_|__/|_/_____/  /____/   \____/\____/_____/   
EOF
    echo -e "${NC}${CYAN}${BOLD}"
    cat << "EOF"
        ⚡ Script Profesional de Limpieza VPS ⚡
EOF
    echo -e "${NC}"
    
    # Línea separadora
    echo -e "${MAGENTA}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    # Información principal
    echo -e "${PURPLE}${BOLD}  👤 Usuario:${NC}  ${CYAN}$(whoami)${NC} ${PURPLE}${BOLD}│${NC}  ${PURPLE}${BOLD}🖥️  Servidor:${NC}  ${CYAN}$(hostname)${NC}"
    echo -e "${PURPLE}${BOLD}  📅 Fecha:${NC}  ${CYAN}$(date '+%Y-%m-%d')${NC} ${PURPLE}${BOLD}│${NC}  ${PURPLE}${BOLD}🕐 Hora:${NC}  ${CYAN}$(date '+%H:%M:%S')${NC} UTC"
    
    # Línea separadora
    echo -e "${MAGENTA}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    # Creador y contacto
    echo -e "${LIME}${BOLD}  Creador:${NC}  ${YELLOW}SINNOMBRE22${NC} ${LIME}${BOLD}│${NC}  ${LIME}${BOLD}📞 Contacto:${NC}  ${YELLOW}5215629885039${NC}"
    
    # Línea separadora
    echo -e "${MAGENTA}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# Mostrar información del sistema
show_system_info() {
    separator
    log "${CYAN}${BOLD}📊 INFORMACIÓN DEL SISTEMA${NC}"
    sub_separator
    
    log "${LIME}👤 Usuario:${NC} $(whoami)"
    log "${LIME}🖥️  Servidor:${NC} $(hostname)"
    log "${LIME}⏱️  Uptime:${NC} $(uptime -p 2>/dev/null || echo 'N/A')"
    log "${LIME}📅 Fecha/Hora:${NC} $(date '+%Y-%m-%d %H:%M:%S UTC')"
    log "${LIME}🔧 Kernel:${NC} $(uname -r)"
    
    sub_separator
}

# Mostrar espacio en disco
show_disk_info() {
    separator
    log "${CYAN}${BOLD}💾 ESTADO DE ALMACENAMIENTO${NC}"
    sub_separator
    
    # Información de disco raíz
    local disk_info
    disk_info=$(df -h / 2>/dev/null | tail -1)
    local total
    total=$(echo "$disk_info" | awk '{print $2}')
    local used
    used=$(echo "$disk_info" | awk '{print $3}')
    local available
    available=$(echo "$disk_info" | awk '{print $4}')
    local percent
    percent=$(echo "$disk_info" | awk '{print $5}')
    
    log "${LIME}📍 Partición Raíz (/):${NC}"
    log "   Total: ${ORANGE}${BOLD}$total${NC} | Usado: ${RED}${BOLD}$used${NC} | Disponible: ${LIME}${BOLD}$available${NC} | Uso: ${PURPLE}${BOLD}$percent${NC}"
    
    # Información de SWAP
    local swap_total
    local swap_used
    local swap_free
    swap_total=$(free -h 2>/dev/null | grep Swap | awk '{print $2}')
    swap_used=$(free -h 2>/dev/null | grep Swap | awk '{print $3}')
    swap_free=$(free -h 2>/dev/null | grep Swap | awk '{print $4}')
    
    log "${LIME}🔄 SWAP:${NC}"
    log "   Total: ${ORANGE}${BOLD}$swap_total${NC} | Usado: ${RED}${BOLD}$swap_used${NC} | Libre: ${LIME}${BOLD}$swap_free${NC}"
    
    # Información de RAM
    local ram_info
    ram_info=$(free -h 2>/dev/null | grep Mem)
    local ram_total
    local ram_used
    local ram_free
    local ram_available
    ram_total=$(echo "$ram_info" | awk '{print $2}')
    ram_used=$(echo "$ram_info" | awk '{print $3}')
    ram_free=$(echo "$ram_info" | awk '{print $4}')
    ram_available=$(echo "$ram_info" | awk '{print $7}')
    
    log "${LIME}💿 RAM:${NC}"
    log "   Total: ${ORANGE}${BOLD}$ram_total${NC} | Usado: ${RED}${BOLD}$ram_used${NC} | Libre: ${LIME}${BOLD}$ram_free${NC} | Disponible: ${PURPLE}${BOLD}$ram_available${NC}"
    
    sub_separator
}

# Mostrar menú principal
show_menu() {
    separator
    log "${CYAN}${BOLD}🧹 OPCIONES DE LIMPIEZA${NC}"
    sub_separator
    log "${MAGENTA}${BOLD}[1]${NC}  Limpiar caché de APT"
    log "${MAGENTA}${BOLD}[2]${NC}  Eliminar registros antiguos"
    log "${MAGENTA}${BOLD}[3]${NC}  Limpiar archivos temporales"
    log "${MAGENTA}${BOLD}[4]${NC}  Limpiar papelera de usuarios"
    log "${MAGENTA}${BOLD}[5]${NC}  Limpiar caché Python y pip"
    log "${MAGENTA}${BOLD}[6]${NC}  Optimizar diarios del sistema"
    log "${MAGENTA}${BOLD}[7]${NC}  Eliminar paquetes no utilizados"
    log "${MAGENTA}${BOLD}[8]${NC}  Limpiar caché DNS"
    log "${MAGENTA}${BOLD}[9]${NC}  Analizar archivos grandes"
    log "${MAGENTA}${BOLD}[10]${NC} Buscar archivos duplicados"
    log "${MAGENTA}${BOLD}[11]${NC} Limpiar sesiones SSH"
    log "${MAGENTA}${BOLD}[12]${NC} LIMPIEZA COMPLETA"
    log "${MAGENTA}${BOLD}[0]${NC}  Salir del script"
    sub_separator
}

# Pausa y regresa al menú
pause_and_return_menu() {
    echo ""
    read -p "$(echo -e ${PURPLE}${BOLD}Presiona ENTER para regresar al menú principal...${NC})"
}

# ============================================================================
# 🔧 FUNCIONES DE LIMPIEZA REALES
# ============================================================================

# 1. Limpiar caché APT
clean_apt_cache() {
    separator
    log "${CYAN}${BOLD}1️⃣  LIMPIEZA DE CACHÉ APT${NC}"
    sub_separator
    
    if [ -d "/var/cache/apt/archives/" ]; then
        local before
        before=$(du -sb /var/cache/apt/archives/ 2>/dev/null | cut -f1 || echo 0)
        
        log "${YELLOW}📦 Analizando caché de APT...${NC}"
        sleep 1
        
        if [ "$DRY_RUN" = false ]; then
            log "${CYAN}⚙️  Limpiando caché APT...${NC}"
            sudo apt-get clean 2>/dev/null
            sudo apt-get autoclean 2>/dev/null
        fi
        
        local after
        after=$(du -sb /var/cache/apt/archives/ 2>/dev/null | cut -f1 || echo 0)
        local freed=$((before - after))
        
        if [ "$freed" -gt 0 ]; then
            log "${LIME}✓ ÉXITO: Se limpió $(humanize "$freed") de caché APT${NC}"
            TOTAL_FREED=$((TOTAL_FREED + freed))
        else
            log "${LIME}✓ Caché APT: Sin cambios o ya estaba limpio${NC}"
        fi
        
        ((TOTAL_ITEMS++))
    fi
    
    sub_separator
}

# 2. Eliminar logs antiguos
clean_old_logs() {
    separator
    log "${CYAN}${BOLD}2️⃣  ELIMINACIÓN DE REGISTROS ANTIGUOS${NC}"
    sub_separator
    
    log "${YELLOW}📋 Buscando registros mayores a 30 días...${NC}"
    
    local count
    count=$(find /var/log -type f -mtime +30 2>/dev/null | wc -l)
    
    if [ "$count" -gt 0 ]; then
        local freed
        freed=$(find /var/log -type f -mtime +30 -exec du -sb {} \; 2>/dev/null | awk '{sum+=$1} END {print sum}' || echo 0)
        
        log "${CYAN}Encontrados: $count registros antiguos${NC}"
        
        if [ "$DRY_RUN" = false ]; then
            log "${CYAN}⚙️  Eliminando registros antiguos...${NC}"
            sudo find /var/log -type f -mtime +30 -delete 2>/dev/null
        fi
        
        log "${LIME}✓ ÉXITO: Se liberó $(humanize "$freed")${NC}"
        TOTAL_FREED=$((TOTAL_FREED + freed))
        ((TOTAL_ITEMS++))
    else
        log "${PURPLE}No hay registros antiguos${NC}"
    fi
    
    sub_separator
}

# 3. Limpiar /tmp
clean_temp_files() {
    separator
    log "${CYAN}${BOLD}3️⃣  LIMPIEZA DE ARCHIVOS TEMPORALES${NC}"
    sub_separator
    
    local total_freed=0
    local total_count=0
    
    for tmpdir in /tmp /var/tmp; do
        if [ -d "$tmpdir" ]; then
            log "${YELLOW}📦 Analizando $tmpdir...${NC}"
            
            local count
            count=$(find "$tmpdir" -type f -atime +7 2>/dev/null | wc -l)
            
            if [ "$count" -gt 0 ]; then
                local freed
                freed=$(find "$tmpdir" -type f -atime +7 -exec du -sb {} \; 2>/dev/null | awk '{sum+=$1} END {print sum}' || echo 0)
                
                if [ "$DRY_RUN" = false ]; then
                    sudo find "$tmpdir" -type f -atime +7 -delete 2>/dev/null
                fi
                
                log "${LIME}✓ $tmpdir: $(humanize "$freed") ($count archivos)${NC}"
                total_freed=$((total_freed + freed))
                total_count=$((total_count + count))
            fi
        fi
    done
    
    if [ "$total_count" -gt 0 ]; then
        log "${LIME}TOTAL: $(humanize "$total_freed") liberados${NC}"
        TOTAL_FREED=$((TOTAL_FREED + total_freed))
        ((TOTAL_ITEMS++))
    else
        log "${PURPLE}No hay archivos temporales${NC}"
    fi
    
    sub_separator
}

# 4. Limpiar papelera
clean_trash() {
    separator
    log "${CYAN}${BOLD}4️⃣  LIMPIEZA DE PAPELERA DE USUARIOS${NC}"
    sub_separator
    
    local total_freed=0
    local user_count=0
    
    for user_home in /home/*/; do
        if [ -d "$user_home.local/share/Trash" ]; then
            local freed
            freed=$(du -sb "$user_home.local/share/Trash" 2>/dev/null | cut -f1 || echo 0)
            
            if [ "$freed" -gt 0 ]; then
                local username
                username=$(basename "$user_home")
                
                if [ "$DRY_RUN" = false ]; then
                    rm -rf "$user_home.local/share/Trash"/* 2>/dev/null
                fi
                
                log "${LIME}✓ Usuario '$username': $(humanize "$freed")${NC}"
                total_freed=$((total_freed + freed))
                ((user_count++))
            fi
        fi
    done
    
    if [ "$user_count" -gt 0 ]; then
        log "${LIME}TOTAL: $(humanize "$total_freed") de $user_count usuario${NC}"
        TOTAL_FREED=$((TOTAL_FREED + total_freed))
        ((TOTAL_ITEMS++))
    else
        log "${PURPLE}No hay papeleras para limpiar${NC}"
    fi
    
    sub_separator
}

# 5. Limpiar caché Python
clean_python_cache() {
    separator
    log "${CYAN}${BOLD}5️⃣  LIMPIEZA DE CACHÉ PYTHON Y PIP${NC}"
    sub_separator
    
    local total_freed=0
    
    if [ -d "/root/.cache/pip" ]; then
        log "${YELLOW}📦 Analizando caché pip...${NC}"
        local freed
        freed=$(du -sb /root/.cache/pip 2>/dev/null | cut -f1 || echo 0)
        
        if [ "$freed" -gt 0 ]; then
            if [ "$DRY_RUN" = false ]; then
                rm -rf /root/.cache/pip/* 2>/dev/null
            fi
            log "${LIME}✓ Caché pip: $(humanize "$freed")${NC}"
            total_freed=$((total_freed + freed))
        fi
    fi
    
    log "${YELLOW}📦 Buscando __pycache__...${NC}"
    local pycache_count
    pycache_count=$(find / -type d -name '__pycache__' 2>/dev/null | wc -l)
    
    if [ "$pycache_count" -gt 0 ]; then
        local freed
        freed=$(find / -type d -name '__pycache__' -exec du -sb {} \; 2>/dev/null | awk '{sum+=$1} END {print sum}' || echo 0)
        
        if [ "$DRY_RUN" = false ]; then
            find / -type d -name '__pycache__' -exec rm -rf {} \; 2>/dev/null
        fi
        
        log "${LIME}✓ __pycache__: $(humanize "$freed") ($pycache_count dirs)${NC}"
        total_freed=$((total_freed + freed))
    fi
    
    if [ "$total_freed" -gt 0 ]; then
        log "${LIME}TOTAL: $(humanize "$total_freed") liberados${NC}"
        TOTAL_FREED=$((TOTAL_FREED + total_freed))
        ((TOTAL_ITEMS++))
    else
        log "${PURPLE}No hay caché Python${NC}"
    fi
    
    sub_separator
}

# 6. Optimizar journals
clean_journalctl() {
    separator
    log "${CYAN}${BOLD}6️⃣  OPTIMIZACIÓN DE DIARIOS DEL SISTEMA${NC}"
    sub_separator
    
    if command -v journalctl &> /dev/null; then
        log "${YELLOW}📋 Analizando journals...${NC}"
        
        if [ "$DRY_RUN" = false ]; then
            sudo journalctl --vacuum=30d 2>/dev/null || true
            sudo journalctl --vacuum-size=100M 2>/dev/null || true
        fi
        
        log "${LIME}✓ ÉXITO: Journals optimizados${NC}"
        ((TOTAL_ITEMS++))
    else
        log "${RED}✗ journalctl no disponible${NC}"
    fi
    
    sub_separator
}

# 7. Eliminar paquetes no utilizados
clean_unused_packages() {
    separator
    log "${CYAN}${BOLD}7️⃣  ELIMINACIÓN DE PAQUETES NO UTILIZADOS${NC}"
    sub_separator
    
    if command -v apt-get &> /dev/null; then
        log "${YELLOW}📦 Analizando paquetes...${NC}"
        
        if [ "$DRY_RUN" = false ]; then
            sudo apt-get autoremove -y 2>/dev/null || true
            sudo apt-get autoreclean -y 2>/dev/null || true
        fi
        
        log "${LIME}✓ ÉXITO: Paquetes procesados${NC}"
        ((TOTAL_ITEMS++))
    else
        log "${RED}✗ apt-get no disponible${NC}"
    fi
    
    sub_separator
}

# 8. Limpiar caché DNS
clean_dns_cache() {
    separator
    log "${CYAN}${BOLD}8️⃣  LIMPIEZA DE CACHÉ DNS${NC}"
    sub_separator
    
    if command -v systemctl &> /dev/null; then
        log "${YELLOW}🔍 Reiniciando DNS...${NC}"
        
        if [ "$DRY_RUN" = false ]; then
            sudo systemctl restart systemd-resolved 2>/dev/null || true
        fi
        
        log "${LIME}✓ ÉXITO: Caché DNS limpiado${NC}"
        ((TOTAL_ITEMS++))
    else
        log "${RED}✗ systemctl no disponible${NC}"
    fi
    
    sub_separator
}

# 9. Analizar archivos grandes
analyze_large_files() {
    separator
    log "${CYAN}${BOLD}9️⃣  ANÁLISIS DE ARCHIVOS GRANDES${NC}"
    sub_separator
    
    log "${YELLOW}🔍 Buscando archivos mayores a 100MB...${NC}"
    log "${CYAN}Top 10 archivos mas grandes:${NC}"
    
    local count=0
    find / -type f -size +100M 2>/dev/null | head -10 | while read file; do
        if [ -n "$file" ]; then
            size=$(du -sh "$file" 2>/dev/null | cut -f1)
            log "   ${ORANGE}$size${NC} - ${PINK}$file${NC}"
            count=$((count + 1))
        fi
    done
    
    ((TOTAL_ITEMS++))
    
    sub_separator
}

# 10. Buscar archivos duplicados
find_duplicates() {
    separator
    log "${CYAN}${BOLD}🔟 BÚSQUEDA DE ARCHIVOS DUPLICADOS${NC}"
    sub_separator
    
    log "${YELLOW}🔍 Buscando duplicados en /home...${NC}"
    
    local duplicates
    duplicates=$(find /home -type f 2>/dev/null -exec md5sum {} \; 2>/dev/null | awk '{print $1}' | sort | uniq -d | wc -l)
    
    if [ "$duplicates" -gt 0 ]; then
        log "${LIME}✓ ENCONTRADOS: $duplicates grupo de duplicados${NC}"
        ((TOTAL_ITEMS++))
    else
        log "${PURPLE}No hay duplicados encontrados${NC}"
    fi
    
    sub_separator
}

# 11. Limpiar sesiones SSH
clean_ssh_sessions() {
    separator
    log "${CYAN}${BOLD}1️⃣1️⃣  LIMPIEZA DE SESIONES SSH${NC}"
    sub_separator
    
    if [ -d "$HOME/.ssh" ]; then
        log "${YELLOW}🔐 Limpiando directorios SSH...${NC}"
        
        if [ "$DRY_RUN" = false ]; then
            rm -f "$HOME/.ssh/config.backup" 2>/dev/null
            rm -f "$HOME/.ssh"/*.tmp 2>/dev/null
        fi
        
        log "${LIME}✓ ÉXITO: Sesiones SSH limpiadas${NC}"
        ((TOTAL_ITEMS++))
    else
        log "${RED}✗ Directorio SSH no encontrado${NC}"
    fi
    
    sub_separator
}

# ============================================================================
# 📋 RESUMEN
# ============================================================================

show_summary() {
    separator
    log "${CYAN}${BOLD}📊 RESUMEN DE LIMPIEZA${NC}"
    sub_separator
    
    log "${LIME}✅ Operaciones realizadas: ${ORANGE}${BOLD}$TOTAL_ITEMS${NC}"
    log "${LIME}✅ Espacio liberado: ${ORANGE}${BOLD}$(humanize "$TOTAL_FREED")${NC}"
    
    if [ "$DRY_RUN" = true ]; then
        log "${PURPLE}⚠️  MODO VISTA PREVIA${NC}"
    else
        log "${LIME}✅ LIMPIEZA COMPLETADA${NC}"
    fi
    
    end_separator
}

# ============================================================================
# 🎮 MENÚ INTERACTIVO
# ============================================================================

run_interactive() {
    while true; do
        show_banner
        show_system_info
        show_disk_info
        show_menu
        
        read -p "$(echo -e ${MAGENTA}${BOLD}Selecciona una opcion [0-12]: ${NC})" option
        
        case "$option" in
            1)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                clean_apt_cache
                show_summary
                pause_and_return_menu
                ;;
            2)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                clean_old_logs
                show_summary
                pause_and_return_menu
                ;;
            3)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                clean_temp_files
                show_summary
                pause_and_return_menu
                ;;
            4)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                clean_trash
                show_summary
                pause_and_return_menu
                ;;
            5)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                clean_python_cache
                show_summary
                pause_and_return_menu
                ;;
            6)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                clean_journalctl
                show_summary
                pause_and_return_menu
                ;;
            7)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                clean_unused_packages
                show_summary
                pause_and_return_menu
                ;;
            8)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                clean_dns_cache
                show_summary
                pause_and_return_menu
                ;;
            9)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                analyze_large_files
                show_summary
                pause_and_return_menu
                ;;
            10)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                find_duplicates
                show_summary
                pause_and_return_menu
                ;;
            11)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                DRY_RUN=true
                clean_ssh_sessions
                show_summary
                pause_and_return_menu
                ;;
            12)
                TOTAL_FREED=0
                TOTAL_ITEMS=0
                separator
                log "${MAGENTA}${BOLD}Ejecutando LIMPIEZA COMPLETA...${NC}"
                sub_separator
                
                echo ""
                log "${YELLOW}${BOLD}Advertencia: Ejecutaras TODAS las limpiezas${NC}"
                echo ""
                read -p "Deseas continuar? s para si, n para no: " -n 1 -r confirmacion
                echo ""
                
                if [ "$confirmacion" = "s" ] || [ "$confirmacion" = "S" ]; then
                    DRY_RUN=false
                    clean_apt_cache
                    clean_old_logs
                    clean_temp_files
                    clean_trash
                    clean_python_cache
                    clean_journalctl
                    clean_unused_packages
                    clean_dns_cache
                    analyze_large_files
                    find_duplicates
                    clean_ssh_sessions
                    show_summary
                else
                    log "${PURPLE}Operacion cancelada${NC}"
                    show_summary
                fi
                
                pause_and_return_menu
                ;;
            0)
                separator
                log "${LIME}${BOLD}Hasta luego${NC}"
                end_separator
                exit 0
                ;;
            *)
                log "${RED}Opcion no valida${NC}"
                sleep 2
                ;;
        esac
    done
}

# ============================================================================
# 🚀 MAIN
# ============================================================================

main() {
    # Verificar si es root
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}${BOLD}Este script requiere permisos de root${NC}"
        echo -e "${PURPLE}Ejecuta: ${CYAN}sudo $0${NC}"
        exit 1
    fi
    
    show_banner
    
    # Modo interactivo
    run_interactive
}

# Trap para Ctrl+C
trap 'echo -e "\n${LIME}Script interrumpido${NC}"; exit 0' INT

# Ejecutar main
main "$@"

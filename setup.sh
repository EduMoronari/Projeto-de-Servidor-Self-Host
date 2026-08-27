
# ==============================================================================
# Script de Instalação Automatizada - CasaOS + Stack Arr
# Script gerado por IA e revisado por mim
# ==============================================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Diretório onde este script está localizado
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Variáveis configuráveis
# Caso não seja passado o argumento, procura por uma pasta "AppData" ao lado deste script
APPDATA_SRC=${1:-"$SCRIPT_DIR/AppData"}
APPDATA_DEST="/DATA/AppData"
DATA_DIR="/DATA"

echo -e "${GREEN}Iniciando a instalação e configuração do servidor...${NC}"

# 1. Checagem de permissão
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Por favor, execute este script como root (ex: sudo ./setup.sh ./AppData)${NC}"
  exit 1
fi

# 2. Atualizar sistema e instalar dependências (removemos o git pois já estamos no repo local)
echo -e "${YELLOW}Atualizando o sistema e instalando dependências (curl, rsync)...${NC}"
apt-get update && apt-get install -y curl rsync

# 3. Instalar CasaOS
if ! command -v casaos &> /dev/null; then
    echo -e "${YELLOW}CasaOS não encontrado. Instalando CasaOS...${NC}"
    curl -fsSL https://get.casaos.io | sudo bash
else
    echo -e "${GREEN}CasaOS já está instalado. Pulando a instalação.${NC}"
fi

# 4. Preparar os diretórios base
echo -e "${YELLOW}Preparando estrutura de diretórios em $DATA_DIR...${NC}"
mkdir -p "$DATA_DIR/AppData"
mkdir -p "$DATA_DIR/Media/TV Shows"
mkdir -p "$DATA_DIR/Media/Movies"
mkdir -p "$DATA_DIR/Downloads"

# 5. Importar AppData
if [ -d "$APPDATA_SRC" ]; then
    echo -e "${YELLOW}Encontrada pasta AppData local em $APPDATA_SRC.${NC}"
    echo -e "${YELLOW}Importando configurações para $APPDATA_DEST...${NC}"
    
    # Sincroniza o conteúdo. A barra no final (/) é importante para não aninhar a pasta
    rsync -avh "$APPDATA_SRC/" "$APPDATA_DEST/"
    
    # Ajusta as permissões dos arquivos para evitar problemas com os contêineres PUID/PGID (1000)
    chown -R 1000:1000 "$APPDATA_DEST"
    echo -e "${GREEN}Configurações importadas com sucesso!${NC}"
else
    echo -e "${RED}Aviso: Pasta AppData ($APPDATA_SRC) não encontrada.${NC}"
    echo -e "${YELLOW}Os contêineres serão instalados do zero, sem configurações prévias.${NC}"
    sleep 3
fi

# 6. Subir os serviços via Docker Compose locais
echo -e "${YELLOW}Iniciando a instalação dos contêineres a partir dos arquivos locais...${NC}"

# Lista de serviços com ordem de prioridade (dependências primeiro)
SERVICOS_PRIORIDADE=("qbittorrent" "prowlarr" "bazarr" "sonarr" "jellyfin")

# Função para subir um docker-compose
subir_container() {
    local dir=$1
    local nome=$2
    if [ -f "$dir/docker-compose.yml" ]; then
        echo -e "${GREEN}Subindo contêiner: $nome...${NC}"
        cd "$dir"
        if docker compose version &> /dev/null; then
            docker compose up -d
        else
            docker-compose up -d
        fi
    fi
}

# 6.1. Instala primeiro os da lista de prioridade
for servico in "${SERVICOS_PRIORIDADE[@]}"; do
    subir_container "$SCRIPT_DIR/$servico" "$servico"
done

# 6.2. Lê os outros diretórios dentro da pasta do script para instalar eventuais novos serviços automaticamente
for COMPOSE_FILE in "$SCRIPT_DIR"/*/docker-compose.yml; do
    [ -e "$COMPOSE_FILE" ] || continue
    
    COMPOSE_DIR=$(dirname "$COMPOSE_FILE")
    SERVICO_NOME=$(basename "$COMPOSE_DIR")
    
    # Verifica se já não foi instalado no loop anterior
    if [[ ! " ${SERVICOS_PRIORIDADE[@]} " =~ " ${SERVICO_NOME} " ]]; then
        subir_container "$COMPOSE_DIR" "$SERVICO_NOME"
    fi
done

cd ~

echo -e "${GREEN}====================================================${NC}"
echo -e "${GREEN}Instalação finalizada com sucesso!${NC}"
echo -e "${YELLOW}Acesse o CasaOS através do IP deste servidor no seu navegador.${NC}"
echo -e "${YELLOW}Os seus aplicativos já devem estar visíveis no Dashboard ou rodando em segundo plano.${NC}"
echo -e "${GREEN}====================================================${NC}"



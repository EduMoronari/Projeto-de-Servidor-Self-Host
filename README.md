# 🌌 Servidor Self-Host (Media & Homelab)

![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Cloudflare](https://img.shields.io/badge/Cloudflare-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white)
![Jellyfin](https://img.shields.io/badge/Jellyfin-000B25?style=for-the-badge&logo=Jellyfin&logoColor=00A4DC)

Bem-vindo ao repositório de infraestrutura (*Infrastructure as Code*) do meu servidor doméstico. Este repositório armazena as receitas (`docker-compose.yml`) de todos os serviços que rodam no meu homelab, gerenciado através do **CasaOS** no **Ubuntu Server**.

## 🚀 Serviços Hospedados

A stack principal é voltada para a automação de mídia (The "Arr" Stack), com regras customizadas para priorizar conteúdo localizado e qualidade de vídeo:

*   **[Sonarr](https://sonarr.tv/):** Automação e gerenciamento de Séries e Animes. Configurado com *Custom Formats* rigorosos para capturar releases com legendas embutidas (`Multi-Sub`, `Erai-raws`) e áudio PT-BR.
*   **[Bazarr](https://www.bazarr.media/):** Busca automatizada de legendas complementares.
*   **[Prowlarr](https://prowlarr.com/):** Gerenciador central de indexadores e trackers (ex: Nyaa).
*   **[qBittorrent](https://www.qbittorrent.org/):** Cliente de download focado em performance.
*   **[Jellyfin](https://jellyfin.org/):** Media server de código aberto para streaming inteligente do conteúdo baixado.

## 🛡️ Segurança e Acesso Remoto

Nenhuma porta do servidor é exposta diretamente à internet. O acesso externo aos painéis de gerência e aos serviços é feito através do **Cloudflare Zero Trust (Tunnels)**:
*   Acesso web restrito via autenticação OTP (One-Time PIN) por e-mail.
*   Túneis HTTP diretos para os containers.
*   Acesso SSH remoto via Cloudflare Tunnels e Termius.

## 📂 Estrutura do Repositório

Cada serviço possui sua própria pasta contendo o arquivo `docker-compose.yml` correspondente.

```text
📦 Projeto-de-Servidor-Self-Host
┣ 📂 sonarr/
┃ ┗ 📜 docker-compose.yml
┣ 📂 qbittorrent/
┃ ┗ 📜 docker-compose.yml
┣ 📂 prowlarr/
┃ ┗ 📜 docker-compose.yml
┣ 📂 bazarr/
┃ ┗ 📜 docker-compose.yml
┣ 📂 jellyfin/
┃ ┗ 📜 docker-compose.yml
┗ 📜 README.md

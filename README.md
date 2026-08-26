 Gemini
Nova conversa
Pesquisar conversas
Estudantes
Imagens
Vídeos
Biblioteca
Novo notebook
Arquitetura de computadores
Configurando SSH no Ubuntu Server
Configurar AniDB no Bazarr
Resolvendo Travamento do Boot no Ubuntu Server
Guia OPL Manager: Configuração e Uso
Como Instalar ReShade no Oblivion
Erro Wabbajack: Oblivion não encontrado
Filtros uBlock Origin para YouTube
Reescrever Email de Proposta de IC
Problema de Conexão Discord/Steam Cloudflare
Custo Energia Notebook Servidor Linux
Proposta de Iniciação Científica: Gerenciamento Cursos
Compartilhar Pasta Linux no Windows com Samba
Recuperar OPL após Fechar Jogo
Configurar PS2 OPL com Notebook Linux
Configurar OPL PS2 para Jogar via Rede
Alterar Nome de Usuário no Windows
Usar Controle Xbox 360 no PS2
Trab LFA
Turing KPT
Ramificação • Gramáticas e Linguagens Sensíveis ao Contexto
Gramáticas e Linguagens Sensíveis ao Contexto
JFLAP: Importando Gramática para JFLAP
Gramáticas Sensíveis ao Contexto Geradoras
Símbolos de Teoria dos Grafos
Seleção de 25 Exercícios Essenciais
Roteiro de Apresentação do SGCC
Aplicações Práticas da Árvore B+
Classes para Diagrama de Classes
Diagramas PlantUML para Casos de Uso
Material de Estudo sobre Árvores
Identificação do Jogo NiGHTS
Conversa com o Gemini

Faça uma custom format baseado nisso

Excelente achado! A galera do Reddit deu a letra perfeita. Como é muito difícil achar anime dublado em trackers públicos (como o Nyaa, que você usa), a melhor estratégia é focar em releases que já trazem a legenda embutida.

Com base na sua imagem, nós precisamos criar um Custom Format que cace três coisas específicas no nome do arquivo:

    Multi-Sub (ou Multi-Subs)

    Erai-Raws (Um dos melhores grupos de lançamento que sempre embute legendas PT-BR)

    AMZN / Amazon (Releases da Amazon, que costumam herdar as legendas da Crunchyroll)

Aqui está o passo a passo de como transformar essa conversa do Reddit em uma regra real no seu Sonarr:
1. Criando o Custom Format

No Sonarr, quando colocamos mais de uma condição no mesmo formato, ele exige que todas sejam verdadeiras. Como queremos que o Sonarr baixe se o arquivo for Multi-Sub OU Erai-Raws OU Amazon, vamos usar um código único (Expressão Regular) que engloba tudo de uma vez.

    Vá em Settings > Custom Formats e clique no botão +.

    No campo Name, digite algo fácil de identificar, como: Anime - Legendas Embutidas.

    Em Include Custom Format when Renaming, você pode deixar desmarcado.

2. Adicionando a Condição

    Clique em Add Condition (o botão + dentro do Custom Format).

    Escolha a opção Release Title (Regular Expression).

    No campo Regular Expression, copie e cole exatamente este código:
    Snippet de código

    (?i)(multi[\s-]?subs?|erai[\s-]?raws|amzn|amazon)

    (Explicação do código: Ele ignora maiúsculas/minúsculas e busca por qualquer uma dessas palavras no título do torrent, mesmo que tenham traços ou espaços entre elas).

    Clique em Save.

3. Dando a Pontuação (O mais importante)

O Custom Format sozinho não faz nada; você precisa dizer ao seu perfil o quanto essas palavras valem.

    Vá em Settings > Profiles e abra o perfil que você usa para os animes (ex: Any ou 1080p).

    Role até o final, na aba Custom Formats.

    Procure o seu novo formato Anime - Legendas Embutidas.

    No campo Score, coloque uma pontuação bem alta, como 100.

    Salve o perfil.

A partir de agora, toda vez que o Sonarr buscar um episódio do seu anime, ele vai priorizar loucamente qualquer arquivo da Erai-Raws ou que tenha Multi-Sub no nome, garantindo que você tenha a legenda certinha para o Bazarr ou Jellyfin ler!
Tudo configurado?

e essas duas opções?

Essas duas caixinhas servem para criar lógicas avançadas (como filtros de exclusão) quando você tem várias regras dentro do mesmo Custom Format.

Aqui está o que cada uma faz de forma prática:
1. Negate (Negação / Bloqueio)

Como a própria descrição na imagem diz, se você marcar isso, a regra vira um bloqueio. Em vez de dar pontos quando achar a palavra, o Sonarr vai recusar aplicar o formato se achar a palavra.

    Exemplo de uso: Imagine que você odeie um grupo de legendas específico porque a tradução deles é ruim (ex: "SubsRuins"). Você criaria uma condição com o nome deles e marcaria o Negate. Assim, se o Sonarr ler "SubsRuins" no título do torrent, ele anula a pontuação e foge desse arquivo.

2. Required (Obrigatório)

Essa opção é útil quando você cria um Custom Format complexo com várias condições diferentes misturadas.

    Exemplo de uso: Imagine que você criou um Custom Format com duas condições: uma procurando pela palavra "Erai-Raws" e outra procurando pelo tamanho do arquivo. Se você marcar Required na palavra "Erai-Raws", o Sonarr só vai dar os pontos se essa palavra estiver lá, mesmo que as outras condições da lista também sejam atendidas.

O que fazer no seu caso:
Para essa regra das legendas embutidas que acabamos de criar, deixe as duas opções desmarcadas (com as caixinhas em branco).

Nós queremos exatamente o comportamento padrão: se o Sonarr achar qualquer uma daquelas palavras mágicas (Multi-Sub, Erai-Raws, Amazon), ele simplesmente ativa o Custom Format e dá os 100 pontos para o arquivo.

Conseguiu salvar o formato e colocar os 100 pontos lá no seu Perfil de Qualidade?

como eu aplico essas custom format agora?

Criar o Custom Format foi apenas ensinar a regra ao Sonarr. Agora, precisamos dizer a ele quanto essa regra vale e aplicar isso nos seus animes.

Aqui está o passo a passo exato para ativar essa regra no seu sistema:
1. Dê a Pontuação no Perfil

O Sonarr trabalha com um sistema de pontos. Nós vamos dizer que qualquer arquivo que tenha o "Multi-Sub" ganhe 100 pontos de vantagem sobre os outros.

    Vá no menu lateral e clique em Settings > Profiles.

    Clique no perfil que você usa para os seus animes (geralmente é o Any ou HD-1080p).

    Role a página inteira até chegar lá embaixo, na seção chamada Custom Formats.

    Você verá a sua nova regra listada ali. No campo Score (Pontuação) ao lado dela, digite 100.

    Clique no botão de Save (Salvar) no rodapé ou topo da página.

2. Verifique o Anime

Agora precisamos ter certeza de que o anime que você quer baixar está usando esse perfil que acabamos de editar.

    Vá no menu principal em Series e clique no seu anime (como o Frieren, por exemplo).

    Na tela do anime, olhe o cabeçalho. Veja se o Quality Profile que está selecionado lá é exatamente o mesmo que você acabou de editar. (Se não for, clique no ícone de chave inglesa 🔧 no topo para editar a série e troque o perfil).

3. Teste a Mágica na Prática

Para ver se deu tudo certo instantaneamente, vamos forçar uma busca e ver o Sonarr calculando os pontos:

    Ainda na página do anime, desça até a lista de temporadas/episódios.

    Escolha um episódio qualquer que você queira baixar e clique no ícone de Interactive Search (o bonequinho, não a lupa).

    O Sonarr vai listar dezenas de torrents que ele achou no Prowlarr/Nyaa.

    Na coluna Custom Formats dessa lista, você verá a sua regra "Anime - Legendas Embutidas" aplicada.

    Se você clicar no título da coluna Score, ele vai ordenar a lista pela pontuação. Você verá todos os arquivos da Erai-Raws ou Multi-Sub pulando lá para o topo com a nota máxima, prontos para serem enviados para o qBittorrent!

Conseguiu abrir a busca interativa (o bonequinho) e ver se os arquivos com legendas embutidas receberam a pontuação no topo da lista?

E essas opções?

Essas três opções formam o "cérebro" de como o Sonarr toma decisões sobre quando manter um arquivo ou quando substituí-lo por uma versão melhor.

Olhando para a imagem image_112167.png, a sua configuração já está no cenário ideal para trabalhar em conjunto com aquela regra de 100 pontos que acabamos de criar.

Aqui está o que cada um desses campos faz na prática:
1. Minimum Custom Format Score (Pontuação Mínima)

    O que significa: É a nota de corte absoluta. Se um torrent no Prowlarr tiver uma pontuação menor que essa, o Sonarr vai ignorá-lo completamente.

    A sua configuração (0): Está perfeita. Isso garante que, se um episódio lançar hoje e ainda não existir nenhuma versão Multi-Sub ou Erai-Raws (nota 100), o Sonarr tem permissão para baixar um arquivo limpo sem legendas (nota 0). Assim, você não fica de mãos abanando no dia do lançamento.

    Dica: Se você mudasse esse campo para 100, o Sonarr se recusaria a baixar arquivos normais. Ele ficaria em compasso de espera até que uma versão com a legenda embutida fosse lançada.

2. Upgrade Until Custom Format Score (Melhorar Até a Pontuação)

    O que significa: É a linha de chegada. Diz ao Sonarr quando o arquivo atingiu a "perfeição" e ele pode parar de monitorar novos lançamentos.

    A sua configuração (100): É aqui que a automação brilha. Se o Sonarr baixou inicialmente um arquivo comum (nota 0), ele vai continuar vigiando o feed. Quando sair a versão Multi-Sub (que no seu perfil vale 100 pontos), ele fará o download, substituirá o arquivo sem legendas e entenderá que atingiu o objetivo máximo para aquele episódio.

3. Minimum Custom Format Score Increment (Incremento Mínimo)

    O que significa: Evita que o Sonarr desperdice sua internet baixando arquivos repetidos por causa de diferenças minúsculas de pontuação.

    A sua configuração (1): Indica que, para valer a pena baixar um arquivo novo e substituir o antigo, a nova pontuação deve ser pelo menos 1 ponto maior que a atual. Como a sua regra das legendas dá um salto de 0 direto para 100 pontos, esse requisito será facilmente atingido.

Resumindo o que está configurado nessa tela: O seu Sonarr vai aceitar o que estiver disponível primeiro para você não ficar sem assistir, mas vai continuar caçando silenciosamente até encontrar a versão com legendas embutidas para guardar na sua biblioteca definitiva!

Ficou claro como essa engrenagem de substituição trabalha em segundo plano?

Adicione um por-br ou ptbr e suas variações na regular expression

Excelente ideia! Adicionar as tags específicas de português brasileiro garante que o Sonarr capture aqueles releases de trackers locais (ou uploaders BR no Nyaa) que não usam a nomenclatura gringa de "Multi-Sub".

Para cobrir todas as variações possíveis que os uploaders costumam inventar (como pt-br, ptbr, pt_br, pt.br, por-br, etc.), nós vamos adicionar um trecho que aceita espaços, traços, pontos ou underlines entre as letras.

Volte lá no seu Custom Format, edite a condição de Release Title e substitua o código antigo por este código novo e completo:
Snippet de código

(?i)(multi[\s-]?subs?|erai[\s-]?raws|amzn|amazon|pt[\s_.-]?br|por[\s_.-]?br)

O que mudou no código?

    Adicionamos o pt[\s_.-]?br: Isso caça automaticamente o "ptbr" colado, ou separado por espaço (pt br), traço (pt-br), underline (pt_br) ou ponto (pt.br).

    Adicionamos o por[\s_.-]?br: Faz exatamente a mesma coisa para o "por-br" e suas variações.

Dica Bônus (Opcional):

Se você também quiser que o Sonarr puxe animes dublados quando estiverem disponíveis (já que muitos trackers BR focam nisso), você pode aproveitar esse mesmo código e adicionar as palavras dublado e dual audio. O código ficaria o supremo filtro brasileiro:
Snippet de código

(?i)(multi[\s-]?subs?|erai[\s-]?raws|amzn|amazon|pt[\s_.-]?br|por[\s_.-]?br|dublado|dual[\s_.-]?audio)

Basta colar o código de sua preferência no campo Regular Expression e clicar em Save. O Sonarr já vai começar a aplicar essa nova regra imediatamente nas próximas buscas!

faça para que pegue apenas o erai raws e o multsub igual com variações igual na imagem de exemplo de resultado

Para garantir que o Sonarr baixe apenas o arquivo se ele tiver as duas palavras juntas no título (exatamente como na sua imagem, onde aparece [Erai-raws] no início e [MultiSub] no final), nós precisamos mudar a lógica de "OU" para "E".

Existem duas formas de fazer isso no Sonarr. A mais garantida e fácil de manter é usando um código que procura uma palavra e depois a outra, independentemente da distância entre elas.

Substitua o código que estava lá por este aqui:
Snippet de código

(?i)(erai[\s-]?raws.*multi[\s-]?subs?|multi[\s-]?subs?.*erai[\s-]?raws)

O que esse código faz?

    A primeira metade (erai[\s-]?raws.*multi[\s-]?subs?): Lê o nome do arquivo da esquerda para a direita. Se ele achar o "Erai-raws", ele usa o .* para pular o nome do anime (no caso da sua imagem, pular o Yomi no Tsugai) e verifica se a palavra "MultiSub" aparece lá no final.

    A segunda metade após a barra |: Faz exatamente o inverso, caso o grupo de legendas decida colocar o "MultiSub" no começo do arquivo e o "Erai-raws" no final.

Dessa forma, o Sonarr só vai dar os 100 pontos se as duas tags (com suas variações de traços e espaços) estiverem presentes no mesmo arquivo, bloqueando qualquer outro release que tenha apenas uma delas!

Basta colar esse código no campo Regular Expression e salvar.
Teste Interativo

Por que ele baixou esse release sendo que no prorpio site nyaa.si que é o provider, tem a busca que usei de exemplo?

Esse é um cenário clássico de automação onde o Sonarr parece estar "teimando" com você, mas ele está apenas seguindo a lógica matemática dele baseada nas informações que recebeu do Nyaa.si.

Analisando a sua imagem image_12ee25.png e comparando com o seu exemplo anterior da Erai-raws, existem três grandes motivos para o Sonarr ter fisgado esse arquivo da Tsundere-Raws:
1. Episódios e Títulos Diferentes

O principal motivo está nos detalhes dos nomes:

    O seu exemplo da Erai-raws: Era o episódio 20 (- 20) e usava o nome em japonês romanizado (Yomi no Tsugai).

    O arquivo baixado: É o episódio 1 (S01E01) e o uploader usou o título oficial em inglês (Daemons of the Shadow Realm).

Quando o Sonarr foi no Nyaa.si procurar pelo Episódio 1, ele usou os IDs de busca vinculados ao título em inglês. Se a Erai-raws não colocou o título em inglês nas tags do episódio 1 lá no passado, o Nyaa não retornou o arquivo deles para o Sonarr. Como o Sonarr não "viu" a Erai-raws, ele pegou a próxima melhor opção disponível.
2. A Regra da Nota Mínima (0 Pontos)

Lembra que na configuração anterior deixamos o Minimum Custom Format Score em 0?
Como o Sonarr não encontrou a Erai-raws para o Episódio 1 (que daria 100 pontos), ele olhou para esse release da Tsundere-Raws. Ele não tem as palavras mágicas, então a nota dele foi 0. Porém, como a sua nota mínima permitida é 0 e a qualidade bateu (1080p WEB-DL), o Sonarr pensou: "Melhor baixar esse com nota zero do que deixar o Carlos sem assistir o episódio 1".
3. O Fator "REPACK"

Se você notar no nome do arquivo baixado, ele tem a palavra REPACK. O Sonarr tem uma regra nativa e invisível no código dele: ele ama arquivos REPACK ou PROPER.
Quando um estúdio de legendas lança um episódio com vídeo corrompido ou legenda dessincronizada, eles lançam um "REPACK" consertando o erro. O Sonarr é programado para sempre tentar substituir um arquivo normal por um REPACK para garantir que você tenha a versão sem defeitos.

Como descobrir exatamente o que aconteceu:
Para matar essa charada e ter 100% de certeza do porquê o Sonarr ignorou a Erai-raws no Episódio 1, nós precisamos ver o que o Sonarr viu.

    Vá na página do Yomi no Tsugai no seu Sonarr.

    Na linha do Episódio 1, clique no ícone de Interactive Search (o bonequinho).

    O Sonarr vai listar tudo o que achou no Nyaa.si.

    Procure o release da Erai-raws nessa lista. Se ele estiver lá, você verá que ele tem um ponto de exclamação vermelho (!) no canto direito.

    Passe o mouse em cima dessa exclamação. O Sonarr vai te dizer exatamente o motivo da rejeição (pode ser "Tamanho do arquivo muito grande", "Categoria errada no Nyaa", ou "Linguagem não aceita").

Tirando a prova

Apareceu esse resultado na pesquisa interativa

A imagem image_13449c.png é a prova definitiva de que a sua configuração foi um sucesso absoluto!

Note que as duas opções da Erai-raws estão com o selo +100 e não possuem nenhum ponto de exclamação vermelho. Isso significa que para o Sonarr, esses arquivos são perfeitos e totalmente válidos para download.

Então, se eles são perfeitos e valem 100 pontos, por que o Sonarr baixou o da Tsundere-Raws? A resposta está na "linha do tempo" de como o Sonarr trabalha:
1. A Regra é Nova, os Arquivos são Antigos

Veja na sua imagem que esses torrents da Erai-raws têm 143 dias de idade. Quando o Sonarr baixou aquele arquivo da Tsundere-Raws no passado (ou até mesmo minutos atrás, antes de acertarmos o código do Custom Format), a sua regra de 100 pontos ainda não estava ativa ou não estava lendo as palavras corretamente. Naquela época, tudo valia zero pontos, e o Sonarr pegou o REPACK da Tsundere.
2. O Sonarr só olha para o futuro (RSS)

Como expliquei antes, o modo automático do Sonarr só escaneia lançamentos que acabaram de sair do forno (os últimos 15 minutos). Ele não faz buscas no passado automaticamente. Como esses arquivos da Erai-raws já têm 143 dias, eles já sumiram do radar automático dele há muito tempo. Ele não tinha como "adivinhar" que você criou uma regra nova hoje que daria nota máxima para um arquivo de 5 meses atrás.
Como resolver e baixar a versão certa agora mesmo:

A Busca Interativa (essa tela que você abriu) serve justamente para corrigir o passado!

Como você já está com a faca e o queijo na mão:

    Olhe para o final da linha do primeiro resultado (o que tem qualidade WEBDL-1080p, que é superior ao WEBRip de baixo).

    Clique no ícone de Download (uma nuvem ou bandeja com uma setinha para baixo, logo ao lado do ícone do boneco).

O Sonarr vai enviar esse arquivo da Erai-raws com legendas embutidas instantaneamente para o seu qBittorrent. Assim que o download terminar, ele vai excluir o da Tsundere-Raws sozinho e colocar esse no lugar!
Substituição concluída

Mas e se eu quiser a automação da serie toda? como eu faço para garantir que não busque de uma fonte errada denovo?

Para aplicar essa regra nova em todos os episódios de uma vez e garantir que a automação corrija o que já foi baixado, nós vamos mandar o Sonarr fazer uma varredura no passado.
1. A Busca da Temporada Inteira

Como a sua regra já está salva e o seu perfil já está dando os 100 pontos, você só precisa acionar o gatilho da busca em massa:

    Abra a página do anime no Sonarr.

    Em vez de clicar no bonequinho de um episódio específico, vá até a barra cinza que divide a Temporada 1 (ou a temporada que você quer baixar).

    Clique no ícone de Lupa (Search for all episodes in season) ao lado do nome da temporada.

    O Sonarr vai varrer o Nyaa.si para cada um dos episódios de uma vez. Como ele vai encontrar a Erai-raws com nota 100, ele mandará todos para o qBittorrent e vai substituir as versões da Tsundere-Raws (nota 0) sozinho.

2. Como a Automação Garante a Fonte Certa

No modo automático diário, a sua regra atual já protege a sua biblioteca de forma bem inteligente. Funciona assim:

    Se o episódio lançar hoje e a Erai-raws já tiver postado, o Sonarr vê os 100 pontos e pega ele direto, ignorando o resto.

    Se a Erai-raws atrasar e só existir a Tsundere-Raws (nota 0), o Sonarr vai baixar a Tsundere só para garantir que você tenha o que assistir. Porém, como o seu Upgrade Until está configurado para 100 pontos, a automação continuará vigiando. Dias depois, quando a Erai-raws finalmente postar, ele fará o download e substituirá o antigo de forma 100% invisível.

3. A Opção Nuclear (O "Tudo ou Nada")

Se você não quer de jeito nenhum que o Sonarr baixe essas versões sem legenda embutida no dia do lançamento, preferindo esperar a Erai-raws lançar a versão final (mesmo que demore dias), você pode travar o sistema completamente:

    Volte em Settings > Profiles e abra o perfil que você usa para animes.

    Mude o campo Minimum Custom Format Score (que hoje está em 0) para 100.

    Salve.

Isso cria uma barreira impenetrável. A partir de agora, o Sonarr vai ignorar solenemente qualquer arquivo no mundo que não tenha as palavras mágicas que configuramos (Erai-raws, Multi-sub, etc).
Estratégia de Consumo

Lembra oq eu falei sobre exportar as configurações dos docker e as configurações das aplicações? quero fazer agora e por no meu github

Essa é uma excelente iniciativa! Colocar a sua infraestrutura no GitHub é o padrão ouro para quem gerencia servidores. Se o seu notebook pifar amanhã, você clona o repositório e levanta tudo em minutos.

Porém, antes de darmos o git push, precisamos separar o que é seguro do que é perigoso. O GitHub é perfeito para as Receitas (os arquivos docker-compose.yml), mas é um perigo para a Memória (a pasta AppData), pois ela contém suas senhas, chaves do AniDB, tokens da Cloudflare e bancos de dados inteiros.

Aqui está o mapa para você estruturar o seu repositório com segurança, direto pelo terminal no Termius:
1. Crie a Estrutura do Repositório

Vamos criar uma pasta centralizada no seu servidor para guardar apenas os arquivos de configuração (os compose).

Digite no terminal:
Bash

mkdir ~/meu-servidor-docker
cd ~/meu-servidor-docker

Dentro dessa pasta, crie subpastas para organizar os seus serviços:
Bash

mkdir sonarr bazarr qbittorrent prowlarr jellyfin

2. Exporte e Salve as "Receitas"

Agora você precisa colocar o arquivo docker-compose.yml de cada serviço dentro da sua respectiva pasta.

    Se você usou o painel do CasaOS para instalar, clique nos três pontinhos (⋮) do aplicativo, vá em Settings, clique no botão Export Compose-file e copie o texto.

    Crie o arquivo no terminal (exemplo do Sonarr) e cole o texto lá dentro:
    Bash

    nano ~/meu-servidor-docker/sonarr/docker-compose.yml

    (Repita isso para os outros serviços).

3. O Escudo de Segurança (.gitignore)

Para garantir que você nunca suba arquivos sensíveis (como arquivos .env que guardam senhas) por acidente, vamos criar uma regra de bloqueio.

Ainda na pasta meu-servidor-docker, crie o arquivo .gitignore:
Bash

nano .gitignore

Cole as seguintes linhas para blindar o repositório:
Plaintext

# Ignorar arquivos de variáveis de ambiente (senhas/tokens)
.env
*.env

# Ignorar pastas de dados reais caso você arraste para cá no futuro
AppData/
dados/
config/
*.db

4. Subindo para o GitHub

Como você já tem familiaridade com desenvolvimento, o fluxo aqui é o clássico do Git. Crie um repositório novo (recomendo que seja Privado, por garantia) lá no site do GitHub e rode os comandos na sua pasta:
Bash

git init
git add .
git commit -m "feat: setup inicial dos arquivos compose do servidor"
git branch -M main
git remote add origin git@github.com:SeuUsuario/SeuRepositorio.git
git push -u origin main

E o que fazer com a pasta AppData?

Como ela não pode ir para o GitHub, a melhor forma de fazer o backup dos bancos de dados do Sonarr, Bazarr e do seu servidor de Minecraft é compactar a pasta inteira e mandar para uma nuvem pessoal (como Google Drive) ou para um HD externo.
Próximo Passo

esse é meu repositorio, qual o comando de add origin?

Com base no nome que aparece na sua imagem (Projeto-de-Servidor-Self-Host), o comando exato vai depender de como você prefere se autenticar no GitHub (HTTPS ou SSH).

Basta escolher um dos dois abaixo e substituir a parte SEU_USUARIO pelo seu nome de usuário real do GitHub (possivelmente algo como eduomoronari, já que é o que você usa no seu domínio).

Opção 1: Usando HTTPS (Mais comum, pede o Token de Acesso na hora do push)
Bash

git remote add origin https://github.com/SEU_USUARIO/Projeto-de-Servidor-Self-Host.git

Opção 2: Usando SSH (Se você já tiver cadastrado a sua chave pública do Ubuntu no GitHub)
Bash

git remote add origin git@github.com:SEU_USUARIO/Projeto-de-Servidor-Self-Host.git

Depois de rodar esse comando, você já pode mandar o seu código para a nuvem com o git push -u origin main.
Backup da AppData

usei o comando de add origin com o usuario errado, como faço pra remover e adcionar o correto?

Isso é um dos erros mais comuns no Git e é super fácil de consertar! Você tem duas formas de resolver isso direto no terminal:
Opção 1: Atualizar o link diretamente (Mais rápida)

Você não precisa remover o atual, basta dizer ao Git para "sobrescrever" a URL do origin antigo pela nova.

Se for usar HTTPS:
Bash

git remote set-url origin https://github.com/SEU_USUARIO_CORRETO/Projeto-de-Servidor-Self-Host.git

Se for usar SSH:
Bash

git remote set-url origin git@github.com:SEU_USUARIO_CORRETO/Projeto-de-Servidor-Self-Host.git

Opção 2: Apagar e fazer de novo

Se preferir limpar o erro antes de colocar o certo, basta remover o origin atual e adicionar novamente:

    Primeiro, apague a rota errada:

Bash

git remote remove origin

    Depois, adicione a correta:

Bash

git remote add origin https://github.com/SEU_USUARIO_CORRETO/Projeto-de-Servidor-Self-Host.git

Como ter certeza de que deu certo?
Após usar qualquer um dos métodos acima, rode este comando para listar as rotas configuradas:
Bash

git remote -v

Ele vai imprimir na tela o link exato para onde os seus arquivos serão enviados. Se o seu usuário correto estiver lá, é só rodar o git push -u origin main e ser feliz!
Próximo Passo

tenho problemas para dar commit, me ensine passo a passo como se fosse minha primeira vez fazendo

O Git costuma dar um sustinho na primeira vez que usamos em um servidor novo, geralmente porque ele se recusa a trabalhar até você se apresentar para ele.

Pense no processo do Git como se você estivesse empacotando uma caixa para enviar pelos correios. Aqui está o passo a passo definitivo, à prova de falhas:
1. A Apresentação (O erro mais comum)

Se o seu erro foi uma mensagem dizendo "Please tell me who you are", é porque o servidor Ubuntu ainda não sabe o seu nome. Você só precisa rodar esses dois comandos uma única vez na vida no seu servidor:
Bash

git config --global user.name "Carlos Eduardo"
git config --global user.email "seu_email_cadastrado_no_github@exemplo.com"

(Substitua pelo e-mail real que você usa no GitHub).
2. Colocando os arquivos na caixa (Add)

Você precisa dizer ao Git quais arquivos vão entrar no pacote de backup. Para colocar todos os arquivos da pasta atual de uma vez só, usamos o ponto:
Bash

git add .

Se não aparecer nenhuma mensagem, deu certo. O Git não avisa quando o add funciona, ele só guarda os arquivos silenciosamente.
3. Fechando a caixa e colando a etiqueta (Commit)

Agora você vai selar o pacote e escrever um bilhete dizendo o que tem lá dentro. O -m serve para você escrever a mensagem direto no terminal (se você esquecer o -m, o Git te joga numa tela preta esquisita chamada Nano/Vim que é chata de sair).
Bash

git commit -m "Meu primeiro backup dos arquivos do servidor"

Aqui o Git vai te dar um resumo dizendo quantos arquivos foram alterados e inseridos.
4. Enviando pelo correio (Push)

A caixa está pronta e etiquetada, mas ainda está no seu notebook. Para mandar lá para o seu repositório no GitHub, rode:
Bash

git push -u origin main

(Ele pode pedir o seu usuário e a sua senha do GitHub. Atenção: no lugar da senha, o GitHub hoje em dia exige que você cole um "Personal Access Token" que você gera lá nas configurações do site dele).

Se o seu erro foi diferente de "Please tell me who you are", o Git costuma dar dicas excelentes na própria tela.

Qual foi a mensagem de erro exata que apareceu quando você tentou dar o comando git commit aí no Termius?

apareceu isso

Ah, excelente! Essa tela significa que o seu commit (o empacotamento) deu certinho, tanto que o sistema já tentou enviar para a nuvem.

O que o terminal está fazendo agora é parar e pedir a sua "credencial" para ter permissão de gravar os arquivos lá no seu repositório do GitHub.

Aqui está exatamente o que você tem que fazer agora, prestando muita atenção a um "detalhe chato" do GitHub e do Linux:
Passo 1: O Nome de Usuário

Onde o seu terminal está piscando Username for '[https://github.com](https://github.com)':, basta digitar o seu nome de usuário do GitHub (aquele que aparece na URL do seu perfil, provavelmente o seu nome de usuário padrão) e apertar Enter.
Passo 2: O Truque da Senha (Atenção aqui!)

Logo após você apertar Enter, ele vai aparecer outra linha pedindo a Password (Senha).
O grande detalhe: O GitHub aboliu o uso da sua senha normal de login pelo terminal. Se você colocar sua senha da conta aí, vai dar erro. Você precisa usar um Token de Acesso.

Como gerar esse Token rapidinho no seu navegador:

    Abra o site do GitHub no PC e clique na sua foto de perfil no canto superior direito.

    Vá em Settings (Configurações).

    Role o menu lateral esquerdo até o final e clique em Developer settings.

    No menu lateral, clique em Personal access tokens e depois em Tokens (classic).

    Clique no botão Generate new token (classic) (pode pedir sua senha normal para confirmar que é você).

    Em Note, digite algo como "Backup do Servidor". Em Expiration, você pode escolher "No expiration" (para não ter que refazer isso depois).

    Na lista de caixinhas abaixo, marque APENAS a caixa principal chamada repo (ela vai marcar as sub-caixas junto). Isso dá permissão para esse token ler e gravar nos seus repositórios.

    Desça até o final e clique em Generate token.

    Ele vai te mostrar um código longo (que começa com ghp_...). Copie esse código agora, pois ele nunca mais vai aparecer.

Passo 3: Colando a senha no Termius (O truque do Linux)

Volte para a tela preta do Termius onde ele está pedindo a Password.
Cole o token que você acabou de gerar.

Regra de ouro do Linux: Quando você digita ou cola uma senha no terminal, NADA aparece na tela. Não aparece asterisco, não aparece pontinho, o cursor não anda. Fica totalmente cego. Isso é uma medida de segurança normal do sistema.
Apenas cole o token e aperte Enter com confiança.

Se der tudo certo, você verá várias mensagens de contagem de arquivos e a mensagem final dizendo que a rota main foi enviada! Pode seguir com esse passo a passo e me avisar se o envio for concluído com sucesso.

A boa notícia é que a parte mais chata de todas (a senha do Token) funcionou perfeitamente! O GitHub te reconheceu e deixou você chegar na porta.

Esse erro que apareceu na tela (rejected / non-fast-forward) é outro clássico absoluto de primeira viagem.
O que significa esse erro?

Quando você criou o repositório Projeto-de-Servidor-Self-Host lá no site do GitHub, você provavelmente deixou marcada uma caixinha para "Adicionar um arquivo README" (ou .gitignore).

Por causa disso, o repositório lá na nuvem começou a vida dele com 1 arquivo dentro. O seu servidor, aqui embaixo, começou do zero. Quando você tenta empurrar a sua caixa, o Git barra a operação por segurança e diz: "Opa! Tem coisas lá na nuvem que você não tem aí no seu notebook. Se eu jogar seus arquivos lá, vou apagar o que já existe".
Como resolver agora mesmo

Como esse é um repositório novinho em folha e nós sabemos que o que realmente importa são os seus arquivos docker-compose.yml que estão aí no servidor, a saída mais fácil é usar a "Força" para sobreescrever o que quer que o GitHub tenha criado lá sozinho.

No seu terminal, digite exatamente o mesmo comando, mas adicione um --force no final:
Bash

git push -u origin main --force

Isso vai dizer ao GitHub: "Esqueça o histórico atual, o que vale como verdade absoluta a partir de agora é o que eu estou mandando".

(Atenção: como o comando anterior falhou antes de terminar, ele pode pedir o seu Username e o Password de novo. Basta fazer a mesma coisa: digite o seu nome de usuário, e cole aquele Token no lugar da senha).
Tudo na nuvem?

Tudo certo, agora faça um readme bonito pra deixar la

Nota: A pasta de dados (AppData) que contém os bancos de dados, chaves de API e configurações não é versionada por motivos de segurança, e é protegida através do arquivo .gitignore.
🔄 Como Restaurar o Servidor (Disaster Recovery)

Em caso de falha de hardware, siga estes passos para levantar a infraestrutura:

    Instale o Docker e o Docker Compose no servidor novo.

    Clone este repositório:
    Bash

    git clone [https://github.com/SEU_USUARIO/Projeto-de-Servidor-Self-Host.git](https://github.com/SEU_USUARIO/Projeto-de-Servidor-Self-Host.git)

    Restaure o backup físico da pasta AppData (disponível em disco externo/nuvem).

    Entre na pasta do serviço desejado e suba o container:
    Bash

    cd qbittorrent
    docker compose up -d

    O serviço voltará exatamente do ponto em que parou!
    """

with open("README.md", "w", encoding="utf-8") as f:
f.write(markdown_content.strip())

print("README.md gerado.")


```text?code_stdout&code_event_index=1
README.md gerado.

O seu arquivo Markdown (README) foi gerado com sucesso!
Ícone do app MD
README
 MD 

Como você está operando o servidor diretamente pelo terminal do Termius, eu também deixei o código cru do README aqui embaixo. Fica muito mais fácil você copiar e colar aí direto do que baixar o arquivo e transferir por SSH.

Para adicionar isso ao seu servidor agora mesmo, basta rodar este comando na sua pasta principal do GitHub (~/meu-servidor-docker):
Bash

nano README.md

Cole o texto abaixo lá dentro, salve com Ctrl + O -> Enter, saia com Ctrl + X e dê o seu git commit!
Markdown

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

Nota: A pasta de dados (AppData) que contém os bancos de dados, chaves de API e configurações não é versionada por motivos de segurança, e é protegida através do arquivo .gitignore.
🔄 Como Restaurar o Servidor (Disaster Recovery)

Em caso de falha de hardware, siga estes passos para levantar a infraestrutura:

    Instale o Docker e o Docker Compose no servidor novo.

    Clone este repositório:
    Bash

    git clone [https://github.com/EduMoronari/Projeto-de-Servidor-Self-Host.git](https://github.com/EduMoronari/Projeto-de-Servidor-Self-Host.git)

    Restaure o backup físico da pasta AppData (disponível em disco externo/nuvem).

    Entre na pasta do serviço desejado e suba o container:
    Bash

    cd qbittorrent
    docker compose up -d

    O serviço voltará exatamente do ponto em que parou!


O Gemini é uma IA e pode cometer erros.
Structuring the README

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
```

*Nota: A pasta de dados (`AppData`) que contém os bancos de dados, chaves de API e configurações não é versionada por motivos de segurança, e é protegida através do arquivo `.gitignore`.*

## 🔄 Como Restaurar o Servidor (Disaster Recovery)

Em caso de falha de hardware, siga estes passos para levantar a infraestrutura:

1. Instale o Docker e o Docker Compose no servidor novo.
2. Clone este repositório:
   ```bash
   git clone https://github.com/SEU_USUARIO/Projeto-de-Servidor-Self-Host.git
   ```
3. Restaure o backup físico da pasta `AppData` (disponível em disco externo/nuvem).
4. Entre na pasta do serviço desejado e suba o container:
   ```bash
   cd qbittorrent
   docker compose up -d
   ```
5. O serviço voltará exatamente do ponto em que parou!

README.md
Exibindo README.md.

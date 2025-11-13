# 🛠️ Automatizações Básicas (I)

Este projeto contém um script em **Shell Script** que automatiza tarefas rotineiras em sistemas Linux (como o Ubuntu Server).  
O objetivo é promover **consistência** e **reprodutibilidade** em ambientes de desenvolvimento e operações ágeis, seguindo práticas comuns em DevOps.

---

## 📌 Funcionalidades

O script oferece um menu interativo com as seguintes opções:

1. **Atualizar pacotes do sistema**  
   - Atualiza a lista de pacotes (`apt update`)  
   - Atualiza pacotes instalados (`apt upgrade`)  
   - Remove pacotes obsoletos (`apt autoremove`)  

2. **Renomear arquivos em um diretório**  
   - Adiciona **prefixo** ou **sufixo** a todos os arquivos de um diretório.  
   - Mantém extensões originais e evita renomear diretórios ou executáveis.  

3. **Criar novo usuário**  
   - Automatiza a criação de usuários no sistema.  
   - Solicita informações necessárias e exige privilégios de superusuário.  

4. **Monitorar espaço em disco**  
   - Utiliza o comando `df` para exibir informações sobre uso de disco.  

5. **Backup de diretório**  
   - Realiza backup de um diretório específico.  
   - Utiliza compressão **gzip** para otimizar espaço.  

6. **Sair**  
   - Encerra o script.

---

## 🚀 Como usar

1. Clone este repositório ou copie o script para seu servidor:
   ```bash
   git clone https://github.com/Naygno/automacao-um.git
   cd automacao-um
   ```

2. Dê permissão de execução ao script:
   ```bash
   chmod +x automatizacao-um.sh
   ```

3. Execute o script:
   ```bash
   ./automatizacao-um.sh
   ```

---

## ⚠️ Requisitos

- Distribuição Linux baseada em **Debian/Ubuntu**.  
- Permissão de **superusuário** para operações como atualização de pacotes e criação de usuários.  
- Ferramentas básicas já instaladas: `bash`, `apt`, `df`, `gzip`.

---

## 📚 Contexto

Este script foi desenvolvido como parte da atividade **Hora da Prática**, que propõe exercícios de automação em Shell Script para consolidar conhecimentos em DevOps:

- Atualização de pacotes  
- Renomeação de arquivos  
- Criação de usuários  
- Monitoramento de disco  
- Backup com compressão  

---

## 👨‍💻 Autor

- **Naygno B. Noia**  
- Data: 13/11/2025

---

## 🐧 Licença

Este projeto é de uso livre para fins educacionais e pode ser adaptado conforme necessário.
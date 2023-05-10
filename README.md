# Descrição 📝
Esse script em Powershell instala e configura o ambiente (para uso no dia-a-dia e para desenvolvimento) em um computador Windows e remove o aplicativo OneDrive.

# Pré-requisitos ▶
Antes de executar este script, siga os seguintes passos:

1 - Abra o PowerShell como administrador e execute: "Set-ExecutionPolicy Unrestricted -Force". Isso permitirá a execução de scripts em sua máquina.

2 - Atualize o seu Windows para a última versão antes de executar. Isso é para garantir uma instalação sem erros, pois alguns programas falharão se o Windows não estiver atualizado.

# Tarefas Realizadas ✍
O script realizará as seguintes tarefas:

- Instalar o gerenciador de pacotes Chocolatey;
- Instalar ambientes de desenvolvimento;
- Instalar e selecionar uma versão do Node.js;
- Instalar programas usuais;
- Desinstalar o OneDrive;
- Renomear o nome do computador.

Obs: Antes de executar o script, leia atentamente as instruções acima. Certifique-se de que o seu sistema atenda aos pré-requisitos e faça backup de seus arquivos importantes antes de iniciar a instalação.
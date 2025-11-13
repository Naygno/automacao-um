#!/bin/bash
################################################################################
# Nome: automatizacao-um
#
# Descrição: Script que automatiza algumas tarefas rotineiras no Ubuntu Serve
# como atualização de pacotes, criação de usuários e outras disponívies no menu
# de opções.
# 
# Autor: Naygno B. Noia
#
# Data: 12/11/2025
################################################################################
	
p=0 # O objetivo desta variável é de informa se o usuário está acessando novamente o menu de opções.

while true; do
	echo
	echo "========= Automações Básicas (I) ========="
	echo " Opções:"
	echo "  1) Atualizar os pacotes do Sistema"
	echo "  2) Renomear os arquivos"
	echo "  3) Criar novo usuário"
	echo "  4) Monitorar disco"
	echo "  5) Fazer backup"
	echo "  6) Sair"
	echo "=========================================="
	echo
	

	if [[ $p -eq 0 ]]; then

		read -e -p "Excolha uma opção [1-6]: " opcao # Adicinei o comando -e para disponibilizar a navegabilidade com as setas e evitar caracteres estranhos como ^[[A que atrapalham...

	else
		read -e -p "Excolha outra opção [1-6]: " opcao # Adicinei o comando -e para disponibilizar a navegabilidade com as setas e evitar caracteres estranhos como ^[[A que atrapalham...
	fi


	if [[ "$opcao" =~ ^[a-zA-Z07-9_-]+$ ]]; then # Verifica se o usúario digitou alguma instrução não disponibilizado no menu.
		
		echo "Esta instrução não é uma opção válida."
		echo "So long, thanks for all the fish!"
		break
	else
		
		case $opcao in

			'1' )
				echo "Esta opção irá atualizar todos os pacotes do sistema."
				read -e -p "Para prosseguir digite (S)im ou (N)ão para desistir: " atualizar

				case "$atualizar" in

					'S'|'s'|'sim'|'Sim' )

							retorno=$(id -u) # Captura o valor do id do usuário se for 0 é super usuário caso contrário não.
							
							if [[ $retorno -eq 0 ]]; then
								
								p=1
								while true; do

									echo
									echo "==== Atualizações ===="
									echo "Opções:"
									echo " 1) Atualizar Lista"
									echo " 2) Atualisar Pacotes"
									echo " 3) Limpar (opcional)"
									echo " 4) Finaliza"
									echo "======================"
									echo 
									read -e -p "Indique a opção: " opcao_atualizar

									case $opcao_atualizar in

										'1' )
											apt update

											if [[ $? -eq 0 ]]; then
												echo "Atualização ocorreu com sucesso!"
											else
												echo "Ocorreram erros nesta operação. Saia do script e tente executar esta operação manualmente."
											fi

											continue
											;;

										'2' )
											apt upgrade

											if [[ $? -eq 0 ]]; then
												echo "Operação realizada com sucesso!"
											else
												echo "Ocorreram erros nesta operação. Saia do script e tente executar esta operação manualmente."
											fi

											continue
											;;

										'3' )
											apt autoremove

											if [[ $? -eq 0 ]]; then
												echo "Operação realizada com sucesso!"
											else
												echo "Ocorreram erros nesta operação. Sais do script e tente realizar esta operação manualmente."
											fi

											continue
											;;
										'4' )
											echo "Saindo daa operações de atualização..."
											break
											;;
										* )
											echo "Esta instrução não é uma opção válida."
											echo "So long, thanks for all the fish!"
											continue
									esac
								done
							else
							       echo "Você não tem permissão para realizar esta operação."
							       echo "Execute este script com permissão de super usuário."
						       			       

							fi
						;;

					'N'|'n'|'Não'|'não'|'Nao'|'nao' )

						echo "Saindo da opção atual..."
						p=1
						continue
						;;

					* )
						echo "Instrução inválida."
						echo "So long, and thanks for all the fish!"
						break
				esac
				;;

			'2' ) 
			
				echo "Esta opção renomeia todos os arquivos do direório com prefixo ou sufixo."
				read -e -p "Para prosseguir digite (S)im ou (N)ão para desistir: " renomear

				case "$renomear" in

					'S'|'s'|'Sim'|'sim' )
						
						p=1
						read -e -p "Digite (P)refixo ou (S)ufixo: " pOUs
						
						case "$pOUs" in

							'P'|'p' )

								read -e -p "Indique o diretório de origem dos arquivos: " diretorio
								read -e -p "Indique o prefixo: " prefixo

								ls "$diretorio" > /dev/null 2>&1
								
								if [[ $? -eq 0 ]]; then
									i=1
									for arquivo in "$diretorio"/*; do
										if [[ ! "${arquivo%.*}" == "${arquivo##*.}" ]]; then # Texta se o arquivo tem extensão, caso tenha, passa no teste. Este teste evita de tentar renomear diretório.
											if [[ -f "$arquivo" && ! -x "$arquivo" ]]; then # Verifica se é uma arquivo comum e não executável, para impedir que tente renomear, por exemplo, a si mesmo...

												mv "$arquivo" "$diretorio/${prefixo}_$i.${arquivo##*.}" # Renomeia o arquivo preservando a extensão.
												i=$((i+1)) # Enumera os arquivos.
											fi
										fi
									done
									
									contador=0
									
									for arquivo in "$diretorio"/$prefixo_*; do  # Lista todos os arquivos com o prefixo dado para entrarem no teste seguinte.
										if [[ -f "$arquivo" ]]; then # Verifica se há algum arquivo corresponde com o padrão esperado.
											contador=$((contador+1))
										fi
										
									done
									
									if ! [[ $contador -eq 0 ]]; then
										echo "Operação realizada com sucesso!"
									else
										echo "Nenhuma mudança realizada."
									fi
								else
									echo "Nenhum arquivo encontrado no diretório $diretorio."
								fi				
								;;

							'S'|'s' )

								read -e -p "Indique o diretório dos arquivos: " diretorio
								read -e -p "Indique o sufixo: " sufixo
									
								ls "$diretorio" > /dev/null 2>&1

								if [[ $? -eq 0 ]]; then
									k=0
									for arquivo in "$diretorio"/*; do
										if [[ ! "${arquivo%.*}" == "${arquivo##*.}" ]]; then # Texta se o arquivo tem extensão, caso tenha, passa no teste. Este teste evita de tentar renomear diretório.
											k=$((k+1)) # Conta quantos arquivos haviam no diretório antes da aplicação do novo sufixo.
											if [[ "${arquivo##*.}" != "$sufixo" ]]; then
												mv "$arquivo" "${arquivo%.*}.$sufixo"
											fi
										fi
									done
									
									l=0
									for arquivo in "$diretorio"/*; do
										
										if [[ ! "${arquivo%.*}" == "${arquivo##*.}" ]]; then # Testa se o arquivo tem extensão, caso tenha, passa no teste. Este teste evita de tentar renomear diretório.
											if [[ "${arquivo##*.}" == "$sufixo" ]]; then
												l=$((l+1)) # Conta arquivo com o novo sufixo
											fi
										fi
									done

									if [[ $l -eq $k ]]; then
										
										echo "Operação realizada com sucesso! Pois $l = $k"

									elif [[ $l -lt $k && $l -gt 0 ]]; then

										echo "Operação realizada parcialmente. Pois apenas $l dos $k arquivos existentes no diretório foram atualizados."
									fi
								else
									echo "Nenhum arquivo encontrado no diretório $diretorio."
								fi
								
								;;

							* )
								echo "Instrução inválida."
								echo "So long, and thanks for all the fish!"
								break
						esac
						;;

					'N'|'n'|'Não'|'não'|'Nao'|'nao' )

						echo "Saindo da opção atual..."
						p=1
						continue
						;;

					* )

						echo "Instrução inválida."
						echo "So long, thanks for all the fish!"
						break
				esac
				;;

			'3' )

				echo "Esta opção cria um novo usuário no Sistema atual."
				read -e -p "Para prosseguir digite (S)im ou (N)ão para desistir: " criar

				case "$criar" in

					'S'|'s'|'Sim'|'sim' )
						
						if [[ $(id -u) -eq 0 ]]; then # Verifica se tem privilégio de super usuário (se rotorna 0).
							read -e -p ""
							

						else
							echo "Você não tem permissão para realizar esta operação."
							echo "Execute este script com permissão de super usuário."
						fi
						;;

					'N'|'n'|'Não'|'não'|'Nao'|'nao' )

						echo "Saindo da opção atual..."
						p=1
						continue
						;;

					*)

						echo "Intrução inválida."
						echo "So long, and thanks for all the fish!"
						break
				esac
				;;
			'4' )

				echo "Esta opção monitora o espaço em uso no disco do sistema utilizando o comando 'df'."
				read -e -p "Para prosseguir digite (S)im ou (N)ão para desistir: " monitorar

				case "$monitorar" in

					'S'|'s'|'Sim'|'sim' )
					
						# Escrever instruções
						;;

					'N'|'n'|'Não'|'não'|'Nao'|'nao' )

						echo "Saindo da opção atual..."
						p=1
						continue
						;;
					* )

						echo "Intrução inválida."
						echo "So long, thanks for all the fish!"
						break
				esac
				;;
			'5' )
				echo "Esta opção realiza backup de um diretório para um"
			        echo "local específico utiliando a compressão 'gzip'."
				read -e -p "Para prosseguir digite (S)im ou (N)ão para desistir: "  compressao

				case "$compressao" in

					'S'|'s'|'Sim'|'sim' )
					
						# Escrever instruções
						;;

					'N'|'n'|'Não'|'não'|'Nao'|'nao' )

						echo "Saindo da opção atual..."
						p=1
						continue
						;;
					* )

						echo "Intrução inválida."
						echo "So long, thanks for all the fish!"
						break
				esac
				;;
			'6' )

				echo "Encerrando o script..."
				exit 1
				;;


			* )

				echo "Instrução inválida."
				echo "So long, thanks for all the fish!"
				break

		esac
	fi

done


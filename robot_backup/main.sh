#!/usr/bin/env sh

echo  "\nOlá! Bem-vindo, eu sou um script para idealizar backup\n"

while true; do
    read -p "Preciso que você coloque a localização do diretório que iremos fazer backup: " dir
    echo "Essa foi a localização fornecida: ${dir}"

    if [ -z "$dir" ]; then
        clear
        echo  "\nOlá! Bem-vindo, eu sou um script para idealizar backup"
        echo  "\nPor favor! Coloque a localização correta do diretório."
    else
        while true; do
            read -p "A localização está correta? [s/n] " input_resposta
            resposta=$(echo "$input_resposta" | tr '[:upper:]' '[:lower:]')

            if [ "$resposta" = "s" ]; then
                echo "OKAY ..."
                while true; do
                    clear
                    echo "\n2ª Etapa:"
                    read -p "Agora preciso da localização do diretório NA QUAL iremos armazenar o backup: " dir_storage
                    if [ -z "$dir_storage" ]; then
                        echo "Por favor! Coloque a localização correta do 2º diretório."
                    else
                        while true; do
                            read -p "A localização está correta? [s/n] " inpunt_resposta2
                            resposta2=$(echo "$inpunt_resposta2" | tr '[:upper:]' '[:lower:]')

                            if [ "$resposta2" = "s" ]; then
                                echo  "\n2º OKAY ...\n\nPRESTE ATENÇÃO\n\nEscolha o formato do backup:\n[0] Enviar todo o diretório\n[1] Enviar apenas arquivos com a extensão (Ex:.pdf;.py;.sh)\n[2] Enviar Apenas um arquivo\n[3] Cancelar o backup\n"
                                while true; do
                                    read -p "Sua escolha: " escolha
                                    if [ "$escolha" = "3" ]; then
                                        echo "See you later!"
                                        break
                                    elif [ "$escolha" = "2" ]; then
                                        data_atual=$(date +"%Y-%m-%d")
                                        log_file="log_Backup_${data_atual}.txt"
                                        echo "----------------------------------------------\n BACKUP DE ${dir}\n\nDatação:${data_atual}\nUsuário:$USER\n" >> "$log_file"
                                        ls -a "$dir"
                                        echo ""
                                        read -p "Escreva o nome do arquivo: " file
                                        dir_file="${dir}/${file}"
                                        mv "$dir_file" "$dir_storage"
                                        echo "Arquivo movido com sucesso!"
                                        echo "----------------------------------------------" >> "$log_file"
                                        cp "$log_file" "$dir_storage"
										break
                                    elif [ "$escolha" = "1" ]; then
                                        data_atual=$(date +"%Y-%m-%d")
                                        log_file="log_Backup_${data_atual}.txt"
                                        echo "----------------------------------------------\n BACKUP DE ${dir}\n\n" >> "$log_file"
                                        ls -a "$dir"
                                        echo ""
                                        read -p "Escreva a extensão do arquivo: " file
                                        dir_file="${dir}/*${file}"
                                        mv $dir_file "$dir_storage"
                                        echo "Todos os arquivos da extensão ${file} movidos com sucesso!\n\nDatação:${data_atual}\nUsuário:$USER\n----------------------------------------------" >> "$log_file"
                                        cp "$log_file" "$dir_storage"
										break
                                    elif [ "$escolha" = "0" ]; then
                                        data_atual=$(date +"%Y-%m-%d")
                                        log_file="log_Backup_${data_atual}.txt"
                                        echo "----------------------------------------------\n BACKUP DE ${dir}\n\n" >> "$log_file"
                                        mv "$dir" "$dir_storage"
                                        echo "${dir} movido com sucesso!\n\nDatação:${data_atual}\nUsuário:$USER\n----------------------------------------------" >> "$log_file"
                                        cp "$log_file" "$dir_storage"
										break
                                    else
                                        echo "Escolha inválida! Tente novamente.\n"
                                    fi
                                done
                            elif [ "$resposta2" = "n" ]; then
                                echo "2º Ohhh não..."
                                break 2
                            else
                                clear
                                echo "Opção inválida. Digite 's' para SIM ou 'n' para NÃO."
                            fi
                        done
                    fi
                done
                break
            elif [ "$resposta" = "n" ]; then
                echo  "\nOhhh não..."
            else
                clear
                echo "Opção inválida. Digite 's' para SIM ou 'n' para NÃO."
            fi
        done
		break
    fi
done

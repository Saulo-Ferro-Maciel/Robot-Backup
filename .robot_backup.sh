#!/usr/bin/env sh

while true; do
    clear 
    echo "\nOlá! Bem-vindo, eu sou um script para idealizar backup\nVamos começar o backup em até 01 minuto:"
    if [ "$(date +%w)" -eq 5 ]; then
        DEST_DIR="/run/user/1000/gvfs/google-drive:host=gmail.com,user=sauloferromaciel/0ACz5kR-0HvEQUk9PVA"
        data_atual=$(date +"%Y-%m-%d")
        USER=$(whoami)
        
        dir_download="/home/$USER/Downloads/"
        dir_documentos="/home/$USER/Documentos/"
        dir_imagens="/home/$USER/Imagens/"
        dir_video="/home/$USER/Vídeos/"
        dir_backup="/home/$USER/Backup/"

        log_file="log_Backup_${data_atual}.txt"
        
        echo "----------------------------------------------" > "$log_file"
        echo "BACKUP DE $dir_backup" >> "$log_file"
        echo "Datação: ${data_atual}" >> "$log_file"
        echo "Usuário: $USER" >> "$log_file"
        echo "----------------------------------------------" >> "$log_file"

        mkdir -p "$dir_backup"
        cp -r "$dir_download" "$dir_backup"
        cp -r "$dir_documentos" "$dir_backup"
        cp -r "$dir_imagens" "$dir_backup"
        cp -r "$dir_video" "$dir_backup"

        echo "cp -r $dir_download $dir_backup" >> "$log_file"
        echo "cp -r $dir_documentos $dir_backup" >> "$log_file"
        echo "cp -r $dir_imagens $dir_backup" >> "$log_file"
        echo "cp -r $dir_video $dir_backup" >> "$log_file"

        echo "\n\nDatação:${data_atual}\nUsuário:$USER\n----------------------------------------------" >> "$log_file"
        cp "$log_file" "$dir_backup"
        zip -r "backup.zip" "$dir_backup"
        mv "backup.zip" "$DEST_DIR"
        rm -r "$dir_backup" "$log_file" "backup.zip"
        clear

        echo "\nBackup idealizado!\nDatação: ${data_atual}\nUsuário: $USER"

    else
        echo "Hoje não é sexta, o backup vai ser semi-automático\nOlá! Bem-vindo, eu sou um script para idealizar backup\n"

        while true; do
            read -p "Coloque a localização do diretório que iremos fazer backup: " dir
            echo "Essa foi a localização fornecida: ${dir}"

            if [ -z "$dir" ]; then
                clear
                echo "\nOlá! Bem-vindo, eu sou um script para idealizar backup"
                echo "\nPor favor! Coloque a localização correta do diretório."
            else
                if [ "$dir" = "user" ]; then
                    while true; do
                        echo "\n2ª Etapa:"
                        read -p "Agora preciso da localização do diretório NA QUAL iremos armazenar o backup: " dir_storage
                        if [ -z "$dir_storage" ]; then
                            echo "Por favor! Coloque a localização correta do 2º diretório."
                        elif [ "$dir_storage" = "cloud" ]; then
                            while true; do
                                echo ""
                                read -p "A localização está correta? [s/n] " input_resposta2
                                resposta2=$(echo "$input_resposta2" | tr '[:upper:]' '[:lower:]')

                                if [ "$resposta2" = "s" ]; then
                                    read -p "Deseja fazer uma compactação (.ZIP)? [s/n] " input_resposta
                                    resposta=$(echo "$input_resposta" | tr '[:upper:]' '[:lower:]')
                                    echo "\n2º OKAY ...\n\nPRESTE ATENÇÃO\n\nEscolha o formato do backup:\n[0] Enviar todo o diretório\n[1] Cancelar o backup\n"
                                    dir_storage=$DEST_DIR
                                    echo ""
                                    if [ "$resposta" = "s" ]; then
                                        while true; do
                                            read -p "Sua escolha: " escolha
                                            dir_download="/home/$USER/Downloads/"
                                            dir_documentos="/home/$USER/Documentos/"
                                            dir_imagens="/home/$USER/Imagens/"
                                            dir_video="/home/$USER/Vídeos/"
                                            dir_backup="/home/$USER/Backup/"
                                            if [ "$escolha" = "1" ]; then
                                                echo "See you later!"
                                                break
                                            elif [ "$escolha" = "0" ]; then
                                                data_atual=$(date +"%Y-%m-%d")
                                                log_file="log_Backup_${data_atual}.txt"
                                                echo "----------------------------------------------\nBACKUP DE ${dir}" >> "$log_file"
                                                mkdir -p "$dir_backup"
                                                echo "\nmkdir Backup" >> "$log_file"
                                                cp -r "$dir_download" "$dir_backup"
                                                cp -r "$dir_documentos" "$dir_backup"
                                                cp -r "$dir_imagens" "$dir_backup"
                                                cp -r "$dir_video" "$dir_backup"
                                                echo "\ncp -r "$dir_download" "$dir_backup"" >> "$log_file"
                                                echo "cp -r "$dir_documentos" "$dir_backup"" >> "$log_file"
                                                echo "cp -r "$dir_imagens" "$dir_backup"" >> "$log_file"
                                                echo "cp -r "$dir_video" "$dir_backup"" >> "$log_file"
                                                echo "\n\nDatação:${data_atual}\nUsuário:$USER\n----------------------------------------------" >> "$log_file"
                                                cp "$log_file" "$dir_storage"
                                                zip -r "backup.zip" "$dir_backup"
                                                mv "backup.zip" "$DEST_DIR"
                                                clear
                                                rm -r "$dir_backup" "$log_file" "backup.zip"
                                                clear
                                                echo "\nBackup idealizado!\nDatação: ${data_atual} \nUsuário:$USER"     
                                                break
                                            else
                                                echo "Escolha inválida! Tente novamente.\n"
                                            fi
                                        done
                                        break
                                    else
                                        while true; do
                                            read -p "Sua escolha: " escolha
                                            dir_download="/home/$USER/Downloads/"
                                            dir_documentos="/home/$USER/Documentos/"
                                            dir_imagens="/home/$USER/Imagens/"
                                            dir_video="/home/$USER/Vídeos/"
                                            dir_backup="/home/$USER/Backup/"
                                            if [ "$escolha" = "1" ]; then
                                                echo "See you later!"
                                                break
                                            elif [ "$escolha" = "0" ]; then
                                                data_atual=$(date +"%Y-%m-%d")
                                                log_file="log_Backup_${data_atual}.txt"
                                                echo "----------------------------------------------\nBACKUP DE ${dir}" >> "$log_file"
                                                mkdir -p "$dir_backup"
                                                echo "\nmkdir Backup" >> "$log_file"
                                                cp -r "$dir_download" "$dir_backup"
                                                cp -r "$dir_documentos" "$dir_backup"
                                                cp -r "$dir_imagens" "$dir_backup"
                                                cp -r "$dir_video" "$dir_backup"
                                                echo "\ncp -r "$dir_download" "$dir_backup"" >> "$log_file"
                                                echo "cp -r "$dir_documentos" "$dir_backup"" >> "$log_file"
                                                echo "cp -r "$dir_imagens" "$dir_backup"" >> "$log_file"
                                                echo "cp -r "$dir_video" "$dir_backup"" >> "$log_file"
                                                echo "\n\nDatação:${data_atual}\nUsuário:$USER\n----------------------------------------------" >> "$log_file"
                                                cp "$log_file" "$dir_storage"
                                                clear
                                                mv "$dir_backup" "$dir_storage"
                                                rm -r "$dir_backup" "$log_file"
                                                clear
                                                echo "\nBackup idealizado!\nDatação: ${data_atual} \nUsuário:$USER"     
                                                break
                                            else
                                                echo "Escolha inválida! Tente novamente.\n"
                                            fi
                                        done
                                        break
                                    fi
                                else
                                    echo "Localização incorreta! Por favor, informe o diretório corretamente.\n"
                                fi
                            done
                        else
                            while true; do
                                echo ""
                                read -p "A localização está correta? [s/n] " input_resposta2
                                resposta2=$(echo "$input_resposta2" | tr '[:upper:]' '[:lower:]')

                                if [ "$resposta2" = "s" ]; then
                                    echo "\n2º OKAY ...\n\nPRESTE ATENÇÃO\n\nEscolha o formato do backup:\n[0] Enviar todo o diretório\n[1] Cancelar o backup\n"
                                    while true; do
                                        read -p "Sua escolha: " escolha
                                        dir_download="/home/$USER/Downloads/"
                                        dir_documentos="/home/$USER/Documentos/"
                                        dir_imagens="/home/$USER/Imagens/"
                                        dir_video="/home/$USER/Vídeos/"
                                        dir_backup="/home/$USER/Backup/"
                                        if [ "$escolha" = "1" ]; then
                                            echo "See you later!"
                                            break
                                        elif [ "$escolha" = "0" ]; then
                                            data_atual=$(date +"%Y-%m-%d")
                                            log_file="log_Backup_${data_atual}.txt"
                                            echo "----------------------------------------------\nBACKUP DE ${dir}" >> "$log_file"
                                            mkdir -p "$dir_backup"
                                            echo "\nmkdir Backup" >> "$log_file"
                                            cp -r "$dir_download" "$dir_backup"
                                            cp -r "$dir_documentos" "$dir_backup"
                                            cp -r "$dir_imagens" "$dir_backup"
                                            cp -r "$dir_video" "$dir_backup"
                                            echo "\ncp -r "$dir_download" "$dir_backup"" >> "$log_file"
                                            echo "cp -r "$dir_documentos" "$dir_backup"" >> "$log_file"
                                            echo "cp -r "$dir_imagens" "$dir_backup"" >> "$log_file"
                                            echo "cp -r "$dir_video" "$dir_backup"" >> "$log_file"
                                            echo "\n\nDatação:${data_atual}\nUsuário:$USER\n----------------------------------------------" >> "$log_file"
                                            cp "$log_file" "$dir_storage"
                                            zip -r "backup.zip" "$dir_backup"
                                            mv "backup.zip" "$dir_storage"
                                            clear
                                            rm -r "$dir_backup" "$log_file" "backup.zip"
                                            clear
                                            echo "\nBackup idealizado!\nDatação: ${data_atual} \nUsuário:$USER"     
                                            break
                                        else
                                            echo "Escolha inválida! Tente novamente.\n"
                                        fi
                                    done
                                    break
                                else
                                    echo "Localização incorreta! Por favor, informe o diretório corretamente.\n"
                                fi
                            done

                        fi
                        break
                    done
                    break
                elif cd "$dir"; then
                    echo "\nDiretório encontrado e acessível!"

                    while true; do
                        read -p "A localização está correta? [s/n] " input_resposta
                        resposta=$(echo "$input_resposta" | tr '[:upper:]' '[:lower:]')

                        if [ "$resposta" = "s" ]; then
                            clear
                            echo "OKAY ..."
                            while true; do
                                echo "\n2ª Etapa:"
                                read -p "Agora preciso da localização do diretório NA QUAL iremos armazenar o backup: " dir_storage
                                if [ -z "$dir_storage" ]; then
                                    echo "Por favor! Coloque a localização correta do 2º diretório."
                                else
                                    while true; do
                                        read -p "A localização está correta? [s/n] " input_resposta2
                                        resposta2=$(echo "$input_resposta2" | tr '[:upper:]' '[:lower:]')

                                        if [ "$resposta2" = "s" ]; then
                                            echo "\n2º OKAY ...\n\nPRESTE ATENÇÃO\n\nEscolha o formato do backup:\n[0] Enviar todo o diretório\n[1] Enviar apenas arquivos com a extensão (Ex:.pdf;.py;.sh)\n[2] Enviar Apenas um arquivo\n[3] Cancelar o backup\n"
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
                                                    zip -r "backup.zip" "$file"
                                                    mv "backup.zip" "$dir_storage"
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
                                                    read -p "Escreva a extensão do arquivo: " file_ext
                                                    dir_file="${dir}/*${file_ext}"
                                                    zip -r "backup.zip" $dir_file
                                                    mv "backup.zip" "$dir_storage"
                                                    echo "Todos os arquivos da extensão ${file_ext} movidos com sucesso!\n\nDatação:${data_atual}\nUsuário:$USER\n----------------------------------------------" >> "$log_file"
                                                    cp "$log_file" "$dir_storage"
                                                    break
                                                elif [ "$escolha" = "0" ]; then
                                                    data_atual=$(date +"%Y-%m-%d")
                                                    log_file="log_Backup_${data_atual}.txt"
                                                    echo "----------------------------------------------\n BACKUP DE ${dir}\n\n"
                                                    zip -r "backup.zip" "$dir"
                                                    mv "backup.zip" "$dir_storage"
                                                    echo "${dir} movido com sucesso!\n\nDatação:${data_atual}\nUsuário:$USER\n----------------------------------------------" >> "$log_file"
                                                    cp "$log_file" "$dir_storage"
                                                    break
                                                else
                                                    echo "Escolha inválida! Tente novamente.\n"
                                                fi
                                            done
                                            break
                                        else
                                            echo "Localização incorreta! Por favor, informe o diretório corretamente.\n"
                                        fi
                                    done

                                fi
                                break
                            done
                            break
                        elif [ "$resposta" = "n" ]; then
                            echo "\nOhhh não..."
                            break
                        else
                            clear
                            echo "Opção inválida. Digite 's' para SIM ou 'n' para NÃO."
                        fi
                    done
                    break
                else
                    echo "Erro: Diretório não encontrado ou não acessível."
                fi
            fi
        done                                                                                
    fi
    echo ""
    read -p "Deseja continuar com mais backups? [s/n] " dir3
    dir3=$(echo "$dir3" | tr '[:upper:]' '[:lower:]')

    if [ "$dir3" = 'n' ]; then
        clear
        echo "\nEncerrando ...\nSee you later, cowboy!"
        break
    fi
done

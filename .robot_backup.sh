#!/usr/bin/env sh

while true; do
    clear 
    echo "\nOlá! Bem-vindo, eu sou um script para idealizar backup\nVamos começar o backup em até 01 minuto:"
    USER=$(whoami)

    echo "O backup foi convertido para modo semi-automático (sem execução automática às sextas).\nOlá! Bem-vindo, eu sou um script para idealizar backup\n"

    while true; do
            read -p "Pressione Enter para usar o padrão (compactar todas as pastas filhas de /home/$USER), ou informe um diretório para backup: " dir
            if [ -z "$dir" ]; then
                read -p "Onde iremos armazenar o backup? [Enter para /home/$USER/Backup] " dir_storage
                dir_storage=${dir_storage:-"/home/$USER/Backup"}
                data_atual=$(date +"%Y-%m-%d")
                log_file="log_Backup_${data_atual}.txt"
                echo "----------------------------------------------" > "$log_file"
                echo "BACKUP PADRÃO: coleções do usuário (Downloads, Documentos, Imagens, Músicas, Desktop, Vídeos, Fotos)" >> "$log_file"
                echo "Datação: ${data_atual}" >> "$log_file"
                echo "Usuário: $USER" >> "$log_file"
                echo "----------------------------------------------" >> "$log_file"
                mkdir -p "$dir_storage"

                tmpdir=$(mktemp -d "/tmp/backup_${USER}_${data_atual}_XXXX") || tmpdir="/tmp/backup_${USER}_${data_atual}"

                # Lista de pastas a incluir (nomes comuns em pt-BR e variações)
                dirs_to_include="Downloads Documentos Imagens Fotos Musicas Músicas Vídeos Videos 'Área de Trabalho' Desktop"

                found=0
                for name in $dirs_to_include; do
                    # Remover aspas simples se houver
                    name=$(echo "$name" | sed "s/'//g")
                    src="/home/$USER/$name"
                    if [ -d "$src" ]; then
                        cp -a "$src" "$tmpdir/" 2>/dev/null || true
                        echo "$src" >> "$log_file"
                        found=1
                    fi
                done

                if [ "$found" -eq 0 ]; then
                    # Nenhuma pasta padrão encontrada: incluir todo o $HOME
                    echo "Nenhuma pasta padrão encontrada — incluindo todo o $HOME" >> "$log_file"
                    cp -a "/home/$USER" "$tmpdir/home_${USER}" 2>/dev/null || true
                fi

                zipname="backup_${data_atual}.zip"
                (cd "$tmpdir" && zip -r "$zipname" . >/dev/null 2>&1) || zip -r "$zipname" "$tmpdir" >/dev/null 2>&1
                mv "$tmpdir/$zipname" "$dir_storage/" 2>/dev/null || mv "$zipname" "$dir_storage/" 2>/dev/null
                cp "$log_file" "$dir_storage" 2>/dev/null
                rm -rf "$tmpdir"
                rm -f "$log_file"
                echo "\nBackup padrão concluído: $dir_storage/$zipname"
                # Após completar o backup padrão, sair do loop interno para perguntar se deseja continuar
                break
            else
                echo "Essa foi a localização fornecida: ${dir}"
            fi

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
                                    # Suporte a 'cloud' não disponível — usar backup local por padrão
                                    dir_storage="/home/$USER/Backup"
                                    echo "Aviso: opção 'cloud' não suportada - usando $dir_storage por padrão."
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
    echo ""
    read -p "Deseja continuar com mais backups? [s/n] " dir3
    dir3=$(echo "$dir3" | tr '[:upper:]' '[:lower:]')

    if [ "$dir3" = 'n' ]; then
        clear
        echo "\nEncerrando ...\nSee you later, cowboy!"
        break
    fi
done

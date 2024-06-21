# brew install sschlesier/csvutils/csvquote

file_sheet2="sheet2.csv"
unspsc_folder="real_data"
files=($(ls -l $unspsc_folder| awk '{print $9}'))

# get old code and new code mapping
array1=()
array2=()

while IFS=, read -r col1 col2 col3 col4
do
    array1+=("$col1")
    array2+=("$col3")
done < $file_sheet2


for file in "${files[@]}"; do
    start_time=$(date +%s)
    echo "Processing $file"
    for i in "${array1[@]}"; do
        # filter out the line which is not to be updated
        # echo "filter out line with code $i in $file"
        csvquote $unspsc_folder/$file | awk -F',' -v param="$i" '
        {
            # 获取最后一列的值
            last_col = $NF
            # 移除最后一列的行首和行尾的引号
            gsub(/^"|"$/, "", last_col)
            # 检查最后一列的值是否等于参数
            if (last_col == param) {
                # 使用csvquote的unquote功能输出行
                for (i = 1; i <= NF; i++) {
                    if (i > 1) printf(",")
                    printf("%s", $i)
                }
                printf("\n")
            }
        }' | csvquote -u >> output/$file
    done

    for i in "${!array1[@]}"; do
        code=${array1[i]}
        newCode=${array2[i]}
        # echo "Replace old code $code with new code $newCode in $file"
        gsed -i 's/,"'$code'"/,"'$newCode'"/' output/$file
    done
    end_time=$(date +%s)
    execution_time=$((end_time - start_time))
    echo "Done processing $file, time elapsed: $execution_time s\n"
done

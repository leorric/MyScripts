#!/bin/bash

echo -n "Please input system role -> "
read system_role_value

echo -n "Please input external ID -> "
read external_id_value

echo -n "Please input PPMS ID -> "
read ppms_id_value

echo -n "Please input system ID -> "
read system_id_value

echo -n "Please input installation number -> "
read install_num_value

echo -n "Please input software class -> "
read software_class_value

echo -n "Please input system role of last tenant -> "
read last_role

template_file="template"
temp_file="temp"
cp $template_file $temp_file

file_root_folder="/Users/I335512/code/uberbot"
file_relative_path="/common/lib-java-core/src/main/resources/etc/config/destinations-configmap.yaml"
file_absolute_path=$file_root_folder$file_relative_path

external_id="FF_MOCK_EXTERNAL_ID"
ppms_id="FF_MOCK_PPMS"
system_id="FF_MOCK_SYSTEM_ID"
system_role="FF_MOCK_SYSTEM_ROLE"
install_num="FF_MOCK_INSTALLATION_NUMBER"
software_class="FF_MOCK_SWCLASS"

replace_property_value() {
	property_name=$1
	property_new_value=$2
   	lineNo=$(sed -n "/$property_name/=" $temp_file)
	((lineNo++))
	gsed -i "${lineNo}d" $temp_file
	gsed -i "${lineNo}s/^/        value: \"${property_new_value}\"\n/" $temp_file

}

gsed -i "1s/SYSTEM_ROLE:/$system_role_value:/" $temp_file
replace_property_value $external_id "$external_id_value"
replace_property_value $ppms_id "$ppms_id_value"
replace_property_value $system_id "$system_id_value"
replace_property_value $system_role "$system_role_value"
replace_property_value $install_num "$install_num_value"
replace_property_value $software_class "$software_class_value"

echo "add new tenant to file in lib-java-core"
cat $temp_file >> $file_absolute_path 

echo "add new tenant to files in operations repo"

gsed -i 's/^/          /' $temp_file

last_role=$last_role":"
dev_config_file="/Users/I335512/code/operations/cluster-setup/values-dev/values.yaml";
test_config_file="/Users/I335512/code/operations/cluster-setup/values-test/values.yaml";

lineNum=$(sed -n "/$last_role/=" $dev_config_file)
lineNum=$((lineNum+23))
echo "line:$lineNum"
gsed -i "${lineNum}r $temp_file" $dev_config_file # insert after $lineNum

lineNum=$(sed -n "/$last_role/=" $test_config_file)
lineNum=$((lineNum+23))
echo "line test:$lineNum"
gsed -i "${lineNum}r $temp_file" $test_config_file # insert after $lineNum

rm $temp_file


if [ -e ~/temp ]; 
then
    echo "  ~/temp exist."
else
    echo "  ~/temp non exist."
fi

if [ -e ./file_folder_exist_check.sh ]; 
then
    echo "  file_folder_exist_check.sh exist"
else
    echo "  file_folder_exist_check.sh non exist"
fi
# 直接一次执行setup_opencv.sh不行，半手动半自动的执行
set -e
if [ "$1" ] && [ "$1" != "config_only" ]
  then
    echo "Unknown input argument. Do you mean \"config_only\"?"
    exit 0
fi

opencv_build_file="$( cd "$(dirname "$0")" ; pwd -P )"/third_party/opencv_linux.BUILD
workspace_file="$( cd "$(dirname "$0")" ; pwd -P )"/WORKSPACE

sed -i '/linkopts/a \ \ \ \ \ \ \ \ \"-L/usr/local/lib",' $opencv_build_file
linux_opencv_config=$(grep -n 'linux_opencv' $workspace_file | awk -F  ":" '{print $1}')
path_line=$((linux_opencv_config + 2))
sed -i "$path_line d" $workspace_file
sed -i "$path_line i\    path = \"/usr/local\"," $workspace_file
echo "Done"
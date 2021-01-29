if [ $# -eq 0 ]
then
  echo "usage: $0 root_directory"
  exit 1
fi

root=$1
echo $root

for dir in $root/*/
do
  decade=`basename $dir | cut -c1-4`
  exiftool -overwrite_original_in_place -AllDates="$decade:01:01 11:11:11" $dir*
done

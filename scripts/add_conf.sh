conf_name=$1
RAW_DATA=../rebiber/raw_data
DATA=../rebiber/data
shift
for year in "$@"
do
	# check if raw_data/$conf_name$year.bib exists, if not we might have to concatenate partial files
	if [ ! -f $RAW_DATA/$conf_name$year.bib ]; then
		echo "$RAW_DATA/$conf_name$year.bib does not exist, trying to concatenate partial files:"
		echo $RAW_DATA/${conf_name}${year}_*.bib
		cat $RAW_DATA/${conf_name}${year}_*.bib > $RAW_DATA/$conf_name$year.bib
	fi
	echo "$conf_name-$year"
	python bib2json.py \
	-i $RAW_DATA/$conf_name$year.bib \
	-o $DATA/$conf_name$year.bib.json
	echo "$DATA/$conf_name$year.bib.json" >> bib_list.txt
done

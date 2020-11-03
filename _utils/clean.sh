DIR=`dirname $0`

for f in $(cat $DIR/clean.lst) ; do
  rm "$1/$f"
done
lines=$(cat LICENSE | wc -l)

failures=0
for each in $(find . -type f \( ! -regex '.*/\..*' ! -path "./Godeps/*" -name '*.go' \)); do
  echo "Checking $each for correct license header"
  head -n $lines $each | sed 's/^#//' | diff -qu LICENSE - > /dev/null
  if [ ! "$?" -eq "0" ]; then
    echo "Failed license check on $each"
    return 1
  fi
done


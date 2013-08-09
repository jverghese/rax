# $1: Line no to replace from source string.
# $2: Multiline source string.
# $3: String to replace the line.
function replaceLine() {
  # Print out lines till lineno argument.
  echo "$2" | head -n `expr $1 - 1` >> rax
  totallines=$(echo "$2" | wc -l)
  # Print out dependency lib.
  echo "\n## INLINING ##\n" >> rax
  cat "$3" >> rax
  # Print out rest of file.
  echo "$2" | tail -n `expr $totallines - $1` >> rax
}

rm -f rax
touch rax
# Inline sourced dependencies.
source=$(cat src/rax)
deps=$(echo "$source" | grep '. $libdir')
while read line; do
  lineno=$(echo "$source" | grep -n "$line" |cut -f1 -d:)
  libsrc=$(echo $line | sed 's/\. \$libdir/lib/')
  source=$(replaceLine $lineno "$source" "$libsrc")
done <<< "$deps"

echo "$source" >> rax
chmod +x rax

# $1: Line no to replace from source string.
# $2: Multiline source string.
# $3: String to replace the line.
function replaceLine() {
  # Print out lines till lineno argument.
  echo "$2" | head -n `expr $1 - 1`
  totallines=$(echo "$2" | wc -l)
  # Print out dependency lib.
  echo "\n## INLINING ##\n"
  echo "$3"
  # Print out rest of file.
  echo "$2" | tail -n `expr $totallines - $1`
}

# Inline sourced dependencies.
source=$(cat src/rax)
deps=$(echo "$source" | grep '. $libdir')
while read line; do
  lineno=$(echo "$source" | grep -n "$line" |cut -f1 -d:)
  libsrc=$(echo $line | sed 's/\. \$libdir/lib/' | xargs cat)
  source=$(replaceLine $lineno "$source" "$libsrc")
done <<< "$deps"

rm -f rax
echo "$source" >> rax
chmod +x rax

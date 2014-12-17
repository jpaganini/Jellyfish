#! /bin/sh

cd tests
. ./compat.sh
[ -z "$ENABLE_PERL_BINDING" ] && exit 77

LOADPATH="$BUILDDIR/swig/perl5"
K=$($PERL -e 'print(int(rand(16)) + 6)')
$JF count -m $K -s 10M -t $nCPUs -C -o ${pref}.jf
$JF dump ${pref}.jf > ${pref}.dump
$JF histo ${pref}.jf > ${pref}.histo

for i in test_mer_file.t test_hash_counter.t; do
    echo Test $i
    $PERL "-I$LOADPATH/.libs" "-I$LOADPATH" "$SRCDIR/swig/perl5/t/$i" .
done
#!/usr/bin/perl
$pid = fork();
if ($pid == 0) {
    print "Soy el proceso hijon \n";
} else {
    print "Soy el proceso padren \n";
}
print "Fork devolvio: $pid\n";


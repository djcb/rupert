#!/usr/bin/perl -w

## Copyright (C) 2015 Dirk-Jan C. Binnema <djcb@djcbsoftware.nl>
###
### This program is free software; you can redistribute it and/or modify
### it under the terms of the GNU General Public License as published by
### the Free Software Foundation; either version 3 of the License, or
### (at your option) any later version.
###
### This program is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
### GNU General Public License for more details.
###
### You should have received a copy of the GNU General Public License
### along with this program; if not, write to the Free Software Foundation,
### Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

# Explicitly, the above license does _not_ apply to the code generated
# by this.


use String::CamelCase qw(camelize decamelize wordsplit);

my $cc_prefix = $ARGV[0] or die "expecting prefix";
my $cc_name   = $ARGV[1] or die "expecting name";

if (index($cc_name, $cc_prefix) != 0) {
    print "Name must start with prefix\n";
    exit 1;
}
my $base = substr($cc_name, length($cc_prefix));

my $uu_prefix = uc($cc_prefix);
my $uu_base   = uc(decamelize($base));
my $uu_name   = uc(decamelize($cc_prefix) . "_" . decamelize($base));
my $lu_name   = lc($uu_name);

my $file_base = lc($uu_name);
$file_base =~ s/_/-/g;

sub write_output{
    my $tmpl = $_[0] or die "expected: template";
    my $out  = $_[1] or die "expected: output";

    my %repl_hash = (
	'@UU_NAME@'   => $uu_name,
	'@LU_NAME@'   => $lu_name,
	'@UU_PREFIX@' => $uu_prefix,
	'@UU_BASE@'   => $uu_base,
	'@CC_NAME@'   => $cc_name,
	'@FILE_BASE@' => $file_base
	);
    
    open (INPUT, "<", $tmpl)
	or die "can't open $tmpl: $!";
    open (OUTPUT, ">", $out)
	or die "can't open $out: $!";
    
    while (<INPUT>) {
	foreach my $key (keys %repl_hash) {
	    $_ =~ s/$key/$repl_hash{$key}/g;
	}
	print OUTPUT $_;
    }
}

write_output ('g-obj.h.tmpl', $file_base.".h");
write_output ('g-obj.c.tmpl', $file_base.".c");

#!/usr/bin/perl

use strict;
use warnings;
use JSON;

sub count_file_elements{
    my ($lines_in_file, $words_in_file, $chars_in_file) = (0,0,0);
    my ($file_to_read) = @_;
    # Vérification que le fichier n'est pas vide
    if (-z "$file_to_read") {
        die "This is an empty file please give another one.\n";
    }
    # Ouverture du fichier en lecture
    open(opened_file, '<', $file_to_read)
       or die "Can't open $file_to_read: $!\n";
    print("\nFile : $file_to_read opened successfully!\n");
    # Lecture du fichier ligne par ligne
    while(<opened_file>){
        $lines_in_file++;
        $words_in_file += scalar(split(/\s+/, $_));
        # Ajout du -1 pour retirer le comptage du caractère de saut de ligne.
        $chars_in_file += length($_)-1;
    }
    close(opened_file);
    my %hash_result = (nb_lines => $lines_in_file, nb_words => $words_in_file, nb_chars => $chars_in_file);
    return(%hash_result);
}

my $filename = $ARGV[0]
   or die "usage: $0 Give an input file as argument. \n";

#Appel à la fonction qui extrait les nombres de lignes, mots, caractères du fichier.
my %hash_from_file = count_file_elements($filename);

# Génère un objet json résumant les informations de la lecture du fichier.
my $json_from_hash = encode_json \%hash_from_file;
print "\nJSON final object : $json_from_hash\n\n";

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

__END__

# Plain Old Documentation format
=head1 NAME

    my_test.pl

    Programme qui :

        - prend un fichier en entree.
        - compte le nombre de lignes, de mots, de caracteres du fichier.
        - genere un objet json resumant ces informations.
        - est ecrit en Perl.
        - doit prendre en compte les cas d'erreur.


=head1 SYNOPSIS

=head2 PREREQUISITIES

        Ce projet a ete developpe sur Windows Windows 10 Famille version 21H1 en
        utilisant Perl v5.32.1 via Strawberry Perl (https://strawberryperl.com/)
        qui permet d'utiliser Perl sur Windows dans un environement le plus proche
        possible d'un environement perl sous UNIX.
        Utilisation de la librairie JSON version 4.10
            (disponible : https://metacpan.org/pod/JSON)

=head2 EXECUTION

        Voici les instructions pour faire tourner le programme sur votre machine.
        Vous devez ouvrir un terminal et entrer la commande suivante :

            perl my_test.pl <nom du fichier>

        Vous devez donner en entree un fichier contenant du texte pour que le
        programme s'execute.

        Le programme ne s'execute pas si :

            - Aucun fichier n'est fournit en entree
            - Le fichier fournit en entree est vide
            - Le fichier fournit n'a pas les droits de lecture


=head1 RESOURCES

        Voici la liste des ressources exterieures qui ont ete utilisees pour
        realiser ce projet.

        1) Utilisation d'un argument en entree de script perl
        https://stackoverflow.com/questions/54590346/how-to-introduce-a-shell-input-file-as-perl-input-file

        2) Comptage des lignes, mots et nombres de caracteres dans un fichier
        https://stackoverflow.com/questions/782087/how-do-i-count-the-characters-words-and-lines-in-a-file-using-perl/782126#782126


=head1 AUTHOR
        Date du projet : 10/10/2022
        DUBRUNFAUT Lucie

=cut

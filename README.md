# Ce que vous avez

3 fichiers :
 * etc_passwd (informations utilisateurs)
 * etc_group (informations sur les groupes)
 * script.sh (début de script)


# Ce que qui est attendu

Vous devez compléter le fichier script.sh afin qu'il retourne les informations demandées.

Le script doit retourner :
 * Une erreur "not argument found" s'il n'y a pas d'argument
 * La liste des utilisateurs (identifiant + nom d'utilisateur) en fonction du premier argument qui est le nom du groupe
 * La liste des utilisateurs (identifiant + uid) en fonction du premier argument qui est le nom du groupe et le deuxième argument est "uid" uniquement. Si le deuxième argument n'est pas "uid', l'argument n'est pas pris en compte"
 * Une erreur "group toto not found" si le group toto n'éxiste pas


# Sortie attendue

```
  user@machine~:~/bas$ ./script.sh doctolib1

    user informations for doctolib1 user:
    == doctolib3 ==
    username = docto-user3
    login = doctolib3
    ==

  user@machine~:~/bas$ ./script.sh doctolib2

    user informations for doctolib2 user:
    == doctolib1 ==
    username = docto-user1
    login = doctolib1
    ==
    == doctolib14 ==
    username = docto-user14
    login = doctolib14
    ==

```

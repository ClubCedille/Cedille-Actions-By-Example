# Cedille-Actions-By-Example

Bienvenue dans le dépôt `Cedille-Actions-By-Example` ! Ce dépôt a été créé pour fournir aux membres du Club Cedille un exemple de la manière de créer une action personnalisée pour GitHub Actions.

## Structure générale d'une action

Une action GitHub personnalisée typique possède une structure de fichier bien définie qui lui permet de fonctionner correctement. Voici les principaux éléments de cette structure :

- `action.yml` : Le manifeste de l'action qui définit son nom, sa description, son auteur, ses entrées et comment elle doit être exécutée.
  
- `Dockerfile` : Si l'action est basée sur un conteneur, ce fichier contient les instructions pour construire l'image Docker.

- `entrypoint.sh` : Si l'action est basée sur un conteneur, ce script est exécuté lors du démarrage du conteneur Docker. Il contient la logique principale de l'action.

- `src/` : Un dossier optionnel qui contient le code source de l'action, si nécessaire. Cela peut être en n'importe quel langage de programmation, selon ce qui est le mieux adapté à la tâche.

### Exemple de structure de répertoire

Dans notre dépôt, vous trouverez différents dossiers représentant différentes actions. Voici comment ils sont organisés :

KubeSketcher/ \
│ action.yml \
│ Dockerfile \
│ entrypoint.sh \
│ src/ \
│ ... \
│ \
action-2/ # Dossier pour une deuxième action \
│ action.yml \
│ Dockerfile # Si basé sur un conteneur \
│ entrypoint.sh # Si basé sur un conteneur \
│ src/ # Si nécessaire \
│ ... 

## KubeSketcher

L'une de nos actions personnalisées s'appelle `KubeSketcher`. Elle a été conçue pour générer des diagrammes d'architecture des namespaces Kubernetes à partir de manifests en utilisant [k8sviz](https://github.com/mkimuram/k8sviz/tree/0.3.4).

### Détails de l'action

- **Nom:** KubeSketcher
- **Description:** Génère des diagrammes d'architecture des namespaces Kubernetes à partir des manifests en utilisant `k8sviz`.
- **Auteur:** SonOfLope/ClubCedille

### Fonctionnement

L'action examine les fichiers qui ont été modifiés dans une pull request. Si ces fichiers sont des manifests Kubernetes, l'action déterminera les namespaces concernés par les modifications. Elle générera ensuite des diagrammes pour chacun de ces namespaces en utilisant `k8sviz`.






# KubeSketcher

KubeSketcher est une Action GitHub qui génère des diagrammes d'architecture pour les namespaces Kubernetes ayant subi des modifications dans une pull request. Cette action s'appuie sur l'outil [k8sviz](https://github.com/mkimuram/k8sviz/tree/0.3.4) pour créer une représentation visuelle de l'architecture de ces namespaces.

## Description
Lorsqu'une pull request modifie un ou plusieurs fichiers YAML Kubernetes, KubeSketcher détecte ces changements, identifie les namespaces concernés, et génère des diagrammes visuels pour chaque namespace modifié. Ces diagrammes sont ensuite automatiquement postés en commentaires dans la pull request correspondante, fournissant ainsi un retour visuel sur les modifications apportées à l'architecture Kubernetes.

## Entrées

### `kubeconfig` (Obligatoire)
Le contenu de votre `kubeconfig` utilisé pour se connecter au cluster Kubernetes.  
Exemple : `kubeconfig: ${{ secrets.KUBECONFIG }}`
### `BUCKET_URL` (Obligatoire)
L'URL du seau GCP où les images seront téléchargées.
Exemple : `BUCKET_URL: ${{ secrets.BUCKET_URL }}`
### `GCP_SA_KEY` (Obligatoire)
La clé du compte de service utilisée pour l'authentification GCP.
Exemple : `GCP_SA_KEY: ${{ secrets.GCP_SA_KEY }}`

## Sorties

Aucune sortie spécifique n'est renvoyée par cette action. Cependant, elle génère en interne des diagrammes et peut commenter les URL de ces diagrammes sur la PR associée.

## Secrets

- `KUBECONFIG`: Le contenu de votre fichier kubeconfig pour s'authentifier et se connecter à votre cluster Kubernetes.
- `GITHUB_TOKEN`: Ceci est utilisé pour effectuer des requêtes API GitHub authentifiées. Typiquement, `${{ secrets.GITHUB_TOKEN }}` peut être utilisé.

## Variables d'environnement

- `KUBECONFIG`: Chemin vers le fichier kubeconfig. Il est défini en interne par l'action en utilisant l'entrée `kubeconfig` fournie.

## Exemple

Pour utiliser `KubeSketcher` dans votre workflow GitHub Actions, suivez l'exemple fourni :

```yaml
jobs:
  generate-diagrams:
    runs-on: ubuntu-latest
    steps:
    - name: Check out code
      uses: actions/checkout@v2

    - name: Generate Kubernetes diagrams
      uses: ClubCedille/Cedille-Actions-By-Example/kubesketcher
      with:
        kubeconfig: ${{ secrets.KUBECONFIG }}
        BUCKET_URL: ${{ secrets.BUCKET_URL }}
        GCP_SA_KEY: ${{ secrets.GCP_SA_KEY }}
```


#!/bin/sh -l
echo "$KUBECONFIG" > /tmp/kubeconfig.yaml
export KUBECONFIG=/tmp/kubeconfig.yaml

echo "$GCP_SA_KEY" > /tmp/gcp_key.json
gcloud auth activate-service-account --key-file=/tmp/gcp_key.json

CHANGED_FILES=$(git diff-tree --no-commit-id --name-only -r HEAD)

CHANGED_YAMLS=""
for FILE in $CHANGED_FILES; do
    if [[ "$FILE" == *.yaml || "$FILE" == *.yml ]]; then
        CHANGED_YAMLS="$CHANGED_YAMLS $FILE"
    fi
done

if [ -z "$CHANGED_YAMLS" ]; then
    echo "No YAML files detected in the changes."
    exit 0
fi

NAMESPACES=$(find-namespaces $CHANGED_YAMLS)

# Generate diagrams for each namespace
for NS in $NAMESPACES; do
    k8sviz -k /tmp/kubeconfig.yaml -n $NS -t png -o ${NS}_diagram.png
    # Upload image to GCP bucket
    gsutil cp  -a public-read ${NS}_diagram.png $BUCKET_URL/${NS}_diagram.png

    IMAGE_URL="https://storage.googleapis.com/cedille-bucket/${NS}_diagram.png"
    COMMENT_BODY="Diagram for namespace $NS: ![Diagram]($IMAGE_URL)"

    curl -s -H "Authorization: token $GITHUB_TOKEN" \
         -H "Content-Type: application/json" \
         -X POST -d "{ \"body\": \"$COMMENT_BODY\" }" \
         "https://api.github.com/repos/$GITHUB_REPOSITORY/issues/$PR_NUMBER/comments"
done

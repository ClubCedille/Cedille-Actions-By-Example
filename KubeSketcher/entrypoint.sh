#!/bin/sh -l
echo "$INPUT_KUBECONFIG" > /tmp/kubeconfig.yaml
export KUBECONFIG=/tmp/kubeconfig.yaml


CHANGED_FILES=$(git diff-tree --no-commit-id --name-only -r HEAD)

CHANGED_YAMLS=""
for FILE in $CHANGED_FILES; do
    if [[ "$FILE" == *.yaml || "$FILE" == *.yml ]]; then
        CHANGED_YAMLS="$CHANGED_YAMLS $FILE"
    fi
done

NAMESPACES=$(find-namespaces $CHANGED_YAMLS)

# Generate diagrams for each namespace
for NS in $NAMESPACES; do
    k8sviz -k /tmp/kubeconfig.yaml -n $NS -t png -o ${NS}_diagram.png
    # TODO : upload image to a public URL
    IMAGE_URL=$(upload-image ${NS}_diagram.png) 
    COMMENT_BODY="Diagram for namespace $NS: ![Diagram]($IMAGE_URL)"

    curl -s -H "Authorization: token $GITHUB_TOKEN" \
         -H "Content-Type: application/json" \
         -X POST -d "{ \"body\": \"$COMMENT_BODY\" }" \
         "https://api.github.com/repos/$GITHUB_REPOSITORY/issues/$PR_NUMBER/comments"
done

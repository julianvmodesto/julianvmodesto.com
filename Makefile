
bake_image:
	docker build -t gcr.io/julian-modesto/caddy .

push_image:
	docker push gcr.io/julian-modesto/caddy

run: bake_image push_image
	gcloud run deploy julianvmodesto-web \
		--image gcr.io/julian-modesto/caddy \
		--platform managed \
		--region us-central1

deploy: bake_image push_image
	kustomize build | kubectl apply -f -

clean:
	gcloud run revisions list \
		--platform managed \
		--region us-central1 \
		--service julianvmodesto-web \
		--format=json  | \
		jq '.[] | select(.status.conditions[] | select(.type == "Active") | .status == "False") | .metadata.name' -r | \
		xargs -rn 1 gcloud run revisions delete --platform managed --region us-central1 --quiet


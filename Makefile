
bake_image:
	docker build -t gcr.io/julian-modesto/caddy .

push_image:
	docker push gcr.io/julian-modesto/caddy

deploy: bake_image push_image
	kustomize build | kubectl apply -f -


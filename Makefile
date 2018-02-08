
bake_image:
	docker build -t julianvmodesto/caddy .

push_image:
	docker push julianvmodesto/caddy

configmap:
	kubectl create configmap caddyfile --from-file=Caddyfile --dry-run -o yaml \
	  | kubectl apply -f -

deploy: bake_image push_image configmap
	kubectl apply -f kubernetes/ --recursive


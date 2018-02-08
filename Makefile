
bake_image:
	docker build -t julianvmodesto/caddy .

push_image:
	docker push julianvmodesto/caddy

secret:
	kubectl create secret generic cloudflare-warp-cert --from-file=cert.pem -o yaml --dry-run | kubectl create -f -

configmap:
	kubectl create configmap caddyfile --from-file=Caddyfile --dry-run -o yaml \
	  | kubectl apply -f -

deploy: configmap
	kubectl apply -f kubernetes/ --recursive


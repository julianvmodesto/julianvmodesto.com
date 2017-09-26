
configmap:
	kubectl create configmap caddyfile --from-file=Caddyfile --dry-run -o yaml \
	  | kubectl apply -f -

deploy: configmap
	kubectl apply -f kubernetes/


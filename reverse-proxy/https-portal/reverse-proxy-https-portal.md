
## 0. ref

- link
  - https://github.com/SteveLTN/https-portal?tab=readme-ov-file

- GPT 만세


## 1. 기록

- 다음과 같이 하는데 안됨.
- 실제 도메인이 없어서 결국 안되는 것으로 보임

docker-compose.yml
```yml
version: '3'

services:
  https-portal:
    image: steveltn/https-portal:latest
    ports:
      - '80:80'
      - '443:443'
    environment:
      DOMAINS: "localhost -> http://whoami:80"
      FORCE_SELF_SIGNED: "true"
      #STAGE: "production" # 'staging'은 테스트용, 'production'은 실 서비스용
      STAGE: "staging"
    volumes:
      - https-portal-data:/var/lib/https-portal

  whoami:
    image: containous/whoami
    restart: always

volumes:
    https-portal-data: # Recommended, to avoid re-signing when upgrading HTTPS-PORTAL
```

- 다음 에러가 발생
```bash
localhost로 했는데도 안되 계속 다음 에러가 발생해

"""
RSA key ok
Signing certificates from https://acme-staging-v02.api.letsencrypt.org/directory ...
Parsing account key...
Parsing CSR...
Found domains: localhost
Getting directory...
Directory found!
Registering account...
Already registered! Account ID: https://acme-staging-v02.api.letsencrypt.org/acme/acct/186293194
Creating new order...
Traceback (most recent call last):
  File "/usr/bin/acme_tiny", line 199, in <module>
    main(sys.argv[1:])
  File "/usr/bin/acme_tiny", line 195, in main
    signed_crt = get_crt(args.account_key, args.csr, args.acme_dir, log=LOGGER, CA=args.ca, disable_check=args.disable_check, directory_url=args.directory_url, contact=args.contact, check_port=args.check_port)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/bin/acme_tiny", line 120, in get_crt
    order, _, order_headers = _send_signed_request(directory['newOrder'], order_payload, "Error creating new order")
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/bin/acme_tiny", line 60, in _send_signed_request
    return _do_request(url, data=data.encode('utf8'), err_msg=err_msg, depth=depth)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/bin/acme_tiny", line 46, in _do_request
    raise ValueError("{0}:\nUrl: {1}\nData: {2}\nResponse Code: {3}\nResponse: {4}".format(err_msg, url, data, code, resp_data))
ValueError: Error creating new order:
Url: https://acme-staging-v02.api.letsencrypt.org/acme/new-order
Data: b'{"protected": "eyJ1cmwiOiAiaHR0cHM6Ly9hY21lLXN0YWdpbmctdjAyLmFwaS5sZXRzZW5jcnlwdC5vcmcvYWNtZS9uZXctb3JkZXIiLCAiYWxnIjogIlJTMjU2IiwgIm5vbmNlIjogIlJtQUxjZF82V09MYlhyanFiTldtcnlRcktGNGtFcThIcDZwMjRxSDVueEQ1Z1VzVUM4SSIsICJraWQiOiAiaHR0cHM6Ly9hY21lLXN0YWdpbmctdjAyLmFwaS5sZXRzZW5jcnlwdC5vcmcvYWNtZS9hY2N0LzE4NjI5MzE5NCJ9", "payload": "eyJpZGVudGlmaWVycyI6IFt7InR5cGUiOiAiZG5zIiwgInZhbHVlIjogImxvY2FsaG9zdCJ9XX0", "signature": "RfcknL_QLj8bdyZNHGfxgXgsazs6HxSESv4jji35zDjNdDyItjgUio_k77ryd8nNQE7MUriItx8ea89cFLPI2XNgBzFYhGTAIlm-pa3xTrLdyutH7pC9-jAeoTVIaxjl5oIDkUPdBygJ_sNRNpfz_hL4DAbrkxjOZoTaKuKBtb7SfRIFfd4IKO2Buq2H7WbkQ4SmOlAlExaBOTZEJnGWXKMM5S_sZMUtiJnUARv-2VcvOM_oCAODVAywsGIZUU9hooY2bvSBzbSq8UKGS83uQyHL-hKEEdn1ZMqPyDS3jL-fWLiLZtXGrKzYOUChKxruQ00U2FQHlkwyRoJhJoXnBtolHLdA63XOOOZdDY22P23PkFI-42C7_M-QD54QabzTeMzgzYiK_7Gw9NeauPFhbFa5Jf0hVcWXqpI3oxcoY9y4bmwyCuSI8n3em5qunlyMld62LA1K9KtBkuy_yJQS8WE4dWiLyn7rUD74Bjf4YKg7Dtureg8NhZFCEy4MSKDr9R4MUyhU7Lh09KrU_tjmXOkyyz3TrgaI0ti0Ok2TTGPiAlXT_uFxiusGlDyd1z3JVpBJTeE7pbGC7XgoaTiFSqo680EzffQLnVFsWIEgXjNWeLBzTjarHbwfXAhnbmkzPzLkqVsT10nT8djgaFbZXHCAkuj6n0444V2U8Uv5ah4"}'
Response Code: 400
Response: {'type': 'urn:ietf:params:acme:error:rejectedIdentifier', 'detail': 'Invalid identifiers requested :: Cannot issue for "localhost": Domain name needs at least one dot', 'status': 400}
================================================================================
Failed to sign localhost.
Make sure your DNS is configured correctly and is propagated to this host
machine. Sometimes that takes a while.
================================================================================
Failed to obtain certs for localhost
cont-init: info: /etc/cont-init.d/20-setup exited 1
cont-init: info: running /etc/cont-init.d/30-set-docker-gen-status
cont-init: info: /etc/cont-init.d/30-set-docker-gen-status exited 0
cont-init: warning: some scripts exited nonzero
s6-rc: warning: unable to start service legacy-cont-init: command exited 1
/run/s6/basedir/scripts/rc.init: warning: s6-rc failed to properly bring all the services up! Check your logs (in /run/uncaught-logs/current if you have in-container logging) for more information.
/run/s6/basedir/scripts/rc.init: fatal: stopping the container.
s6-rc: info: service fix-attrs: stopping
s6-rc: info: service fix-attrs successfully stopped
s6-rc: info: service s6rc-oneshot-runner: stopping
s6-rc: info: service s6rc-oneshot-runner successfully stopped
"""
```

- gpt 답변.
```
🎯 정리
Self-Signed SSL을 원하면 → FORCE_SELF_SIGNED: "true" 사용.
Let's Encrypt SSL이 필요하면 → nip.io 같은 무료 도메인 사용.
```
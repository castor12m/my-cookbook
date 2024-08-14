mkdir -p ./git-block/kafka-test


# config single node
docker-compose -f ./docker-compose-singlenode.yaml up -d

# config 3 node
# docker-compose -f ./docker-compose-3node.yaml up -d
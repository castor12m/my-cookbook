
### 0. ref

https://medium.com/mo-zza/kafka-kraft-%EB%AA%A8%EB%93%9C-with-docker-%EB%8F%99%EB%AC%BC%EC%9B%90%EC%9D%84-%ED%83%88%EC%B6%9C%ED%95%9C-kafka-8b5e7c7632fa

### 1. docker-compose file 설정

```yaml
    version: '3.8'
services:
  kafka-1:
    container_name: kafka-1
    image: confluentinc/cp-kafka:7.5.3
    platform: linux/amd64
    ports:
      - "${KAFKA_1_PORT}:9092"
    volumes:
      - ./data/${KAFKA_DIR}/kafka-1:/var/lib/kafka/data
    environment:
      KAFKA_NODE_ID: 1
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: CONTROLLER:PLAINTEXT,INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT
      KAFKA_ADVERTISED_LISTENERS: INTERNAL://:29092,EXTERNAL://${DOCKER_HOST_IP:-127.0.0.1}:${KAFKA_1_PORT}
      KAFKA_LISTENERS: INTERNAL://:29092,CONTROLLER://:29093,EXTERNAL://0.0.0.0:${KAFKA_1_PORT}
      KAFKA_PROCESS_ROLES: 'broker,controller'
      KAFKA_CONTROLLER_QUORUM_VOTERS: 1@kafka-1:29093,2@kafka-2:29093,3@kafka-3:29093
      KAFKA_INTER_BROKER_LISTENER_NAME: INTERNAL
      KAFKA_CONTROLLER_LISTENER_NAMES: CONTROLLER
      CLUSTER_ID: ${KAFKA_CLUSTER_ID:-MkU3OEVBNTcwNTJENDM2Qk}

  kafka-2:
    container_name: kafka-2
    image: confluentinc/cp-kafka:7.5.3
    platform: linux/amd64
    ports:
      - "${KAFKA_2_PORT}:9093"
    volumes:
      - ./data/${KAFKA_DIR}/kafka-2:/var/lib/kafka/data
    environment:
      KAFKA_NODE_ID: 2
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: CONTROLLER:PLAINTEXT,INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT
      KAFKA_ADVERTISED_LISTENERS: INTERNAL://:29092,EXTERNAL://${DOCKER_HOST_IP:-127.0.0.1}:${KAFKA_2_PORT}
      KAFKA_LISTENERS: INTERNAL://:29092,CONTROLLER://kafka-2:29093,EXTERNAL://0.0.0.0:${KAFKA_2_PORT}
      KAFKA_PROCESS_ROLES: 'broker,controller'
      KAFKA_CONTROLLER_QUORUM_VOTERS: 1@kafka-1:29093,2@kafka-2:29093,3@kafka-3:29093
      KAFKA_INTER_BROKER_LISTENER_NAME: INTERNAL
      KAFKA_CONTROLLER_LISTENER_NAMES: CONTROLLER
      CLUSTER_ID: ${KAFKA_CLUSTER_ID:-MkU3OEVBNTcwNTJENDM2Qk}

  kafka-3:
    container_name: kafka-3
    image: confluentinc/cp-kafka:7.5.3
    platform: linux/amd64
    ports:
      - "${KAFKA_3_PORT}:9094"
    volumes:
      - ./data/${KAFKA_DIR}/kafka-3:/var/lib/kafka/data
    environment:
      KAFKA_NODE_ID: 3
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: CONTROLLER:PLAINTEXT,INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT
      KAFKA_ADVERTISED_LISTENERS: INTERNAL://:29092,EXTERNAL://${DOCKER_HOST_IP:-127.0.0.1}:${KAFKA_3_PORT}
      KAFKA_LISTENERS: INTERNAL://:29092,CONTROLLER://kafka-3:29093,EXTERNAL://0.0.0.0:${KAFKA_3_PORT}
      KAFKA_PROCESS_ROLES: 'broker,controller'
      KAFKA_CONTROLLER_QUORUM_VOTERS: 1@kafka-1:29093,2@kafka-2:29093,3@kafka-3:29093
      KAFKA_INTER_BROKER_LISTENER_NAME: INTERNAL
      KAFKA_CONTROLLER_LISTENER_NAMES: CONTROLLER
      CLUSTER_ID: ${KAFKA_CLUSTER_ID:-MkU3OEVBNTcwNTJENDM2Qk}

  kafka-ui:
    image: provectuslabs/kafka-ui
    platform: linux/amd64
    container_name: kafka-ui
    ports:
      - "${KAFKA_UI_PORT}:8080"
    restart: always
    environment:
      KAFKA_CLUSTERS_0_NAME: ${PROFILE:-local}
      KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS: kafka-1:29092,kafka-2:29092,kafka-3:29092
    depends_on:
      - kafka-1
      - kafka-2
      - kafka-3
```

```env
    KAFKA_1_PORT=9791
    KAFKA_2_PORT=9792
    KAFKA_3_PORT=9793
    KAFKA_UI_PORT=9780
    KAFKA_DIR=kafka-test
```

Kafka 설정은 링크에 들어가면 더 자세히 확인하실 수 있습니다.

KAFKA_NODE_ID : Kafka 노드 ID를 설정합니다. 노드 ID는 각 노드의 식별자 입니다. (Required for KRaft mode)
KAFKA_PROCESS_ROLES : 서버의 역할을 지정합니다. 서버는 controller, broker 혹은 둘의 역할을 다 할 수 있습니다. (Required for KRaft mode)
KAFKA_CONTROLLER_QUORUM_VOTERS : zookeeper.connect 와 대응하는 역할을 하고 있으며, Controller Quorum에 연결할 수 있는 노드를 결정합니다. 식별자는 {id}@{host}:{port} 로 구분을 합니다. (Required for KRaft mode)
KAFKA_CONTROLLER_LISTENER_NAMES : Zookeeper 모드 브로커는 이 값을 설정하면 안되며, Controller에서 사용하는 리스터 이름입니다. (Required for KRaft mode)
KAFKA_LISTENER_SECURITY_PROTOCOL_MAP : 리스너 별로 사용할 보안 프로토콜의 키/값 쌍입니다. 해당 코드에서는 모든 프로토콜이 PLAINTEXT와 쌍을 이루도록 설정을 하였습니다.
KAFKA_ADVERTISED_LISTENERS : Docker 내부에서 사용할 포트와 Docker 네트워크안에서 각 컨테이너에서 연결할 포트를 설정합니다.
KAFKA_LISTENERS : Kafka가 바인딩하는 {host}:{port} 로 구분을 한 목록입니다.
KAFKA_INTER_BROKER_LISTENER_NAME : 브로커 간 통신에 사용할 수신 이름을 정의합니다. 서로 통신을 할 때 필요한 매개변수 입니다.
CLUSTER_ID : 클러스터의 고류 식별자를 지정하는 문자열입니다. 동일한 클러스터에서 동작을 하기 때문에 같은 CLUSTER_ID 로 설정합니다.
Kafka-ui 구성하기
Kafka 브로커를 모니터링하거나 어드민으로 관리할 수 있는 툴이 필요합니다. CLI로도 충분히 관리를 할 수 있지만, GUI 툴을 통해서 관리를 용이하게 할 수 있습니다.



### 1. start


```bash
    docker-compose up -d
```

kafka-ui

http://localhost:9780/


## A. 기타사항

### A.1 Kafka에서 Zookeeper를 제거하는 이유는?

https://velog.io/@jaymin_e/Kafka-Zookeeper-%EC%97%86%EC%9D%B4-Kafka-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0

https://brunch.co.kr/@peter5236/19

#### A.1.1 기존 문제점 사항

Kafka 스케일링으로 인해 Zookeeper의 성능적 병목 현상이 발생했습니다. 즉, Kafka에는 Zookeeper와 관련하여 제한 사항이 있습니다.

Kafka Cluster는 제한된 수의 파티션만 제공합니다.(최대 200,000개)

Kafka Broker가 Cluster에 참여하거나 제거될때 다수의 Reader 선택이 발생해야 하며 이로 인해 Zookeeper에 과부하가 걸리고 Cluster 속도가 일시적으로 느려질 수 있습니다.

Kafka Cluster 설정은 어렵고 설정할 다른 구성 요소에 따라 다릅니다.

Kafka Cluster 메타데이터가 때때로 Zookeeper와 동기화되지 않습니다.

Zookeeper 보안은 Kafka 보안보다 뒤떨어져 있습니다.

Zookeeper를 제거한다는 것은 Kafka Controller 선택을 수행하기 위해 여전히 쿼럼 역할을 해야 함을 의미하므로 Kafka Broker는 Raft 프로토콜 구현하여 새로운 Kafka 메타데이터 쿼럼 모드(Quorum mode)에 KRaft라는 이름을 부여합니다.


#### A.1.2 Zookeeper 없는 방법 이점

- 수백만 개의 파티션으로 확장할 수 있고 유지 관리 및 설정이 용이
- 안정성 향상, 모니터링, 지원 및 관리가 쉬움
- Kafka를 시작하는 단일 프로세스
- 전체 시스템에 대한 단일 보안 모델
- 더 빠른 컨트롤러 종료 및 복구 시간


### A.2 kafka 컨테이너에서 명령어 결과 히스토리

https://dev-records.tistory.com/entry/%ED%8C%8C%EC%9D%B4%EC%8D%AC%EC%9C%BC%EB%A1%9C-Kafka-%EA%B0%84%EB%8B%A8%ED%95%9C-%EC%98%88%EC%A0%9C

```bash
  sh-4.4$ kafka-topics --list 
  Exception in thread "main" java.lang.IllegalArgumentException: --bootstrap-server must be specified
          at kafka.admin.TopicCommand$TopicCommandOptions.checkArgs(TopicCommand.scala:608)
          at kafka.admin.TopicCommand$.main(TopicCommand.scala:49)
          at kafka.admin.TopicCommand.main(TopicCommand.scala)

  sh-4.4$ kafka-topics --list --bootstrap-server localhost:9092
  purchases
  seven-si
  topic1
  topic2
  topic3-purchases

  sh-4.4$ kafka-topics --describe --topic topic1 --bootstrap-server localhost:9092
  Topic: topic1   TopicId: 2ihiMLXBSa-wPlthRDZ3Rw PartitionCount: 1       ReplicationFactor: 1    Configs: 
          Topic: topic1   Partition: 0    Leader: 1       Replicas: 1     Isr: 1
  sh-4.4$ 
```

```bash
  # 송신측 kafka 쉘 접속
  sh-4.4$ kafka-console-producer --bootstrap-server localhost:9092 --topic test
  >ok
  >sorry

  # 수신측 kafka 쉘 접속
  sh-4.4$ kafka-console-consumer --bootstrap-server localhost:9092 --topic test --from-beginning
  ok
  sorry
```

```bash
  sh-4.4$ kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group test-group

  Consumer group 'test-group' has no active members.

  GROUP           TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID     HOST            CLIENT-ID
  test-group      test            0          2               4               2               -               -               -
```
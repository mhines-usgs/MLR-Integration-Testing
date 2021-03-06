#!/bin/bash

OUTPUT_DIR="${OUTPUT_DIR:-`pwd`/tests/output}"
TESTS_DIR="${TESTS_DIR:-`pwd`/tests/integrations}"
JMETER_DOCKER_DIR="${JMETER_DOCKER_DIR:-`pwd`/jmeter-docker}"
DOCKER_NETWORK_NAME="${DOCKER_NETWORK_NAME:-mlr-it-net}"

docker run --rm \
  --network="${DOCKER_NETWORK_NAME}" \
  -v "${OUTPUT_DIR}:/tests/output/" \
  -v "${TESTS_DIR}:/tests/integrations/" \
  -v "${JMETER_DOCKER_DIR}/jmeter-master.properties:/jmeter/bin/user.properties" \
  -v "${JMETER_DOCKER_DIR}/config/rmi_keystore.jks:/jmeter/rmi_keystore.jks" \
  jmeter-base:latest jmeter \
    -f \
    -n \
    -e -o /tests/output/waterauth/jmeter-output/dash \
    -j /tests/output/waterauth/jmeter-output/jmeter-waterauth.log \
    -l /tests/output/waterauth/jmeter-output/jmeter-testing-waterauth.jtl \
    -JJMETER_OUTPUT_PATH=/tests/output/waterauth/test-output \
    -t /tests/integrations/waterauth/waterauth.jmx \
    -Rjmeter.server.1,jmeter.server.2,jmeter.server.3

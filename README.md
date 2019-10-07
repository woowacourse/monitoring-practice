# monitoring-practice
nagios, actuator를 활용하여 모니터링을 경험한다.

- 시스템 모니터링을 위한 모니터링 서비스(nagios기반의 OMD) 설치는 script/install_omd.sh를 통해 가능하다.

```
cd script
sudo chmod 755 install_omd.sh
./install_omd.sh
```

- Spring Actuator 프로젝트를 빌드하기 위해서는 java 설치가 필요하다.

```
cd script
sudo chmod 755 install_java.sh
./install_java.sh
```

- Spring Actuator를 빌드 후 실행한다.

```
./gradlew clean build
cd build/libs 
java -jar demo-0.0.1-SNAPSHOT.jar &
```

- 웹 브라우저에서 nagios, actuator 웹 페이지를 확인한다. 
  nagios의 웹페이지는 [Public IP]/woowa, actuator는 [Public IP]:8000이다.
  

- 모니터링할 대상 Client의 application.properties에 아래의 설정을 추가하고 빌드 후 실행한다. 

```
spring.boot.admin.client.url=http://localhost:8000
management.endpoints.web.exposure.include=*
```

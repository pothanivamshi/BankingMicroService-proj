# DevOps for Banking Microservices

This project demonstrates the implementation of DevOps practices for a banking microservice. It covers Git repository management, build automation with Maven, server provisioning using Ansible, and containerization with Docker.

---

## Prerequisites

Ensure the following are installed:
- **Git**
- **Docker** and **Docker Compose**
- **Maven**
- **Ansible**
- **Java 11 or higher**
- **Apache Tomcat (via Docker)**

---

## Project Structure

```plaintext
BankingMicroservice/
├── src/
│   ├── main/
│   │   └── java/com/bank/App.java
│   ├── test/
│       └── java/com/bank/AppTest.java
├── Dockerfile
├── docker-compose.yml
├── playbook/
│   ├── install_java_apache.yml
│   ├── setup_docker.yml
├── pom.xml
├── .gitignore
├── README.md
```

---

## Instructions

### 1. Git Repository Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/BankingMicroservice.git
   cd BankingMicroservice
   ```

2. Create branches for developers:
   ```bash
   git branch dev1
   git branch dev2
   ```

3. Switch to a branch, make changes, and push:
   ```bash
   git checkout dev1
   git add .
   git commit -m "Feature by Developer 1"
   git push origin dev1
   ```

4. Merge branches into `main`:
   ```bash
   git checkout main
   git merge dev1
   git merge dev2
   git push origin main
   ```

---

### 2. Maven Build Automation

1. Build the project:
   ```bash
   mvn clean package
   ```

2. Run unit tests:
   ```bash
   mvn test
   ```

3. Generate the `.jar` file:
   - The `.jar` file will be created in the `target/` directory.

---

### 3. Ansible Playbook Execution

1. Prepare production servers:
   - **Install Java and Apache**:
     ```bash
     ansible-playbook playbook/install_java_apache.yml
     ```
   - **Setup Docker and Docker Compose**:
     ```bash
     ansible-playbook playbook/setup_docker.yml
     ```

2. Start the Apache service on the client server:
   ```bash
   sudo systemctl start apache2
   ```

---

### 4. Docker Deployment

1. Build the Docker image:
   ```bash
   docker build -t banking-microservice:1.0 .
   ```

2. Run the Docker Compose file:
   ```bash
   docker-compose up -d
   ```

3. Verify the container:
   ```bash
   docker ps
   ```

---

### 5. Accessing the Application

1. **Tomcat Default Page**:
   - Open `http://<client-public-ip>:80` in your browser.

2. **Microservice Endpoint**:
   - Access `http://<ansible-controller-public-ip>:8000/hello`.

3. **Test with `curl`**:
   ```bash
   curl http://<public-ip>:8000/hello
   ```

---

### 6. Cleanup

To stop and remove the running Docker containers:
```bash
docker-compose down
```

---

## Output Validation

- **Maven Build**: Check the `target/` folder for the `.jar` file.
- **Docker Deployment**: Verify the application logs:
  ```bash
  docker logs <container-id>
  ```

---

# sofka-backend-developer-challenge

A Java backend developer technical challenge.

## Description
The solution consists of four Spring Boot projects:
- `ekumen-bank-clients`: the microservice that manages the client entity.
- `ekumen-bank-accounts`: the microservice that manages the accounts and account movements entities.
- `ekumen-eureka-server`: the microservice that offers service discovery.
- `ekumen-bank-cloud-gateway`: the API gateway.

## Files
- `BaseDatos.sql`: database script.
- `ekumen-bank.postman_collection.json`: Postman collection file.
- `ZX - 01 - develop-ekumen.postman_environment.json`: Postman environment file.
- `docker-compose.yml`: Docker Compose file.

## Prerequisites
1. Operating systems: Microsoft Windows | macOs, because "host.docker.internal" is used to access the host from the containers
2. Git
3. Docker | Docker Desktop

## Execution
```bash
# Clone the repository
git clone https://github.com/jueltter/sofka-backend-developer-challenge.git
# Change to the project folder
cd ./sofka-backend-developer-challenge
# Checkout the master branch
git checkout master
# Initialize submodules to download subprojects files
git submodule update --init --recursive
# Run Docker Compose
docker-compose up
```

## Testing
1. Import the Postman collection and enviroment files into your postman workspace.
2. Execute the requests.


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
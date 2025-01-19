# README: Deploying the LAMP Stack on Kubernetes

## Stack Type
LAMP (Linux, Apache, MySQL, PHP)

## Deployment Assumptions
- Namespace `lamp-stack` is used to isolate resources.
- MySQL is deployed as a StatefulSet with a PersistentVolumeClaim (PVC) to ensure data persistence.
- Deployment for the PHP/Apache server supports multiple replicas for scalability.
- Ingress allows access to the application via the `lamp.local` host.
- The MySQL root password is stored in a Secret object for security.

## Kubernetes Resources
- __Namespace__: `lamp-stack` isolates resources for the stack.
- __PersistentVolumeClaim__: `mysql-pvc` reserves 10Gi of storage for MySQL.
- __Secret__: `mysql-secret` stores the MySQL root password encoded in Base64.
- __ConfigMap__: `initdb-config` contains an SQL script to initialize the `test` database and the `messages` table.
- __ConfigMap__: `php-index` contains the PHP application code for interacting with MySQL.
- __StatefulSet__: `mysql-statefulset` manages the MySQL database instance.
- __Deployment__: `php-deployment` manages replicas of the Apache server with PHP.
- __Service__: `mysql` exposes the MySQL database within the cluster.
- __Service__: `php-service` exposes the PHP/Apache server within the cluster.
- __Ingress__: `lamp-ingress` handles HTTP traffic to the application via the `lamp.local` host.

## Deployment Steps

### Preparing the Environment
1. Start Minikube:
   ```bash
   minikube start
   ```
2. Enable Ingress in Minikube:
   ```bash
   minikube addons enable ingress
   ```

### Deploying the Stack
1. Apply the manifests using `deploy.sh` script:
   ```bash
   ./deploy.sh
   ```
2. Verify the deployment status:
   ```bash
   kubectl get all -n lamp-stack
   ```


### Configuring Access
1. Retrieve the Minikube IP address:
   ```bash
   minikube ip
   ```
2. Add the following entry to the `/etc/hosts` file on your local machine, replacing `<MINIKUBE_IP>` with the retrieved IP:
   ```
   <MINIKUBE_IP> lamp.local
   ```
3. Access the application in a browser at `http://lamp.local`.

## Testing the Deployment
1. Open the application in a browser at `http://lamp.local`.
2. Add a message through the interface.
3. Verify that the message appears in the list.

You can also simply verify proper displayment of preexisting messages using curl. Sample output from working application:
```bash
curl --resolve "lamp.local:80:$( minikube ip )" -i http://lamp.local/

HTTP/1.1 200 OK
Date: Sun, 19 Jan 2025 17:16:13 GMT
Content-Type: text/html; charset=UTF-8
Content-Length: 633
Connection: keep-alive
X-Powered-By: PHP/7.4.33
Vary: Accept-Encoding

<p>Replica Number: 68f54f9d4f</p>
  <!DOCTYPE html>
  <html>
  <head>
      <title>Message Board</title>
  </head>
  <body>
      <h1>Message Board</h1>
      <h2>Messages</h2>
      <ul>
          <li>user1: Hello, world!</li><li>user2: This is a test message.</li><li>user3: Another random message.</li>
      </ul>
      <form method="post" action="">
          Username: <input type="text" name="username" required>
          Message: <textarea name="message" required></textarea>
          <input type="submit" value="Send">
      </form>
        </body>
  </html>
```


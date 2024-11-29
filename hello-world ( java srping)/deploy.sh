#!/bin/bash

# Variables
PROJECT_DIR="C:/STUDI/Teraform/ECF_DevOps_Ete2025/hello-world"
VM_USER="ec2-user"          # Utilisateur SSH pour la VM
VM_HOST="15.188.55.198"  # Adresse IP ou domaine de la VM
VM_DEPLOY_DIR="/home/ec2-user/"  # Répertoire de déploiement sur la VM
JAR_NAME="hello-world-0.0.1-SNAPSHOT.jar"  # Nom de votre fichier JAR Spring Boot
PRIVATE_KEY_PATH="C:/Users/Zeryios/.ssh/my-new-key-aws.pem"

# Assurez-vous d'être dans le bon répertoire
cd $PROJECT_DIR || { echo "Le répertoire du projet n'existe pas."; exit 1; }

# Étape 2 : Construire l'application avec Maven
echo "### Construction et test du projet Java Spring Boot ###"
./mvnw clean install || { echo "Erreur lors de la construction du projet."; exit 1; }

# Étape 3 : Vérifier que le fichier JAR est généré
if [ ! -f "target/$JAR_NAME" ]; then
    echo "Erreur : Le fichier JAR n'a pas été généré."
    exit 1
fi

# Étape 4 : Effectuer les tests unitaires avec Maven
echo "### Exécution des tests ###"
./mvnw test || { echo "Erreur lors de l'exécution des tests."; exit 1; }



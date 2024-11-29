#!/bin/bash

# Vérifie si l'environnement React Native est configuré
echo "Vérification de l'environnement React Native..."
echo | npx react-native doctor

# Build et exécution en mode Debug
echo "Construction et lancement de l'application en mode Debug..."
npx react-native run-android


echo "Processus terminé!"

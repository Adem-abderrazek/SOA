# SOA

 TP3 – Gestion des Personnes 

Description du projet  
Ce projet consiste à développer une application web frontend permettant de consommer une API REST développée en Java JEE avec JAX-RS et déployée sur Apache Tomcat.  
L’application permet la gestion des personnes à travers les opérations CRUD : ajout, modification, suppression, recherche et affichage.  
Le frontend communique exclusivement avec le backend via des requêtes HTTP (GET, PUT, DELETE) en utilisant le format JSON.

Objectifs du projet  
- Comprendre et exploiter les services REST JAX-RS  
- Mettre en œuvre une architecture Client / Serveur  
- Développer une interface web dynamique  
- Consommer les services REST sans accès direct à la base de données  
  

Architecture globale  
Navigateur Web  
→ Frontend JSP / HTML / CSS / JavaScript  
→ API REST JAX-RS (Java JEE)  
→ Apache Tomcat 8.0.53  

Technologies utilisées  

Frontend  
- JSP (Java Server Pages)  
- HTML5  
- CSS3  
- JavaScript (AJAX – XMLHttpRequest)  

Backend  
- Java JEE  
- JAX-RS  
- Apache Tomcat 8.0.53  
- JSON  

Structure du projet  
tp3  
├── src  
│   └── main  
│       ├── java  
│       │   └── com.poly  
│       │       ├── Person.java  
│       │       ├── PersonService.java  
│       │       ├── PersonServiceImpl.java  
│       │       └── RestRouter.java  
│       ├── resources  
│       └── webapp  
│           ├── WEB-INF  
│           │   └── web.xml  
│           └── index.jsp  
├── pom.xml  
├── .gitignore  
└── README.md  



Endpoints REST utilisés  
GET    /affiche                  : afficher la liste des personnes  
PUT    /add/{age}/{name}          : ajouter une personne  
PUT    /update/{id}/{age}/{name}  : modifier une personne  
DELETE /remove/{id}               : supprimer une personne  
GET    /getid/{id}                : rechercher une personne par ID  
GET    /getname/{name}            : rechercher une personne par nom  
GET    /test                      : tester l’API  

Instructions pour exécuter le projet  

1. Démarrer le backend  
- Installer Apache Tomcat 8.0.53  
- Déployer le projet sur Tomcat  
- Démarrer le serveur  

Tester l’API REST :  
http://localhost:8080/testrest/rest/users/test  

2. Accéder à l’interface frontend  
Ouvrir un navigateur et accéder à :  
http://localhost:8080/testrest/  

Fonctionnalités réalisées  
- Ajout d’une personne avec validation des champs  
- Mise à jour des informations d’une personne  
- Suppression avec confirmation  
- Recherche par ID et par nom  
- Affichage dynamique de la liste des personnes  
- Console affichant les réponses de l’API REST  

Vidéo de démonstration  
https://drive.google.com/drive/folders/18RkYk9O6tIfNrZY2Ryj2TWmkuJqGnUSc?usp=sharing

Réalisé par  
Nom : adem abderrazek  & amen ben said 
 
Module : SOA / JAX-RS

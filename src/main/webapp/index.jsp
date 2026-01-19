<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TP3 - API REST JAX-RS</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Fraunces:wght@400;600;700;800&family=IBM+Plex+Mono:wght@400;500;600&family=Space+Grotesk:wght@400;500;600;700&display=swap');

        :root {
            --paper: #f7efe5;
            --paper-2: #f1d7bb;
            --ink: #1f1b16;
            --muted: #6e5c4c;
            --accent: #0f5b5b;
            --accent-2: #e07a5f;
            --accent-3: #f2b455;
            --card: #fffaf3;
            --border: #e6d2bd;
            --shadow: rgba(40, 25, 15, 0.16);
            --shadow-strong: rgba(40, 25, 15, 0.28);
            --radius: 22px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Space Grotesk', 'IBM Plex Sans', 'Noto Sans', sans-serif;
        }

        body {
            background: linear-gradient(120deg, var(--paper) 0%, var(--paper-2) 45%, #f6e9d9 100%);
            min-height: 100vh;
            padding: 24px;
            position: relative;
            overflow-x: hidden;
            color: var(--ink);
        }

        body::before {
            content: '';
            position: fixed;
            inset: -20% -10%;
            background:
                    radial-gradient(45% 45% at 12% 18%, rgba(15, 91, 91, 0.18) 0%, transparent 60%),
                    radial-gradient(40% 40% at 88% 8%, rgba(224, 122, 95, 0.18) 0%, transparent 60%),
                    radial-gradient(35% 35% at 92% 82%, rgba(242, 180, 85, 0.18) 0%, transparent 55%);
            pointer-events: none;
            z-index: 0;
        }

        body::after {
            content: '';
            position: fixed;
            inset: 0;
            background-image:
                    linear-gradient(90deg, rgba(31, 27, 22, 0.04) 1px, transparent 1px),
                    linear-gradient(0deg, rgba(31, 27, 22, 0.03) 1px, transparent 1px);
            background-size: 48px 48px;
            opacity: 0.25;
            pointer-events: none;
            z-index: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 250, 243, 0.96);
            border-radius: 28px;
            box-shadow:
                    0 35px 70px var(--shadow),
                    0 8px 18px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            border: 1px solid var(--border);
            position: relative;
            z-index: 1;
            animation: liftIn 0.7s ease both;
        }

        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--accent), var(--accent-2), var(--accent-3));
        }

        header {
            background: linear-gradient(135deg, #0f5b5b 0%, #d5644a 60%, #f2b455 100%);
            color: white;
            padding: 46px 24px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        header::before {
            content: '';
            position: absolute;
            inset: -60%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.18) 0%, transparent 60%);
            animation: drift 18s linear infinite;
        }

        @keyframes drift {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        header h1 {
            font-family: 'Fraunces', 'Georgia', serif;
            font-size: 2.7em;
            margin-bottom: 12px;
            font-weight: 700;
            position: relative;
            z-index: 1;
            text-shadow: 0 10px 30px rgba(18, 12, 8, 0.35);
            letter-spacing: -0.5px;
        }

        header p {
            position: relative;
            z-index: 1;
            font-size: 0.95em;
            text-transform: uppercase;
            letter-spacing: 4px;
            font-weight: 600;
            opacity: 0.85;
        }

        .main-content {
            padding: 32px;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .card {
            background: var(--card);
            border-radius: var(--radius);
            padding: 26px;
            box-shadow:
                    0 16px 35px rgba(40, 25, 15, 0.12),
                    inset 0 1px 0 rgba(255, 255, 255, 0.6);
            border: 1px solid var(--border);
            flex: 1;
            min-width: 300px;
            transition: all 0.35s ease;
            position: relative;
            overflow: hidden;
            animation: rise 0.65s ease both;
        }

        .card:nth-child(1) { animation-delay: 0.05s; }
        .card:nth-child(2) { animation-delay: 0.1s; }
        .card:nth-child(3) { animation-delay: 0.15s; }
        .card:nth-child(4) { animation-delay: 0.2s; }
        .card:nth-child(5) { animation-delay: 0.25s; }
        .card:nth-child(6) { animation-delay: 0.3s; }

        @keyframes liftIn {
            from { transform: translateY(18px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes rise {
            from { transform: translateY(12px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .card::after {
            content: '';
            position: absolute;
            top: 18px;
            right: -30px;
            width: 120px;
            height: 120px;
            background: radial-gradient(circle, rgba(224, 122, 95, 0.2), transparent 70%);
            opacity: 0.4;
        }

        .card:hover {
            transform: translateY(-6px);
            border-color: rgba(15, 91, 91, 0.4);
            box-shadow:
                    0 22px 45px var(--shadow-strong),
                    inset 0 1px 0 rgba(255, 255, 255, 0.7);
        }

        .card h2 {
            color: var(--accent);
            margin-bottom: 20px;
            font-size: 1.1em;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding-bottom: 12px;
            border-bottom: 2px solid rgba(15, 91, 91, 0.15);
            position: relative;
        }

        .card h2::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 64px;
            height: 2px;
            background: linear-gradient(90deg, var(--accent), var(--accent-2));
        }

        input {
            width: 100%;
            padding: 14px 18px;
            margin: 8px 0;
            border: 1px solid #d9c7b1;
            border-radius: 14px;
            font-size: 14px;
            transition: all 0.25s ease;
            background: #fff;
            color: var(--ink);
        }

        input::placeholder {
            color: #9c8370;
        }

        input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(15, 91, 91, 0.12);
        }

        .btn {
            padding: 12px 24px;
            margin: 5px;
            border: none;
            border-radius: 14px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 700;
            transition: all 0.25s ease;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            position: relative;
            overflow: hidden;
            color: #fff;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.25);
            transform: translate(-50%, -50%);
            transition: width 0.5s, height 0.5s;
        }

        .btn:hover::before {
            width: 260px;
            height: 260px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #0f5b5b 0%, #1b7f6e 100%);
            box-shadow: 0 10px 22px rgba(15, 91, 91, 0.25);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #e07a5f 0%, #d65d45 100%);
            box-shadow: 0 10px 22px rgba(224, 122, 95, 0.25);
        }

        .btn-info {
            background: linear-gradient(135deg, #2a7c6f 0%, #339b86 100%);
            box-shadow: 0 10px 22px rgba(42, 124, 111, 0.25);
        }

        .btn-warning {
            background: linear-gradient(135deg, #f2b455 0%, #d8922f 100%);
            box-shadow: 0 10px 22px rgba(242, 180, 85, 0.25);
        }

        .btn-danger {
            background: linear-gradient(135deg, #b24a3b 0%, #8f372a 100%);
            box-shadow: 0 10px 22px rgba(178, 74, 59, 0.25);
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn:active {
            transform: translateY(0) scale(0.96);
        }

        .persons-list {
            margin-top: 15px;
            max-height: 250px;
            overflow-y: auto;
        }

        .persons-list::-webkit-scrollbar {
            width: 6px;
        }

        .persons-list::-webkit-scrollbar-track {
            background: rgba(31, 27, 22, 0.08);
            border-radius: 10px;
        }

        .persons-list::-webkit-scrollbar-thumb {
            background: linear-gradient(180deg, var(--accent) 0%, var(--accent-2) 100%);
            border-radius: 10px;
        }

        .person-item {
            background: #fff5e7;
            border: 1px solid #e8d2bb;
            border-radius: 14px;
            padding: 16px;
            margin-bottom: 10px;
            transition: all 0.25s ease;
            border-left: 4px solid var(--accent-2);
            color: var(--ink);
            position: relative;
            overflow: hidden;
        }

        .person-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(15, 91, 91, 0.08), transparent);
            transition: left 0.4s;
        }

        .person-item:hover::before {
            left: 100%;
        }

        .person-item:hover {
            border-color: rgba(15, 91, 91, 0.4);
            box-shadow: 0 12px 24px rgba(40, 25, 15, 0.15);
            transform: translateX(6px);
        }

        .console {
            background: #fff1df;
            color: #4a3426;
            padding: 20px;
            border-radius: 14px;
            font-family: 'IBM Plex Mono', 'Fira Code', monospace;
            max-height: 250px;
            overflow-y: auto;
            white-space: pre-wrap;
            font-size: 12px;
            box-shadow: inset 0 2px 8px rgba(40, 25, 15, 0.1);
            border: 1px dashed #e1c3a3;
            position: relative;
        }

        .console::before {
            content: '';
            position: absolute;
            inset: 12px;
            border: 1px solid rgba(224, 122, 95, 0.2);
            border-radius: 10px;
            pointer-events: none;
        }

        .console::-webkit-scrollbar {
            width: 6px;
        }

        .console::-webkit-scrollbar-track {
            background: rgba(31, 27, 22, 0.08);
            border-radius: 10px;
        }

        .console::-webkit-scrollbar-thumb {
            background: var(--accent);
            border-radius: 10px;
        }

        footer {
            background: #f5e7d8;
            color: #6b5c4c;
            text-align: center;
            padding: 18px;
            margin-top: 20px;
            font-size: 0.9em;
            border-top: 1px solid var(--border);
        }

        .status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 10px;
            margin: 2px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            background: #f1e2d1;
            color: #3f2f22;
            border: 1px solid #e0c9b0;
        }

        .status-success {
            background: rgba(27, 127, 90, 0.14);
            color: #1b7f5a;
            border: 1px solid rgba(27, 127, 90, 0.4);
        }

        .status-error {
            background: rgba(178, 74, 59, 0.14);
            color: #b24a3b;
            border: 1px solid rgba(178, 74, 59, 0.4);
        }

        .status-info {
            background: rgba(15, 91, 91, 0.14);
            color: #0f5b5b;
            border: 1px solid rgba(15, 91, 91, 0.4);
        }

        .form-group {
            margin-bottom: 15px;
        }

        @media (max-width: 768px) {
            .card {
                min-width: 100%;
            }

            header h1 {
                font-size: 2em;
            }

            body {
                padding: 12px;
            }

            .main-content {
                padding: 18px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <header>
        <h1>Gestion des Personnes - TP3</h1>
        <p>API REST JAX-RS </p>
    </header>

    <div class="main-content">
        <!-- Formulaire d'ajout -->
        <div class="card">
            <h2>Ajouter une personne</h2>
            <div class="form-group">
                <input type="text" id="nameInput" placeholder="Nom" required>
                <input type="number" id="ageInput" placeholder="Âge" required>
                <button onclick="addPerson()" class="btn btn-primary">Ajouter</button>
            </div>
        </div>

        <!-- Formulaire de recherche -->
        <div class="card">
            <h2>Rechercher</h2>
            <div class="form-group">
                <input type="text" id="searchId" placeholder="ID">
                <button onclick="getPersonById()" class="btn btn-info">Par ID</button>
            </div>
            <div class="form-group">
                <input type="text" id="searchName" placeholder="Nom">
                <button onclick="getPersonByName()" class="btn btn-info">Par Nom</button>
            </div>
        </div>

        <!-- Formulaire de mise à jour -->
        <div class="card">
            <h2>Mettre à jour</h2>
            <div class="form-group">
                <input type="number" id="updateId" placeholder="ID">
                <input type="text" id="updateName" placeholder="Nouveau nom">
                <input type="number" id="updateAge" placeholder="Nouvel âge">
                <button onclick="updatePerson()" class="btn btn-warning">Mettre à jour</button>
            </div>
        </div>

        <!-- Suppression -->
        <div class="card">
            <h2>Supprimer</h2>
            <div class="form-group">
                <input type="number" id="deleteId" placeholder="ID à supprimer">
                <button onclick="deletePerson()" class="btn btn-danger">Supprimer</button>
            </div>
        </div>

        <!-- Liste des personnes -->
        <div class="card" style="flex: 2;">
            <h2>Liste des personnes</h2>
            <button onclick="getAllPersons()" class="btn btn-secondary">Rafraîchir la liste</button>
            <div id="personsList" class="persons-list">
                Chargement...
            </div>
        </div>

        <!-- Console -->
        <div class="card" style="flex: 2;">
            <h2>Réponses API</h2>
            <div id="responseConsole" class="console">
                Démarrage...
            </div>
        </div>
    </div>

    <footer>
        <p id="baseUrl">Tomcat 8.0.53 | TP JAX-RS | URL: Chargement...</p>
    </footer>
</div>

<script>
    // URL de l'API pour Tomcat
    var contextPath = window.location.pathname.split('/')[1];
    var apiBase = window.location.origin;
    if (contextPath) {
        apiBase += '/' + contextPath;
    }
    var API_URL = apiBase + '/rest/users';

    // Afficher l'URL
    document.getElementById('baseUrl').innerHTML =
        'Tomcat 8.0.53 | TP JAX-RS | URL: ' + API_URL;

    // Fonction pour logger
    function logResponse(method, endpoint, response, status) {
        var consoleDiv = document.getElementById('responseConsole');
        var timestamp = new Date().toLocaleTimeString();

        var statusClass = 'status-info';
        if (status >= 200 && status < 300) {
            statusClass = 'status-success';
        } else if (status >= 400) {
            statusClass = 'status-error';
        }

        var logEntry = '\n[' + timestamp + '] ' + method + ' ' + endpoint +
            '\nStatus: <span class="status ' + statusClass + '">' + status + '</span>' +
            '\nResponse: ' + JSON.stringify(response, null, 2) +
            '\n─────────────────────────────';

        consoleDiv.innerHTML = logEntry + consoleDiv.innerHTML;
    }

    // 1. Récupérer toutes les personnes
    function getAllPersons() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', API_URL + '/affiche', true);

        xhr.onload = function() {
            if (xhr.status === 200) {
                var persons = JSON.parse(xhr.responseText);
                logResponse('GET', '/affiche', persons, xhr.status);

                var personsList = document.getElementById('personsList');
                if (persons && persons.length > 0) {
                    var html = '';
                    for (var i = 0; i < persons.length; i++) {
                        var p = persons[i];
                        html += '<div class="person-item">' +
                            'ID: ' + p.id + ' | Nom: ' + p.name + ' | Âge: ' + p.age +
                            '</div>';
                    }
                    personsList.innerHTML = html;
                } else {
                    personsList.innerHTML = 'Aucune personne enregistrée';
                }
            } else {
                logResponse('GET', '/affiche', {error: xhr.statusText}, xhr.status);
                alert('Erreur: ' + xhr.status);
            }
        };

        xhr.onerror = function() {
            logResponse('GET', '/affiche', {error: 'Network error'}, 0);
            alert('Erreur réseau');
        };

        xhr.send();
    }

    // 2. Ajouter une personne
    function addPerson() {
        var name = document.getElementById('nameInput').value.trim();
        var age = document.getElementById('ageInput').value;

        if (!name || !age) {
            alert('Veuillez remplir tous les champs');
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('PUT', API_URL + '/add/' + age + '/' + encodeURIComponent(name), true);
        xhr.setRequestHeader('Accept', 'application/json');

        xhr.onload = function() {
            var result = JSON.parse(xhr.responseText);
            logResponse('PUT', '/add/' + age + '/' + name, result, xhr.status);

            if (result.state === 'ok') {
                document.getElementById('nameInput').value = '';
                document.getElementById('ageInput').value = '';
                getAllPersons();
                alert('Personne ajoutée avec succès!');
            } else {
                alert('Erreur: ' + result.message);
            }
        };

        xhr.onerror = function() {
            logResponse('PUT', '/add/' + age + '/' + name, {error: 'Network error'}, 0);
            alert('Erreur réseau');
        };

        xhr.send();
    }

    // 3. Rechercher par ID
    function getPersonById() {
        var id = document.getElementById('searchId').value.trim();

        if (!id) {
            alert('Veuillez entrer un ID');
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('GET', API_URL + '/getid/' + id, true);

        xhr.onload = function() {
            var result = JSON.parse(xhr.responseText);
            logResponse('GET', '/getid/' + id, result, xhr.status);

            if (result.state === 'ok') {
                var person = result.data;
                alert('Personne trouvée:\nID: ' + person.id + '\nNom: ' + person.name + '\nÂge: ' + person.age);
            } else {
                alert('Personne non trouvée');
            }
        };

        xhr.onerror = function() {
            logResponse('GET', '/getid/' + id, {error: 'Network error'}, 0);
            alert('Erreur réseau');
        };

        xhr.send();
    }

    // 4. Rechercher par nom
    function getPersonByName() {
        var name = document.getElementById('searchName').value.trim();

        if (!name) {
            alert('Veuillez entrer un nom');
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('GET', API_URL + '/getname/' + encodeURIComponent(name), true);

        xhr.onload = function() {
            var result = JSON.parse(xhr.responseText);
            logResponse('GET', '/getname/' + name, result, xhr.status);

            if (result.state === 'ok') {
                var person = result.data;
                alert('Personne trouvée:\nID: ' + person.id + '\nNom: ' + person.name + '\nÂge: ' + person.age);
            } else {
                alert('Personne non trouvée');
            }
        };

        xhr.onerror = function() {
            logResponse('GET', '/getname/' + name, {error: 'Network error'}, 0);
            alert('Erreur réseau');
        };

        xhr.send();
    }

    // 5. Mettre à jour
    function updatePerson() {
        var id = document.getElementById('updateId').value.trim();
        var name = document.getElementById('updateName').value.trim();
        var age = document.getElementById('updateAge').value;

        if (!id || !name || !age) {
            alert('Veuillez remplir tous les champs');
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('PUT', API_URL + '/update/' + id + '/' + age + '/' + encodeURIComponent(name), true);
        xhr.setRequestHeader('Accept', 'application/json');

        xhr.onload = function() {
            var result = JSON.parse(xhr.responseText);
            logResponse('PUT', '/update/' + id + '/' + age + '/' + name, result, xhr.status);

            if (result.state === 'ok') {
                document.getElementById('updateId').value = '';
                document.getElementById('updateName').value = '';
                document.getElementById('updateAge').value = '';
                getAllPersons();
                alert('Personne mise à jour avec succès');
            } else {
                alert('Erreur: ' + result.message);
            }
        };

        xhr.onerror = function() {
            logResponse('PUT', '/update/' + id + '/' + age + '/' + name, {error: 'Network error'}, 0);
            alert('Erreur réseau');
        };

        xhr.send();
    }

    // 6. Supprimer
    function deletePerson() {
        var id = document.getElementById('deleteId').value.trim();

        if (!id) {
            alert('Veuillez entrer un ID');
            return;
        }

        if (!confirm('Supprimer la personne ID ' + id + ' ?')) {
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('DELETE', API_URL + '/remove/' + id, true);
        xhr.setRequestHeader('Accept', 'application/json');

        xhr.onload = function() {
            var result = JSON.parse(xhr.responseText);
            logResponse('DELETE', '/remove/' + id, result, xhr.status);

            if (result.state === 'ok') {
                document.getElementById('deleteId').value = '';
                getAllPersons();
                alert('Personne supprimée avec succès');
            } else {
                alert('Erreur: ' + result.message);
            }
        };

        xhr.onerror = function() {
            logResponse('DELETE', '/remove/' + id, {error: 'Network error'}, 0);
            alert('Erreur réseau');
        };

        xhr.send();
    }

    // Charger au démarrage
    window.onload = function() {
        console.log('Tomcat 8.0.53 - Application démarrée');
        getAllPersons();
    };
</script>
</body>
</html>

<?php
// Paramètres de connexion à la base de données
$host = 'mariadb'; // L'adresse du serveur de base de données
$dbname = 'worpress'; // Le nom de ta base de données
$username = 'qalpesse'; // L'utilisateur de la base de données
$password = '244466666'; // Le mot de passe de l'utilisateur

try {
    // Création de la connexion PDO
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    
    // Configurer PDO pour lancer des exceptions en cas d'erreur
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "✅ Connexion à la base de données réussie !";
} catch (PDOException $e) {
    // En cas d'erreur de connexion, afficher un message
    echo "❌ Échec de la connexion à la base de données : " . $e->getMessage();
}
?>


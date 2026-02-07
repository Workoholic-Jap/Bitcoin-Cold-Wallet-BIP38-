<?php
$DB_HOST = getenv('BOOKS_DB_HOST') ?: 'localhost';
$DB_NAME = getenv('BOOKS_DB_NAME') ?: 'books';
$DB_USER = getenv('BOOKS_DB_USER') ?: 'root';
$DB_PASS = getenv('BOOKS_DB_PASS') ?: '';

$language = isset($_GET['lang']) ? strtoupper(trim($_GET['lang'])) : null;
$language = $language !== '' ? $language : null;

$pdo = null;
$error = null;
$books = [];
$languages = [];

try {
    $pdo = new PDO(
        "mysql:host={$DB_HOST};dbname={$DB_NAME};charset=utf8mb4",
        $DB_USER,
        $DB_PASS,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]
    );

    $languages = $pdo->query('SELECT DISTINCT language FROM books ORDER BY language')->fetchAll(PDO::FETCH_COLUMN);

    if ($language && in_array($language, $languages, true)) {
        $stmt = $pdo->prepare('SELECT * FROM books WHERE language = :language ORDER BY series, title');
        $stmt->execute(['language' => $language]);
        $books = $stmt->fetchAll();
    } else {
        $books = $pdo->query('SELECT * FROM books ORDER BY language, series, title')->fetchAll();
        $language = null;
    }
} catch (PDOException $exception) {
    $error = $exception->getMessage();
}

function cover_url(string $asin): string
{
    return "https://images-na.ssl-images-amazon.com/images/P/{$asin}.01._SX500_.jpg";
}

function amazon_url(string $asin): string
{
    return "https://www.amazon.de/dp/{$asin}";
}
?>
<!doctype html>
<html lang="de">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Amazon Bücher Übersicht</title>
    <link rel="stylesheet" href="css/books.css">
</head>
<body>
    <header class="page-header">
        <div class="container">
            <h1>Meine Amazon Bücher</h1>
            <p>Filtere nach Sprache und finde alle Taschenbuch-Ausgaben auf einen Blick.</p>
            <?php if ($languages) : ?>
                <nav class="language-filter">
                    <a class="filter-chip<?php echo $language === null ? ' active' : ''; ?>" href="index.php">Alle</a>
                    <?php foreach ($languages as $lang) : ?>
                        <a class="filter-chip<?php echo $language === $lang ? ' active' : ''; ?>" href="index.php?lang=<?php echo urlencode($lang); ?>">
                            <?php echo htmlspecialchars($lang, ENT_QUOTES, 'UTF-8'); ?>
                        </a>
                    <?php endforeach; ?>
                </nav>
            <?php endif; ?>
        </div>
    </header>

    <main class="container">
        <?php if ($error) : ?>
            <div class="alert">
                <strong>Fehler beim Laden der Datenbank.</strong>
                <p><?php echo htmlspecialchars($error, ENT_QUOTES, 'UTF-8'); ?></p>
                <p>Bitte prüfe die Zugangsdaten und dass die Tabelle <code>books</code> existiert.</p>
            </div>
        <?php elseif (!$books) : ?>
            <div class="alert">
                <strong>Keine Bücher gefunden.</strong>
                <p>Bitte Datenbank füllen oder Sprache zurücksetzen.</p>
            </div>
        <?php else : ?>
            <section class="grid">
                <?php foreach ($books as $book) : ?>
                    <article class="card">
                        <div class="cover">
                            <img src="<?php echo cover_url($book['asin']); ?>" alt="Cover von <?php echo htmlspecialchars($book['title'] ?: $book['series'], ENT_QUOTES, 'UTF-8'); ?>">
                            <span class="language-badge"><?php echo htmlspecialchars($book['language'], ENT_QUOTES, 'UTF-8'); ?></span>
                        </div>
                        <div class="card-body">
                            <h2><?php echo htmlspecialchars($book['title'] ?: $book['series'], ENT_QUOTES, 'UTF-8'); ?></h2>
                            <?php if (!empty($book['subtitle'])) : ?>
                                <p class="subtitle"><?php echo htmlspecialchars($book['subtitle'], ENT_QUOTES, 'UTF-8'); ?></p>
                            <?php endif; ?>
                            <?php if (!empty($book['description'])) : ?>
                                <p class="description"><?php echo nl2br(htmlspecialchars($book['description'], ENT_QUOTES, 'UTF-8')); ?></p>
                            <?php endif; ?>
                            <p class="asin">ASIN: <?php echo htmlspecialchars($book['asin'], ENT_QUOTES, 'UTF-8'); ?></p>
                        </div>
                        <div class="card-footer">
                            <a class="button" href="<?php echo amazon_url($book['asin']); ?>" target="_blank" rel="noopener">Zum Angebot</a>
                        </div>
                    </article>
                <?php endforeach; ?>
            </section>
        <?php endif; ?>
    </main>
</body>
</html>

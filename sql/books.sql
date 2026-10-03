CREATE DATABASE IF NOT EXISTS books CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE books;

DROP TABLE IF EXISTS series_translations;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS series;

CREATE TABLE series (
    id INT AUTO_INCREMENT PRIMARY KEY,
    series_key VARCHAR(120) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE series_translations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    series_id INT NOT NULL,
    language VARCHAR(10) NOT NULL,
    name VARCHAR(200) NOT NULL,
    UNIQUE KEY series_language_unique (series_id, language),
    CONSTRAINT fk_series_translation_series
        FOREIGN KEY (series_id) REFERENCES series (id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    series_id INT NOT NULL,
    title VARCHAR(200) DEFAULT NULL,
    subtitle VARCHAR(255) DEFAULT NULL,
    description TEXT DEFAULT NULL,
    asin VARCHAR(20) NOT NULL UNIQUE,
    language VARCHAR(10) NOT NULL,
    format VARCHAR(20) NOT NULL DEFAULT 'paperback',
    CONSTRAINT fk_books_series
        FOREIGN KEY (series_id) REFERENCES series (id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO series (id, series_key) VALUES
    (1, 'Knowledge Gap'),
    (2, 'Leben mit Links');

INSERT INTO series_translations (series_id, language, name) VALUES
    (1, 'DE', 'Wissenslücke'),
    (1, 'EN', 'Knowledge Gap'),
    (2, 'DE', 'Leben mit Links'),
    (2, 'EN', 'Life with a Wink'),
    (2, 'NL', 'Leven met een knipoog');

INSERT INTO books (series_id, title, subtitle, description, asin, language, format) VALUES
    (1, 'Strom', NULL, NULL, 'B0GLZBB5BD', 'DE', 'paperback'),
    (1, 'Strom', NULL, NULL, 'B0GLY99X85', 'EN', 'paperback'),
    (1, 'Strom', NULL, NULL, 'B0GLYNXFGV', 'ES', 'paperback'),
    (1, 'Einstein', NULL, NULL, 'B0GLZSTNWS', 'DE', 'paperback'),
    (1, 'Einstein', NULL, NULL, 'B0GLZRBFCQ', 'EN', 'paperback'),
    (1, 'Einstein', NULL, NULL, 'B0GLZNWWLH', 'ES', 'paperback'),
    (2, 'Parken', NULL, NULL, 'B0FVM8H7XJ', 'DE', 'paperback'),
    (2, 'Parken', NULL, NULL, 'B0FTX388L2', 'EN', 'paperback'),
    (2, 'Parken', NULL, NULL, 'B0FTW32PBK', 'ES', 'paperback'),
    (2, 'Parken', NULL, NULL, 'B0FVVBRQ7C', 'PT', 'paperback'),
    (2, 'Parken', NULL, NULL, 'B0FTZRK1ZH', 'FR', 'paperback'),
    (2, 'Parken', NULL, NULL, 'B0FVM8NHVV', 'IT', 'paperback'),
    (2, 'Parken', NULL, NULL, 'B0FTTCFL31', 'SV', 'paperback'),
    (2, 'Parken', NULL, NULL, 'B0FVNJ22JX', 'NL', 'paperback'),
    (2, 'Technik', NULL, NULL, 'B0FVVZFNG6', 'DE', 'paperback'),
    (2, 'Technik', NULL, NULL, 'B0FVVXL7ZY', 'EN', 'paperback'),
    (2, 'Technik', NULL, NULL, 'B0FVWNN86L', 'ES', 'paperback'),
    (2, 'Technik', NULL, NULL, 'B0FVVC6H6Q', 'PT', 'paperback'),
    (2, 'Technik', NULL, NULL, 'B0FW71VST3', 'FR', 'paperback'),
    (2, 'Technik', NULL, NULL, 'B0FWB441RS', 'IT', 'paperback'),
    (2, 'Technik', NULL, NULL, 'B0FW6P1D51', 'SV', 'paperback'),
    (2, 'Technik', NULL, NULL, 'B0FW6GYYRK', 'NL', 'paperback'),
    (2, 'Reisen', NULL, NULL, 'B0FWKK7RJ6', 'DE', 'paperback'),
    (2, 'Reisen', NULL, NULL, 'B0FWC7DG94', 'EN', 'paperback'),
    (2, 'Reisen', NULL, NULL, 'B0FXBFV2RP', 'ES', 'paperback'),
    (2, 'Reisen', NULL, NULL, 'B0FXBDL4W3', 'PT', 'paperback'),
    (2, 'Reisen', NULL, NULL, 'B0FXBKGC2Z', 'FR', 'paperback'),
    (2, 'Reisen', NULL, NULL, 'B0FXBGDVTF', 'IT', 'paperback'),
    (2, 'Reisen', NULL, NULL, 'B0FXBCSGHP', 'SV', 'paperback'),
    (2, 'Reisen', NULL, NULL, 'B0FXB5M1YT', 'NL', 'paperback'),
    (2, 'Kundendienst', NULL, NULL, 'B0FY2GTVBH', 'DE', 'paperback'),
    (2, 'Kundendienst', NULL, NULL, 'B0FXRFL61D', 'EN', 'paperback'),
    (2, 'Kundendienst', NULL, NULL, 'B0FY39PNS4', 'ES', 'paperback'),
    (2, 'Kundendienst', NULL, NULL, 'B0FY32TM8D', 'PT', 'paperback'),
    (2, 'Kundendienst', NULL, NULL, 'B0FY2P1PTX', 'FR', 'paperback'),
    (2, 'Kundendienst', NULL, NULL, 'B0FY38ZYBQ', 'IT', 'paperback'),
    (2, 'Kundendienst', NULL, NULL, 'B0FY36DLKC', 'SV', 'paperback'),
    (2, 'Kundendienst', NULL, NULL, 'B0FY2GX6H6', 'NL', 'paperback'),
    (2, 'Nachbarn', NULL, NULL, 'B0FZHBF28C', 'DE', 'paperback'),
    (2, 'Nachbarn', NULL, NULL, 'B0FT1D19Y2', 'EN', 'paperback'),
    (2, 'Nachbarn', NULL, NULL, 'B0FZHR1373', 'ES', 'paperback'),
    (2, 'Nachbarn', NULL, NULL, 'B0FZHFCM7G', 'PT', 'paperback'),
    (2, 'Nachbarn', NULL, NULL, 'B0FZHMJ25C', 'FR', 'paperback'),
    (2, 'Nachbarn', NULL, NULL, 'B0FYW5KQTN', 'IT', 'paperback'),
    (2, 'Nachbarn', NULL, NULL, 'B0FZHQ1J19', 'SV', 'paperback'),
    (2, 'Nachbarn', NULL, NULL, 'B0FYQF725J', 'NL', 'paperback'),
    (2, 'Finanzen', NULL, NULL, 'B0G1BRXKXK', 'DE', 'paperback'),
    (2, 'Finanzen', NULL, NULL, 'B0G1K7R5V2', 'EN', 'paperback'),
    (2, 'Finanzen', NULL, NULL, 'B0G1K4JG3H', 'ES', 'paperback'),
    (2, 'Finanzen', NULL, NULL, 'B0G1K8LLW6', 'PT', 'paperback'),
    (2, 'Finanzen', NULL, NULL, 'B0G1K4C4TL', 'FR', 'paperback'),
    (2, 'Finanzen', NULL, NULL, 'B0G1K7XRX5', 'IT', 'paperback'),
    (2, 'Finanzen', NULL, NULL, 'B0G1JT7BTG', 'SV', 'paperback'),
    (2, 'Finanzen', NULL, NULL, 'B0G1K8B75J', 'NL', 'paperback'),
    (2, 'Behörden', NULL, NULL, 'B0G2YVNNLQ', 'DE', 'paperback'),
    (2, 'Behörden', NULL, NULL, 'B0G2YF4DDF', 'EN', 'paperback'),
    (2, 'Behörden', NULL, NULL, 'B0G2YM5GHF', 'ES', 'paperback'),
    (2, 'Behörden', NULL, NULL, 'B0G2YMFD8G', 'PT', 'paperback'),
    (2, 'Behörden', NULL, NULL, 'B0G2YKGLP4', 'FR', 'paperback'),
    (2, 'Behörden', NULL, NULL, 'B0G2YLSQG3', 'IT', 'paperback'),
    (2, 'Behörden', NULL, NULL, 'B0G2YSNVVD', 'SV', 'paperback'),
    (2, 'Behörden', NULL, NULL, 'B0G33H6BCJ', 'NL', 'paperback'),
    (2, 'Dating', NULL, NULL, 'B0G3XCF73Q', 'DE', 'paperback'),
    (2, 'Dating', NULL, NULL, 'B0GM5YSVB3', 'EN', 'paperback'),
    (2, 'Dating', NULL, NULL, 'B0G3XBK7LY', 'ES', 'paperback'),
    (2, 'Dating', NULL, NULL, 'B0G3XBNHV7', 'PT', 'paperback'),
    (2, 'Dating', NULL, NULL, 'B0G3VMQ7Y8', 'FR', 'paperback'),
    (2, 'Dating', NULL, NULL, 'B0G3XCGQ83', 'IT', 'paperback'),
    (2, 'Dating', NULL, NULL, 'B0G3XD4N7C', 'SV', 'paperback'),
    (2, 'Dating', NULL, NULL, 'B0G3WGDWPM', 'NL', 'paperback'),
    (2, 'Gericht', NULL, NULL, 'B0G5FG453Y', 'DE', 'paperback'),
    (2, 'Gericht', NULL, NULL, 'B0G58PWWPK', 'EN', 'paperback'),
    (2, 'Gericht', NULL, NULL, 'B0G58WXJKS', 'ES', 'paperback'),
    (2, 'Gericht', NULL, NULL, 'B0G593ZQYT', 'PT', 'paperback'),
    (2, 'Gericht', NULL, NULL, 'B0G58YG8GQ', 'FR', 'paperback'),
    (2, 'Gericht', NULL, NULL, 'B0G58XQ33H', 'IT', 'paperback'),
    (2, 'Gericht', NULL, NULL, 'B0G5F5S8MS', 'SV', 'paperback'),
    (2, 'Gericht', NULL, NULL, 'B0G58SRN3G', 'NL', 'paperback'),
    (2, 'Gesundheit', NULL, NULL, 'B0GCGXLDBL', 'DE', 'paperback'),
    (2, 'Gesundheit', NULL, NULL, 'B0GCH5B5JR', 'EN', 'paperback'),
    (2, 'Gesundheit', NULL, NULL, 'B0GCHRCG58', 'ES', 'paperback'),
    (2, 'Gesundheit', NULL, NULL, 'B0GCH6W2D8', 'PT', 'paperback'),
    (2, 'Gesundheit', NULL, NULL, 'B0GCJNW756', 'FR', 'paperback'),
    (2, 'Gesundheit', NULL, NULL, 'B0GCHWKHLN', 'IT', 'paperback'),
    (2, 'Gesundheit', NULL, NULL, 'B0GCH6XH99', 'SV', 'paperback'),
    (2, 'Gesundheit', NULL, NULL, 'B0GCHW9LDK', 'NL', 'paperback'),
    (2, 'Familie', NULL, NULL, 'B0GFLPSRJ3', 'DE', 'paperback'),
    (2, 'Familie', NULL, NULL, 'B0GFJV4SFF', 'EN', 'paperback'),
    (2, 'Familie', NULL, NULL, 'B0GFK23NS4', 'ES', 'paperback'),
    (2, 'Familie', NULL, NULL, 'B0GFLF6J8Z', 'PT', 'paperback'),
    (2, 'Familie', NULL, NULL, 'B0GFLR1GM9', 'FR', 'paperback'),
    (2, 'Familie', NULL, NULL, 'B0GFK7VN2Y', 'IT', 'paperback'),
    (2, 'Familie', NULL, NULL, 'B0GFLWVVYR', 'SV', 'paperback'),
    (2, 'Familie', NULL, NULL, 'B0GFK8R23T', 'NL', 'paperback'),
    (2, 'Ausreden', NULL, NULL, 'B0GD7DHJFH', 'DE', 'paperback'),
    (2, 'Ausreden', NULL, NULL, 'B0GD62D964', 'EN', 'paperback'),
    (2, 'Ausreden', NULL, NULL, 'B0GD7893MV', 'ES', 'paperback'),
    (2, 'Ausreden', NULL, NULL, 'B0GD76W5FM', 'PT', 'paperback'),
    (2, 'Ausreden', NULL, NULL, 'B0GD7CDMSS', 'FR', 'paperback'),
    (2, 'Ausreden', NULL, NULL, 'B0GD7M48ZF', 'IT', 'paperback'),
    (2, 'Ausreden', NULL, NULL, 'B0GD7GSNMR', 'SV', 'paperback'),
    (2, 'Ausreden', NULL, NULL, 'B0GD7CCPQY', 'NL', 'paperback');
